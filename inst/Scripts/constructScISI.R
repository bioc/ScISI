##This file gives the exact commands for the construction of the ScISI.

library(ScISI)
##Determine the GO evidence codes to exclude:
goECodes = c("IEA", "NAS", "ND", "NR")
##Getting the GO protein complex composition:
go = getGOInfo(wantDefault = TRUE, toGrep = NULL, parseType = NULL,
               eCode = goECodes, wantAllComplexes = TRUE)
##Creating the GO bi-partite graph incidence matrix:
goM = createGOMatrix(go)
##Comparing GO complexes with all other GO complexes:
go2go = runCompareComplex(goM, goM, byWhich = "ROW")
##Those GO complexes which are redundant or sub-complexes
##to other GO complexes:
rmFromGo = c(go2go$toBeRm, go2go$toBeRmSubC)

##Determine the MIPS evidence codes to exclude:
mipsECode = c("901.01.03", "901.01.03.01", "901.01.03.02",
              "901.01.04", "901.01.04.01", "901.01.04.02",
              "901.01.05", "901.01.05.01", "901.01.05.02",
              "902.01.01.02.01.01.02", "902.01.01.04.01.03",
              "902.01.09.02", "902.01.01.02.01.01",
              "902.01.01.02.01.01.01", "902.01.01.02.01.01.02",
              "902.01.01.02.01.02", "902.01.01.02.01.02.01",
              "902.01.01.02.01.02.02", "902.01.01.04.01",
              "902.01.01.04.01.02", "902.01.01.04.01.01",
              "902.01.01.04", "902.01.01.04.01.01",
              "902.01.01.04.02")
##Getting the Mips protein complex composition:
mips = getMipsInfo(wantDefault = TRUE, toGrep = NULL, parseType = NULL,
               eCode = mipsECode, wantAllComplexes = FALSE)
##Creating the Mips bi-partite graph incidence matrix:
mipsM = createMipsMatrix(mips)
##Deleting any protein complexes ascertained from AP-MS high
##through-put (Gavin, Ho, Krogan) found within Mips:
#cn = colnames(mipsM)
#apms = grep("MIPS-550", cn)
#mipsM = mipsM[,-apms]
##Comparing Mips complexes with all other Mips complexes:
mips2mips = runCompareComplex(mipsM, mipsM, byWhich= "ROW")
##Those Mips complexes which are redundant or sub-complexes
##to other Mips complexes:
rmFromMips = c(mips2mips$toBeRm, mips2mips$toBeRmSubC)
##Comparing the mips complexes to the GO complexes:
mips2go = runCompareComplex(mipsM, goM, byWhich= "ROW")
##Those Mips complexes which are redundant and those Mips and GO
##complexes which might be sub-complexes to other complexes:
rmFromMipsGo = c(mips2go$toBeRm, mips2go$toBeRmSubC)
##Merging mipsM and goM:
mergeMipsGo = mergeBGMat(mipsM, goM, toBeRm = unique(c(rmFromGo, rmFromMips,
                                                       rmFromMipsGo)))
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
rmFromMGG = c(gavin2mergeMG$toBeRm, gavin2mergeMG$toBeRmSubC)
##Merging the gavin complexes with mergeMipsGo:
mergeMGG = mergeBGMat(gavin, mergeMipsGo, toBeRm = unique(c(rmFromGavin,
                                                             rmFromMGG)))
##Downloading the Ho data from bioconductor:
ho = getAPMSData("Ho")
##Comparing the ho complexes with other ho complexes:
ho2ho = runCompareComplex(ho, ho, byWhich = "ROW")
##Those complexes which are redundant or sub-complexes
##of other ho complexes:
rmFromHo = c(ho2ho$toBeRm, ho2ho$toBeRmSubC)
##Comparing ho complexes to mips, go, gavin kept complexes:
ho2mergeMGG = runCompareComplex(ho, mergeMGG, byWhich= "ROW")
##Those complexes which are redundant or sub-complexes to
##any of the previous three sets:
rmFromMGGH = c(ho2mergeMGG$toBeRm, ho2mergeMGG$toBeRmSubC)
##Merging ho with mergeMGG:
mergeMGGH = mergeBGMat(ho, mergeMGG, toBeRm = unique(c(rmFromHo, rmFromMGGH)))

##Downloading the krogan from bioconductor:
krogan = getAPMSData("Krogan")
##Comparing the krogan complexes with krogan complexes:
krogan2krogan = runCompareComplex(krogan, krogan, byWhich = "ROW")
##Those complexes that need to be removed:
rmFromKrogan = c(krogan2krogan$toBeRm, krogan2krogan$toBeRmSubC)
##Comparing the krogan complexes with complexes from mergeMGGH:
krogan2mergeMGGH = runCompareComplex(krogan, mergeMGGH, byWhich = "ROW")
##Those complexes which need to be removed:
rmFromMGGHK = c(krogan2mergeMGGH$toBeRm, krogan2mergeMGGH$toBeRmSubC)
##Merging the krogan complexes with mergeMGGH:
ScISI = mergeBGMat(krogan, mergeMGGH, toBeRm = unique(c(rmFromKrogan,
                                                        rmFromMGGHK)))
##After verifying each protein complex, we deleted those complexes
##which were not appropriate for the ScISI:
ScISI = unWantedComp(ScISI)

##If the sub-complexes are to be included in the interactome

go = getGOInfo(wantDefault = TRUE, toGrep = NULL, parseType = NULL,
               eCode = NULL, wantAllComplexes = TRUE)
goM = createGOMatrix(go)
go2go = runCompareComplex(goM, goM, byWhich = "ROW")
rmFromGoEq = c(go2go$toBeRm)

mips = getMipsInfo(wantDefault = TRUE, toGrep = NULL, parseType = NULL,
               eCode = NULL, wantAllComplexes = TRUE)
mipsM = createMipsMatrix(mips)
cn = colnames(mipsM)
apms = grep("MIPS-550", cn)
mipsM = mipsM[,-apms]

mips2mips = runCompareComplex(mipsM, mipsM, byWhich= "ROW")
rmFromMips = c(mips2mips$toBeRm)

mips2go = runCompareComplex(mipsM, goM, byWhich= "ROW")
rmFromMipsGo = c(mips2go$toBeRm)

mergeMipsGo = mergeBGMat(mipsM, goM, toBeRm = unique(c(rmFromGo, rmFromMips,
                                                       rmFromMipsGo)))

gavin = getAPMSData("Gavin")
gavin2gavin = runCompareComplex(gavin, gavin, byWhich= "ROW")
rmFromGavin = c(gavin2gavin$toBeRm)

gavin2mergeMG = runCompareComplex(gavin, mergeMipsGo, byWhich="ROW")
rmFromMGG = c(gavin2mergeMG$toBeRm)

mergeMGG = mergeBGMat(gavin, mergeMipsGo, toBeRm = unique(c(rmFromGavin,
                                                             rmFromMGG)))

ho = getAPMSData("Ho")
ho2ho = runCompareComplex(ho, ho, byWhich = "ROW")
rmFromHo = c(ho2ho$toBeRm)

ho2mergeMGG = runCompareComplex(ho, mergeMGG, byWhich= "ROW")
rmFromMGGH = c(ho2mergeMGG$toBeRm)

mergeMGGH = mergeBGMat(ho, mergeMGG, toBeRm = unique(c(rmFromHo, rmFromMGGH)))

krogan = getAPMSData("Krogan")
krogan2krogan = runCompareComplex(krogan, krogan, byWhich = "ROW")
rmFromKrogan = c(krogan2krogan$toBeRm)

krogan2mergeMGGH = runCompareComplex(krogan, mergeMGGH, byWhich = "ROW")
rmFromMGGHK = c(krogan2mergeMGGH$toBeRm)

ScISIsubC = mergeBGMat(krogan, mergeMGGH, toBeRm = unique(c(rmFromKrogan,
                                                        rmFromMGGHK)))
ScISIsubC = unWantedComp(ScISIsubC)


##Running the script without manually removing the 
