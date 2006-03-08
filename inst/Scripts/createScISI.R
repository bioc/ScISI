createScISI <- function(pathToSave=NULL){


goECodes = c("IEA", "NAS", "ND", "NR")
go = getGOInfo(wantDefault = TRUE, toGrep = NULL, parseType = NULL,
               eCode = goECodes, wantAllComplexes = TRUE)

goM = createGOMatrix(go)


data(xtraGO)
xtraGO <- setdiff(xtraGO, colnames(goM))
yG2P <- as.list(YEASTGO2PROBE)
xtraComp <- yG2P[xtraGO]
xtraComp <- xtraComp[!sapply(xtraComp, is.null)]
xCM <- createGOMatrix(xtraComp)
######This ends the section for notesOtherComps

goM <- mergeBGMat(goM, xCM)


##Comparing GO complexes with all other GO complexes:
go2go = runCompareComplex(goM, goM, byWhich = "ROW")
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
               eCode = NULL, wantAllComplexes = TRUE)
##Creating the Mips bi-partite graph incidence matrix:
mipsM = createMipsMatrix(mips)
##Deleting any protein complexes ascertained from AP-MS high
##through-put (Gavin, Ho, Krogan) found within Mips:
cn = colnames(mipsM)
apms = grep("MIPS-550", cn)
mipsM = mipsM[,-apms]
##Comparing Mips complexes with all other Mips complexes:
mips2mips = runCompareComplex(mipsM, mipsM, byWhich= "ROW")
##Those Mips complexes which are redundant or sub-complexes
##to other Mips complexes:
rmFromMips = mips2mips$toBeRm
##Comparing the mips complexes to the GO complexes:
mips2go = runCompareComplex(mipsM, goM, byWhich= "ROW")
##Those Mips complexes which are redundant and those Mips and GO
##complexes which might be sub-complexes to other complexes:
rmFromMipsGo = mips2go$toBeRm
##Merging mipsM and goM:
mergeMipsGo = mergeBGMat(mipsM, goM, toBeRm = unique(c(rmFromGo, rmFromMips,
                                                       rmFromMipsGo)))
##End of Mips##



##Gavin##
##Downloading the Gavin data from bioconductor:
gavin = getAPMSData("Gavin")
##Comparing the gavin complexes with all other gavin
##complexes:
gavin2gavin = runCompareComplex(gavin, gavin, byWhich= "ROW")
##Those gavin complexes which are redundant or sub-complexes:
rmFromGavin = gavin2gavin$toBeRm
##Comparing the gavin complexes to the Mips and GO complexes
##which were kept in the merging of the two incidence matrices:
gavin2mergeMG = runCompareComplex(gavin, mergeMipsGo, byWhich="ROW")
##Those gavin complexes which are redundant or sub-complexes to
##complexes in mergeMipsGo:


rmFromMGG = gavin2mergeMG$toBeRm

##Merging the gavin complexes with mergeMipsGo:
mergeMGG = mergeBGMat(gavin, mergeMipsGo, toBeRm = unique(c(rmFromGavin,
                                                             rmFromMGG)))
##End of Gavin##




##Ho##
##Downloading the Ho data from bioconductor:
ho = getAPMSData("Ho")
##Comparing the ho complexes with other ho complexes:
ho2ho = runCompareComplex(ho, ho, byWhich = "ROW")
##Those complexes which are redundant or sub-complexes
##of other ho complexes:
rmFromHo = ho2ho$toBeRm
##Comparing ho complexes to mips, go, gavin kept complexes:
ho2mergeMGG = runCompareComplex(ho, mergeMGG, byWhich= "ROW")

##Those complexes which are redundant or sub-complexes to
##any of the previous three sets:
rmFromMGGH = ho2mergeMGG$toBeRm

##Merging ho with mergeMGG:
mergeMGGH = mergeBGMat(ho, mergeMGG, toBeRm = unique(c(rmFromHo, rmFromMGGH)))
##End of Ho##


##Krogan##
##Downloading the krogan from bioconductor:
krogan = getAPMSData("Krogan")
##Comparing the krogan complexes with krogan complexes:
krogan2krogan = runCompareComplex(krogan, krogan, byWhich = "ROW")


##Those complexes that need to be removed:
rmFromKrogan = krogan2krogan$toBeRm
##Comparing the krogan complexes with complexes from mergeMGGH:
krogan2mergeMGGH = runCompareComplex(krogan, mergeMGGH, byWhich = "ROW")

##Those complexes which need to be removed:
rmFromMGGHK = krogan2mergeMGGH$toBeRm

##Merging the krogan complexes with mergeMGGH:
mergeMGGHK = mergeBGMat(krogan, mergeMGGH, toBeRm = unique(c(rmFromKrogan,
                                                        rmFromMGGHK)))
##End of Krogan##


##After verifying each protein complex, we deleted those complexes
##which were not appropriate for the ScISI:
ScISI = unWantedComp(mergeMGGHK)

imList = List()
imList[[1]] <- mipsM
imList[[2]] <- goM
imList[[3]] <- gavin
imList[[4]] <- ho
imList[[5]] <- krogan

if(!is.null(pathToSave)){
    save(mips2go, file=paste(pathToSave, "mips2go.rda", sep=""), compress=TRUE)
    save(gavin2mergeMG, file=paste(pathToSave, "gavin2mergeMG.rda", sep=""), compress=TRUE)
    save(ho2mergeMGG, file=paste(pathToSave, "ho2mergeMGG.rda", sep=""), compress=TRUE)
    save(krogan2mergeMGGH, file=paste(pathToSave, "krogan2mergeMGGH.rda", sep=""), compress=TRUE)
    save(ScISI, file = paste(pathToSave,"ScISI.rda", sep=""), compress=TRUE)
    sumStat(imList, pathToSave)
 }

ScISI
}
