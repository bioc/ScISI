##This file gives the exact commands for the construction of the ScISI.

library(ScISI)
goECodes = c("IEA", "NAS", "ND", "NR")
go = getGOInfo(wantDefault = TRUE, toGrep = NULL, parseType = NULL,
               eCode = goECodes, wantAllComplexes = TRUE)
goM = createGOMatrix(go)
go2go = runCompareComplex(goM, goM, byWhich = "ROW")
rmFromGo = c(go2go$toBeRm, go2go$toBeRmSubC)

mipsECode = c("901.01.03", "901.01.03.01", "901.01.03.02",
              "901.01.04", "901.01.04.01", "901.01.04.02",
              "901.01.05", "901.01.05.01", "901.01.05.02",
              "902.01.01.02.01.01.02", "902.01.01.04.01.03",
              "902.01.09.02")

mips = getMipsInfo(wantDefault = TRUE, toGrep = NULL, parseType = NULL,
               eCode = mipsECode, wantAllComplexes = FALSE)
mipsM = createMipsMatrix(mips)
mips2mips = runCompareComplex(mipsM, mipsM, byWhich= "ROW")
rmFromMips = c(mips2mips$toBeRm, mips2mips$toBeRmSubC)

mips2go = runCompareComplex(mipsM, goM, byWhich= "ROW")
rmFromMipsGo = c(mips2go$toBeRm, mips2go$toBeRmSubC)

mergeMipsGo = mergeBGMat(mipsM, goM, toBeRm = unique(c(rmFromGo, rmFromMips,
                                                       rmFromMipsGo)))

gavin = getAPMSData("Gavin")
gavin2gavin = runCompareComplex(gavin, gavin, byWhich= "ROW")
rmFromGavin = c(gavin2gavin$toBeRm, gavin2gavin$toBeRmSubC)

gavin2mergeMG = runCompareComplex(gavin, mergeMipsGo, byWhich="ROW")
rmFromMGG = c(gavin2mergeMG$toBeRm, gavin2mergeMG$toBeRmSubC)

mergeMGG = mergeBGMat(gavin, mergeMipsGo, toBeRm = unique(c(rmFromGavin,
                                                             rmFromMGG)))

ho = getAPMSData("Ho")
ho2ho = runCompareComplex(ho, ho, byWhich = "ROW")
rmFromHo = c(ho2ho$toBeRm, ho2ho$toBeRmSubC)

ho2mergeMGG = runCompareComplex(ho, mergeMGG, byWhich= "ROW")
rmFromMGGH = c(ho2mergeMGG$toBeRm, ho2mergeMGG$toBeRmSubC)

mergeMGGH = mergeBGMat(ho, mergeMGG, toBeRm = unique(c(rmFromHo, rmFromMGGH)))

krogan = getAPMSData("Krogan")
krogan2krogan = runCompareComplex(krogan, krogan, byWhich = "ROW")
rmFromKrogan = c(krogan2krogan$toBeRm, krogan2krogan$toBeRmSubC)

krogan2mergeMGGH = runCompareComplex(krogan, mergeMGGH, byWhich = "ROW")
rmFromMGGHK = c(krogan2mergeMGGH$toBeRm, krogan2mergeMGGH$toBeRmSubC)

ScISI = mergeBGMat(krogan, mergeMGGH, toBeRm = unique(c(rmFromKrogan,
                                                        rmFromMGGHK)))

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
