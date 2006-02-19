ISI021906 <- function(){

##This file gives the exact commands for the construction of the ScISI.

#library(ScISI)
options(errors=recover)
##GO Section##
##Determine the GO evidence codes to exclude:
goECodes = c("IEA", "NAS", "ND", "NR")
##Getting the GO protein complex composition:
go = getGOInfo(wantDefault = TRUE, toGrep = NULL, parseType = NULL,
               eCode = goECodes, wantAllComplexes = TRUE)
##Creating the GO bi-partite graph incidence matrix:
goM = createGOMatrix(go)

##Please read the section on notesOtherComplexes
newComps = c("GO:0000145", "GO:0030127", "GO:0000776", "GO:0005786", "GO:0000943")
xx = names(as.list(GOTERM))
gt <- getGOTerm(xx)
gtcc <- gt$CC
yy <- as.list(YEASTGO2PROBE)
toAdd <- yy[newComps]
print(toAdd)
tAM <- createGOMatrix(toAdd)
######This ends the section for notesOtherComps

goM <- mergeBGMat(goM, tAM)


##Comparing GO complexes with all other GO complexes:
go2go = runCompareComplex(goM, goM, byWhich = "ROW")
##Those GO complexes which are redundant or sub-complexes
##to other GO complexes:
rmFromGo = c(go2go$toBeRm, go2go$toBeRmSubC)
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
               eCode = mipsECode, wantAllComplexes = FALSE)
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
rmFromMips = c(mips2mips$toBeRm, mips2mips$toBeRmSubC)
##Comparing the mips complexes to the GO complexes:
mips2go = runCompareComplex(mipsM, goM, byWhich= "ROW")
##Those Mips complexes which are redundant and those Mips and GO
##complexes which might be sub-complexes to other complexes:
rmFromMipsGo = c(mips2go$toBeRm)
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
rmFromGavin = c(gavin2gavin$toBeRm, gavin2gavin$toBeRmSubC)
##Comparing the gavin complexes to the Mips and GO complexes
##which were kept in the merging of the two incidence matrices:
gavin2mergeMG = runCompareComplex(gavin, mergeMipsGo, byWhich="ROW")
##Those gavin complexes which are redundant or sub-complexes to
##complexes in mergeMipsGo:

whereGO <- grep("GO:", gavin2mergeMG$toBeRmSubC)

whereMIPS <- grep("MIPS-", gavin2mergeMG$toBeRmSubC)
comboMG <- c(whereGO, whereMIPS)

if(length(comboMG) != 0){
  whichMips <- unique(gavin2mergeMG$toBeRmSubC[-comboMG])

}
else{
  whichMips <- gavin2mergeMG$toBeRmSubC
}
rmFromMGG = unique(c(gavin2mergeMG$toBeRm, whichMips))

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
rmFromHo = c(ho2ho$toBeRm, ho2ho$toBeRmSubC)
##Comparing ho complexes to mips, go, gavin kept complexes:
ho2mergeMGG = runCompareComplex(ho, mergeMGG, byWhich= "ROW")
whereGO <- grep("GO:", ho2mergeMGG$toBeRmSubC)
whereMIPS <- grep("MIPS-", ho2mergeMGG$toBeRmSubC)
comboMG <- c(whereGO, whereMIPS)

if(length(comboMG)!=0){
  whichOthers <- ho2mergeMGG$toBeRmSubC[-comboMG]
 
}
else{
  whichOthers <- ho2mergeMGG$toBeRmSubC
}



##Those complexes which are redundant or sub-complexes to
##any of the previous three sets:
rmFromMGGH = c(ho2mergeMGG$toBeRm, whichOthers)
print(rmFromMGGH)
##Merging ho with mergeMGG:
mergeMGGH = mergeBGMat(ho, mergeMGG, toBeRm = unique(c(rmFromHo, rmFromMGGH)))
##End of Ho##


##Krogan##
##Downloading the krogan from bioconductor:
krogan = getAPMSData("Krogan")
##Comparing the krogan complexes with krogan complexes:
krogan2krogan = runCompareComplex(krogan, krogan, byWhich = "ROW")


##Those complexes that need to be removed:
rmFromKrogan = c(krogan2krogan$toBeRm, krogan2krogan$toBeRmSubC)
##Comparing the krogan complexes with complexes from mergeMGGH:
krogan2mergeMGGH = runCompareComplex(krogan, mergeMGGH, byWhich = "ROW")
whereGO <- grep("GO:", krogan2mergeMGGH$toBeRmSubC)
whereMIPS <- grep("MIPS-", krogan2mergeMGGH$toBeRmSubC)
comboMG <- c(whereGO, whereMIPS)
if(length(whichOthers)!=0){
  whichOthers <- krogan2mergeMGGH$toBeRmSubC[-comboMG]
}
else{
  whichOthers <- krogan2mergeMGGH$toBeRmSubC
}
##Those complexes which need to be removed:
rmFromMGGHK = c(krogan2mergeMGGH$toBeRm, whichOthers)
print(rmFromMGGHK)
##Merging the krogan complexes with mergeMGGH:
ScISI = mergeBGMat(krogan, mergeMGGH, toBeRm = unique(c(rmFromKrogan,
                                                        rmFromMGGHK)))
##End of Krogan##


##After verifying each protein complex, we deleted those complexes
##which were not appropriate for the ScISI:
ScISI = unWantedComp(ScISI)

ScISI
}
