createScISI <- function(pathToSave=NULL, filter=FALSE, Gavin02 = FALSE
                        Ho02 = FALSE, Krogan04 = FALSE, Gavin06 = FALSE
                        Krogan06 = FALSE){

  library(apComplex)
  library(ppiStats)
  library(ppiData)
  library(ScISI)
  
  goECodes = c("IEA", "NAS", "ND", "NR")
  go = getGOInfo(wantDefault = TRUE, toGrep = NULL, parseType = NULL,
    eCode = goECodes, wantAllComplexes = TRUE)
  
  goMatrix = list2Matrix(go)


  data(xtraGO)
                                        #xtraGO <- setdiff(xtraGO, colnames(goMatrix))
                                        #yG2P <- as.list(YEASTGO2PROBE)
                                        #xtraComp <- yG2P[xtraGO]
                                        #xtraComp <- xtraComp[!sapply(xtraComp, is.null)]
                                        #xCM <- createGOMatrix(xtraComp)
  ######This ends the section for notesOtherComps
  
                                        #goM <- mergeBGMat(goM, xCM)
  goMatrix <- xtraGONodes(xtraGO, goMatrix)
  
  ##Comparing GO complexes with all other GO complexes:
  go2go = runCompareComplex(goMatrix, goMatrix, byWhich = "ROW")
  ##Those GO complexes which are redundant or sub-complexes
  ##to other GO complexes:
  rmFromGo = go2go$toBeRm
  ##End of GO##


  ##MIPS Section##
  ##Determine the MIPS evidence codes to exclude:
  mipsECode = c("901.01.03",
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
              "901.01.09.02")
  ##Getting the Mips protein complex composition:
  mips = getMipsInfo(wantDefault = TRUE, toGrep = NULL, parseType = NULL,
    eCode = NULL, wantSubComplexes = TRUE, ht=FALSE)
  ##Creating the Mips bi-partite graph incidence matrix:
  mipsMatrix = list2Matrix(mips[["Mips"]])
  ##Comparing Mips complexes with all other Mips complexes:
  mips2mips = runCompareComplex(mipsMatrix, mipsMatrix, byWhich= "ROW")
  ##Those Mips complexes which are redundant or sub-complexes
  ##to other Mips complexes:
  rmFromMips = mips2mips$toBeRm
  ##Comparing the mips complexes to the GO complexes:
  mips2go = runCompareComplex(mipsMatrix, goMatrix, byWhich= "ROW")
  ##Those Mips complexes which are redundant and those Mips and GO
  ##complexes which might be sub-complexes to other complexes:
  rmFromMipsGo = mips2go$toBeRm
  
  ##End of Mips##

  ##Merging mipsMatrix and goMatrix:
  ISI = mergeBGMat(mipsMatrix, goMatrix, toBeRm = unique(c(rmFromGo, rmFromMips,
                                                   rmFromMipsGo)))
  
  ##The following will be a call to a series of Scripts:

  ## 1. Call to a script which takes the bait-prey interactions from
  ## five AP-MS datasets and finds and removes proteins afftected by a
  ## systematic bias

  if (filter) {
    source("estimateComp.R")
  }

  ## 2. After each bait-prey data set has been filtered, we run apComplex on
  ## each dataset

  gavin02Marix <- NULL
  ho02Matrix <- NULL
  krogan04Matrix <- NULL
  gavin06Matrix <- NULL
  krogan06Matrix <- NULL
  
  if(Gavin02){
    source("estGavin02.R")
    g02 <- sortComplexes(Gavin02CompEst)
    gavin02Matrix <- list2Matrix(g02[["MBME"]])
    cn <- vector(length=ncol(gavin02Matrix))
    for(i in 1:length(cn)){
      cn[i] <- paste("Gavin02 - Complex", i, sep = " ")
    }
    colnames(gavin02Matrix) <- cn
  }

  if(Ho02){
    source("estHo02.R")
    h02 <- sortComplexes(Ho02CompEst)
    ho02Matrix <- list2Matrix(h02[["MBME"]])
    cn <- vector(length=ncol(ho02Matrix))
    for(i in 1:length(cn)){
      cn[i] <- paste("Ho02 - Complex", i, sep = " ")
    }
    colnames(ho02Matrix) <- cn
  }

  if(Krogan04){
    source("estKrogan04.R")
    k04 <- sortComplexes(Krogan04CompEst)
    krogan04Matrix <- list2Matrix(k04[["MBME"]])
    cn <- vector(length=ncol(krogan04Matrix))
    for(i in 1:length(cn)){
      cn[i] <- paste("Krogan04 - Complex", i, sep = " ")
    }
    colnames(krogan04Matrix) <- cn
  }

  if(Gavin06){
    source("estGavin06.R")
    g06 <- sortComplexes(Gavin06CompEst)
    gavin06Matrix <- list2Matrix(g06[["MBME"]])
    cn <- vector(length=ncol(gavin06Matrix))
    for(i in 1:length(cn)){
      cn[i] <- paste("Gavin06 - Complex", i, sep = " ")
    }
    colnames(gavin06Matrix) <- cn
  }

  if(Krogan06){
    source("estKrogan06.R")
    k06 <- sortComplexes(Krogan06CompEst)
    krogan06Matrix <- list2Matrix(k06[["MBME"]])
    cn <- vector(length=ncol(krogan06Matrix))
    for(i in 1:length(cn)){
      cn[i] <- paste("Krogan06 - Complex", i, sep = " ")
    }
    colnames(krogan06Matrix) <- cn
  }

  if(!is.null(gavin02Matrix)){
    gav022ISI = runCompareComplex(gavin02Matrix, ISI, byWhich= "ROW")
    ISI = mergeBGMat(gavin02Matrix, ISI, toBeRm = gav022ISI[["toBeRm"]])
  }

  if(!is.null(ho02Matrix)){
    ho022ISI = runCompareComplex(ho02Matrix, ISI, byWhich= "ROW")
    ISI = mergeBGMat(ho02Matrix, ISI, toBeRm = ho022ISI[["toBeRm"]])
  }

  if(!is.null(krogan04Matrix)){
    kro042ISI = runCompareComplex(krogan04Matrix, ISI, byWhich= "ROW")
    ISI = mergeBGMat(krogan04Matrix, ISI, toBeRm = kro042ISI[["toBeRm"]])
  }

  if(!is.null(gavin06Matrix)){
    gav062ISI = runCompareComplex(gavin06Matrix, ISI, byWhich= "ROW")
    ISI = mergeBGMat(gavin06Matrix, ISI, toBeRm = gav062ISI[["toBeRm"]])
  }

  if(!is.null(krogan06Matrix)){
    kro062ISI = runCompareComplex(krogan06Matrix, ISI, byWhich= "ROW")
    ISI = mergeBGMat(krogan06Matrix, ISI, toBeRm = kro062ISI[["toBeRm"]])
  }

  ScISI <- unWantedComp(ISI)
  ScISI
}
