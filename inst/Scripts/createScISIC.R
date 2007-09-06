createScISIC <- function(pathToSave=NULL){

  xml <- system.file("PSI25XML/14681455.xml", package="Rintact")
  intactComp <- psi25complex(xml)
  compNames <- sapply(intactComp@complexes, function(x)
                      x@fullName)
  complexes <- lapply(intactComp@complexes, function(x)
                      x@interactors)
  yeastCompNames <- compNames[150:182]
  yeastComplexes <- complexes[150:182]

  yeastCompSysName <- vector("list", length = length(yeastComplexes))
  for(i in 1:length(yeastCompSysName)){
    uni <- yeastComplexes[[i]][,1]
    ind <- intactComp@interactors[,2] %in% uni
    yeastCompSysName[[i]]<- intactComp@interactors[ind,5]
  }

  yeastCompSysName <- lapply(yeastCompSysName, function(x)
                             x[!is.na(x)])

  names(yeastCompSysName) <- yeastCompNames

  intactBGM <- list2Matrix(yeastCompSysName)

  i2i <- runCompareComplex(intactBGM, intactBGM)
  rmFromI <- i2i$toBeRm
  
  
  ##getting the protein complexes from GO
  goECodes = c("IEA", "NAS", "ND", "NR")
  go = getGOInfo(wantDefault = TRUE, toGrep = NULL,
    parseType = NULL,
    eCode = goECodes, wantAllComplexes = TRUE)
  
  goMatrix = list2Matrix(go)
  
  
  #data(xtraGO)
  #goMatrix <- xtraGONodes(xtraGO, goMatrix)


  ##Comparing GO complexes with all other GO complexes:
  go2go = runCompareComplex(goMatrix, goMatrix, byWhich = "ROW")
  g2i <- runCompareComplex(goMatrix, intactBGM)
  ##Those GO complexes which are redundant:
  rmFromGo = c(go2go$toBeRm, g2i$toBeRm)
  ig <- mergeBGMat(intactBGM, goMatrix, toBeRm = rmFromGo)
  ##End of GO##
  

  ##MIPS Section##

  mips = getMipsInfo(wantDefault = TRUE, toGrep = NULL,
    parseType = NULL, eCode = NULL, wantSubComplexes = TRUE,
    ht=FALSE)
  ##Creating the Mips bi-partite graph incidence matrix:
  mipsMatrix = list2Matrix(mips)
  ##Comparing Mips complexes with all other Mips complexes:
  mips2mips = runCompareComplex(mipsMatrix, mipsMatrix,
    byWhich= "ROW")
  ##Those Mips complexes which are redundan:
  rmFromMips = mips2mips$toBeRm
  ##Comparing the mips complexes to the GO complexes:
  mips2ig = runCompareComplex(mipsMatrix, ig,
    byWhich= "ROW")
  ##Those Mips complexes which are redundant are removed:
  rmFromMipsGo = mips2ig$toBeRm
  ##Merging mipsM and goM:
  mergeMipsGo = mergeBGMat(ig, mipsMatrix, toBeRm =
    unique(c(rmFromMips, rmFromMipsGo)))

  #mergeMipsGo <- unWantedComp(mergeMipsGo)
  
  ScISIC <- mergeMipsGo
  
  ScISIC
  
}