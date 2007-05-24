getGOInfo <- function(wantDefault = TRUE,
                      toGrep = NULL, parseType = NULL,
                      eCode = NULL, wantAllComplexes=TRUE,
                      includedGOTerms=NULL, not2BeIncluded=NULL){

  if(length(intersect(includedGOTerms, not2BeIncluded)) > 0)
    stop("You have at least one GO term you want both included and
          not included!")

  #options(error=recover)
  ##This first section of code sets up the stage for parsing through the
  ##GO database.
  xx = names(as.list(GOTERM))
  gt <- getGOTerm(xx)
  gtcc <- gt$CC
  yy <- as.list(YEASTGO2PROBE)
  Grepl = list()

  ##The pattern and parseT is used for the default searches
  pattern = c("complex", "\\Base\\b", "\\Bsome\\b", "\\Bmer\\b")
  parseT = c("agrep","grep","grep", "grep")
  theDefault = vector("list", length = length(pattern))

  if(wantDefault){
    for(i in 1:length(pattern)){
      theDefault[[i]]$pattern = pattern[i]
      theDefault[[i]]$x = gtcc
      if(parseT[i] == "grep"){
        theDefault[[i]]$perl = TRUE
      }
    }
  }
  


  if(!is.null(parseType)  && !is.null(toGrep)){
      if(length(parseType) != 1 &&
         length(parseType) == length(toGrep)){
          stop("The length of parseType must be a singleton or
            equal to the number the patterns.")
      }
      
      if(length(parseType) == 1){
        
          pType = rep(parseType, length(toGrep))
          parseType = pType
          
      }
      
      for(j in 1:length(toGrep)){
          toGrep[[j]]$x = gtcc
          if(parseType[j] == "grep"){
              toGrep[[j]]$perl = TRUE
          }
      }
  }



    grepL = c(theDefault, toGrep)
    parseType = c(parseT, parseType)
    parsed = list()
    for(i in 1:length(grepL)){
      parsed[[i]] = gtcc[do.call(parseType[i], grepL[[i]], quote=TRUE)]
    }
    these <- lapply(parsed, function(y) which(names(y) %in% names(yy)))
    num = 1:length(these)
    cMembersL = lapply(num, function(z) mget(names(parsed[[z]])[these[[z]]],
      env=YEASTGO2PROBE, ifnotfound=NA))

    goNames = sapply(cMembersL, function(w) names(w))
    newGoNames = vector()
    newCMembers = list()

    for (j in 1:length(cMembersL)){
      newCMembers = c(newCMembers, cMembersL[[j]])
      newGoNames = c(newGoNames, goNames[[j]])
    }

        newGoNames = unique(newGoNames)
  
        cMembers = newCMembers[newGoNames]


    if(wantAllComplexes){

        ##We also take the children of the GO protein complexes and add them
        ##if the user wants all complexes. It is not clear if these nodes are
        ##indeed protein complexes though
        GOkids <- mget(names(cMembers),env=GOCCCHILDREN,ifnotfound=NA)
        isNA <- sapply(GOkids, function(x) is.na(x[1]))
        GOkids <- GOkids[!isNA]
        alsoThese <- which(unlist(GOkids) %in% names(yy))

        comp = list()
        for (i in 1:length(parsed)){
          comp = c(comp, parsed[[i]])
        }
        moreCMembers <- mget(names(comp)[alsoThese], env=YEASTGO2PROBE,
                             ifnotfound=NA)


        ##GO:0043234 is the node referring to Protein Complex
        ##Must check to see if all the children have "is a" edge
        pComplex = GOCCCHILDREN[["GO:0043234"]]

        ##Combine into one set
        moreNames = unique(union(union(names(cMembers), names(moreCMembers)),
          names(pComplex)))
        moreCMembers = c(cMembers, moreCMembers, pComplex)
        pComp = moreCMembers[moreNames]
      }

  
    else{
      pComp <- cMembers
    }
    
    
    if(!is.null(eCode)){
      ##This part allows us to drop any protein from the protein complexe
      ##if the only evidence codes reference it is given by the user as
      ##codes to be eliminated
      yg = as.list(YEASTGO)
      
      yg1 = lapply(yg, function(x) dropECode(x, eCode))
     
      isZero = sapply(yg1, function(y) length(y) == 0)
      yg2 = yg1[!isZero]

      protKept = names(yg2)
      ##The rmByEvi removes those proteins from each protein complex
      pComp = lapply(pComp, function(w) {w = rmByEvi(protKept, w)})
    }
    
    
    pComp = lapply(pComp, function(y) y = unique(y))
    
  if(is.null(includedGOTerms)){
    load(system.file("data", "xtraGO.rda", package="ScISI"))
    xg <- yy[xtraGO][!sapply(yy[xtraGO], is.null)]
    xg <- xg[!(names(xg)%in%names(pComp))]
  }
  else{
    xg <- yy[xtraGO][!sapply(yy[includedGOTerms], is.null)]
    xg <- xg[!(names(xg)%in%names(pComp))]
  }

  pComp <- c(pComp, xg)
  
  load(system.file("data","unwanted.rda",package="ScISI"))
  disallow <- c(unwanted, not2BeIncluded)
  allow <- setdiff(names(pComp), disallow)
  
  pComp <- pComp[allow]
  

  
  ##Removes those complexes with singleton or no proteins.
  isUnit = sapply(pComp, function(w) length(w) == 1)
  pComp = pComp[!isUnit]
  isZero = sapply(pComp, function(w) length(w) == 0)
  pComp = pComp[!isZero]
  
  pComp2 <- mapply(function(x,y) {z <- gtcc[y]; names(z) <- NULL;
                                  attributes(x) <- list(desc = z); return(x)},
                   pComp, names(pComp))

}
