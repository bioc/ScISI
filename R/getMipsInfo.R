getMipsInfo <- function(wantDefault = TRUE,
                        toGrep = NULL,
                        parseType = NULL,
                        eCode = c("901.01.03",
                          "901.01.03.01",
                          "901.01.03.02",
                          "901.01.04",
                          "901.01.04.01",
                          "901.01.04.02",
                          "901.01.05",
                          "901.01.05.01",
                          "901.01.05.02",
                          "902.01.09.02",
                          "902.01.01.02.01.01",
                          "902.01.01.02.01.01.01",
                          "902.01.01.02.01.01.02",
                          "902.01.01.02.01.02",
                          "902.01.01.02.01.02.01",
                          "902.01.01.02.01.02.02",
                          "902.01.01.04",
                          "902.01.01.04.01",
                          "902.01.01.04.01.01",
                          "902.01.01.04.01.02",
                          "902.01.01.04.01.03",
                          "902.01.01.04.02",
                          "901.01.09.02"),
                        wantSubComplexes = TRUE,
                        ht=FALSE, dubiousGenes = NULL){

  fileToRead <- gzfile(system.file("extdata", "complexcat_data_18052006.gz", package="ScISI"), open = "rb")
  dataY = do.call("rbind", strsplit(gsub("\\|$", "||", scan(fileToRead, what = "")), split = "|", fixed = TRUE))
  close(fileToRead)

  if(!is.null(eCode)){
      codes = as.vector(dataY[,3])
      codesL = strsplit(codes, split = ",")

      w = vector()
      
      v = vector()
      for(q in 1:length(codesL)){

        if(length(codesL[[q]]) != 0){
          if (length(setdiff(codesL[[q]], eCode)) == 0){
            v = c(v, q)
          }
        }
      }
      w = unique(c(w,v))
      if(length(w) != 0){
        dataY = dataY[-w,]
      }
  }



  if (nrow(dataY) != 0){
      mipsYeastComplex = split(dataY[,1], dataY[,2])
    }
  else{
      stop("There are no proteins for which to populate the protein complexes")
  }

      
  protInComp <- readLines(system.file("extdata", "complexcat.scheme", package="ScISI"))
  protInComp <- protInComp[-(which(protInComp==""))]
  protInComp <- protInComp[-(which(protInComp==" "))]
  protInComp1 <- strsplit(protInComp, "   +")
  
  ##Get the MIPS ID and their descriptions
  id <- sapply(protInComp1, function(x) x[1])
  
  desc <- sapply(protInComp1, function(x) x[2])

  names(desc) <- id
  

  pattern = c("\\b[Cc]omplex\\b","\\Base\\b","\\Bsome\\b", "\\Bmer\\b")
  parseT = rep("grep", length(pattern))
  theDefault = vector("list", length = length(pattern))

  if(wantDefault == TRUE){
      for(i in 1:length(pattern)){
          theDefault[[i]]$pattern = pattern[i]
          theDefault[[i]]$x = desc
          if(parseT[i] == "grep"){
              theDefault[[i]]$perl = TRUE
          }
      }
  }

  if (!is.null(parseType) && !is.null(toGrep)){

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
          toGrep[[j]]$x = desc
          if(parseType[j] == "grep"){
              toGrep[[j]]$perl = TRUE
          }
      }
  }


  grepL = c(theDefault, toGrep)
  parseType = c(parseT, parseType)
  parsed = list()
  parsed2minus = list()

  for(i in 1:length(grepL)){
      parsed[[i]] = id[do.call(parseType[i], grepL[[i]], quote=TRUE)]
      
      parsed2minus[[i]] = id[grep("\\b[Cc]omplexes\\b", desc, perl=TRUE)]
      
      parsed[[i]] = setdiff(parsed[[i]], parsed2minus[[i]])
      
  }

  parsed = unlist(parsed)
  parsed = unique(parsed)

  if(wantSubComplexes == FALSE){
    toDel = vector()
    for (j in 1:length(parsed)){
      index = grep(paste("^",parsed[j], "\\.", sep=""), parsed)
      toDel = c(toDel, index)
    }
    toDel = unique(toDel)
    parsed <- parsed[-toDel]

  }
  
  compId2 = parsed

  desc = desc[compId2]

  
  
  MipList <- list()

  mipsYeastComplex <- lapply(mipsYeastComplex, as.vector)
  nam = names(mipsYeastComplex)
  
  

  ##This for loop will find the hierarchical structure for one particular
  ##complex, -ase, -some so we can put together the protein complex
  for (i in 1:length(compId2)){

      
      indices1 = grep(paste("^", compId2[i], "$", sep=""), nam, perl=TRUE)


      indices2 = grep(paste("^", compId2[i], "\\.", sep=""), nam, perl=TRUE)
      indices = c(indices1, indices2)



    ##We take the indices above and systematically build the protein complexes
    components = vector()
    if(length(indices) > 0){
      for (j in 1:length(indices)){
        components = c(components, mipsYeastComplex[[nam[indices[j]]]])

      }
    }
      MipList[[paste("MIPS-",compId2[i], sep="")]] = components
      ##MipList[[compId2[i]]] = components
    
  }

  MipList <- lapply(MipList, toupper)
  
  load(system.file("data","nonGenes.rda",package="ScISI"))
  dubious <- c(nonGenes, dubiousGenes)
  MipList <- lapply(MipList, function(l) {setdiff(l, dubious)})
  
  isUnit = sapply(MipList, function(u) length(u) == 1)
  MipList = MipList[!isUnit]

  desc = desc[!isUnit]

  isZero = sapply(MipList, function(u) length(u) == 0)
  
  MipList = MipList[!isZero]
  desc = desc[!isZero]

  if(!ht){
    apms <- sapply(strsplit(names(MipList), "\\."), function(x) x[1]) == "MIPS-550"
    
    MipList = MipList[!apms]
    desc = desc[!apms]}
  
  mipsFinalList <- mapply(function(x,y) {attributes(x) <- list(desc = y); return(x)}, MipList, desc)
  
  #inPutforCreate = list()
  #inPutforCreate$Mips = MipList
  #inPutforCreate$DESC = desc
  #inPutforCreate$test <- t
  #inPutforCreate

  mipsFinalList
}
