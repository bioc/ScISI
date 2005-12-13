getMipsInfo <- function(wantDefault = TRUE, toGrep = NULL,
                        parseType = NULL, wantAllComplexes=FALSE){
  ##options(error=recover)
  ##This file is specific towards the downloaded data file from the MIPS repository.
  ##Since the file updated every six months (and it appears that the files are
  ##not created completely identical) this file must be modified as well.
  fileToRead <- gzfile(system.file("extdata", "complexcat_data_14112005.gz", package="ScISI"))
  dataY = read.table(fileToRead, sep = "|")
  mipsYeastComplex = split(dataY$V1, dataY$V2)
      
  protInComp <- readLines(system.file("extdata", "complexcat.scheme.edit", package="ScISI"))
  protInComp <- protInComp[-(which(protInComp==""))]
  protInComp <- protInComp[-(which(protInComp==" "))]
  protInComp1 <- strsplit(protInComp, "   +")

  ##Get the MIPS ID and their descriptions
  id <- sapply(protInComp1, function(x) x[1])
  desc <- sapply(protInComp1, function(x) x[2])
  names(desc) <- id
  #print(id)

  pattern = c("complex\\b","\\Base\\b","\\Bsome\\b")
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
      parsed2minus[[i]] = id[grep("complexes\\b", desc, perl=TRUE)]
      parsed[[i]] = setdiff(parsed[[i]], parsed2minus[[i]])
      if(wantAllComplexes == FALSE){
          for(j in 1:length(parsed[[i]])){
              index = grep(paste("^",parsed[[i]][j],sep=""), parsed[[i]])
              if(length(index) > 1){
                  parsed[[i]] = parsed[[i]][-(index[2:length(index)])]
              }
          }
      }
  }
  
  compId2 = NULL
  for (k in 1:length(parsed)){
      compId2 = union(compId2, parsed[[k]])
      
  }

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

  isUnit = sapply(MipList, function(u) length(u) == 1)
  MipList = MipList[!isUnit]
  desc = desc[!isUnit]
  isZero = sapply(MipList, function(u) length(u) == 0)
  MipList = MipList[!isZero]
  desc = desc[!isZero]
  
  inPutforCreate = list()
  inPutforCreate$Mips = MipList
  inPutforCreate$DESC = desc
  inPutforCreate
}
