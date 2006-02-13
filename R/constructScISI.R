##This file gives the exact commands for the construction of the ScISI.

constructScISI <- function(){
    ##GO Section##
    ##Determine the GO evidence codes to exclude:
goECodes = c("IEA", "NAS", "ND", "NR")
##Getting the GO protein complex composition:
go = getGOInfo(wantDefault = TRUE, toGrep = NULL, parseType = NULL,
               eCode = goECodes, wantAllComplexes = TRUE)
##Creating the GO bi-partite graph incidence matrix:
goM = createGOMatrix(go)


##Please read the notesOtherComps found in the inst/Scripts
##directory to see why we add the following five GO Complexes
newComps = c("GO:0000145", "GO:0030127", "GO:0000776", "GO:0005786", "GO:0000943")
xx = names(as.list(GOTERM))
gt <- getGOTerm(xx)
gtcc <- gt$CC
yy <- as.list(YEASTGO2PROBE)
toAdd <- yy[newComps]
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
a1 = which(rownames(mipsM) == "YDL185W1")
a2 = which(rownames(mipsM) == "RNA_TLC1")
a3 = which(rownames(mipsM) == "SNRNA_NME1")
a4 = which(rownames(mipsM) == "RNA_RNASE-P")
nonNames = c(a1, a2, a3, a4)
mipsM = mipsM[-nonNames,]
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
rmFromMGG = c(gavin2mergeMG$toBeRm, gavin2mergeMG$toBeRmSubC)
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
##Those complexes which are redundant or sub-complexes to
##any of the previous three sets:
rmFromMGGH = c(ho2mergeMGG$toBeRm, ho2mergeMGG$toBeRmSubC)
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
##Those complexes which need to be removed:
rmFromMGGHK = c(krogan2mergeMGGH$toBeRm, krogan2mergeMGGH$toBeRmSubC)
##Merging the krogan complexes with mergeMGGH:
ScISI = mergeBGMat(krogan, mergeMGGH, toBeRm = unique(c(rmFromKrogan,
                                                        rmFromMGGHK)))
##End of Krogan##


##After verifying each protein complex, we deleted those complexes
##which were not appropriate for the ScISI:
ScISI = unWantedComp(ScISI)



tA2ScISI <- runCompareComplex(tAM, ScISI, byWhich="ROW")
ScISI <- mergeBGMat(tAM, ScISI, tA2ScISI$toBeRmSubC)

#######################
##Statistics on ScISI##
#######################
#mips2mips = runCompareComplex(mipsM, mipsM, byWhich = "ROW")
#go2go = runCompareComplex(goM, goM, byWhich = "ROW")
#mips2go = runCompareComplex(mipsM, goM, byWhich = "ROW")
gavin2mips = runCompareComplex(gavin, mipsM, byWhich = "ROW")
gavin2go = runCompareComplex(gavin, goM, byWhich = "ROW")
gavin2ho = runCompareComplex(gavin, ho, byWhich = "ROW")
gavin2krogan = runCompareComplex(gavin, krogan, byWhich = "ROW")
ho2mips = runCompareComplex(ho, mipsM, byWhich = "ROW")
ho2go = runCompareComplex(ho, goM, byWhich = "ROW")
ho2krogan = runCompareComplex(ho, krogan, byWhich = "ROW")
krogan2mips = runCompareComplex(krogan, mipsM, byWhich = "ROW")
krogan2go = runCompareComplex(krogan, goM, byWhich = "ROW")
gavin2gavin = runCompareComplex(gavin, gavin, byWhich = "ROW")
ho2ho = runCompareComplex(ho, ho, byWhich = "ROW")
krogan2krogan = runCompareComplex(krogan, krogan, byWhich = "ROW")

redundantMips = mips2mips$equal
rMM = length(redundantMips) - ncol(mipsM)
redundantGO = go2go$equal
rGG = length(redundantGO) - ncol(goM)
redundantMG = mips2go$equal
rMG = length(redundantMG) 
#redundantMGG = gavin2mergeMG$equal
#redundantMGGH = ho2mergeMGG$equal
#redundantMGGHK = krogan2mergeMGGH$equal
redundantGavM = gavin2mips$equal
rGavM = length(redundantGavM) 
redundantGavG = gavin2go$equal
rGavG = length(redundantGavG)
redundantGavH = gavin2ho$equal
rGavH = length(redundantGavH)
redundantGavK = gavin2krogan$equal
rGavK = length(redundantGavK)
redundantHoM = ho2mips$equal
rHM = length(redundantHoM)
redundantHoG = ho2go$equal
rHG = length(redundantHoG)
redundantHoK = ho2krogan$equal
rHK = length(redundantHoK)
redundantKroM = krogan2mips$equal
rKM = length(redundantKroM)
redundantKroG = krogan2go$equal
rKG = length(redundantKroG)
redundantGav = gavin2gavin$equal
rGav = length(redundantGav) - ncol(gavin)
redundantHo = ho2ho$equal
rH = length(redundantHo) - ncol(ho)
redundantKro = krogan2krogan$equal
rK = length(redundantKro) - ncol(krogan)

subC <- function(dataL, twoSets){

  x = sapply(dataL, function(v) v$orderBG1Comp)
  y = sapply(dataL, function(w) w$orderBG2Comp)

  z = sum(y<x)

  a = sum(x<y)

  name1 = twoSets[1]
  #print(name1)
  name2 = twoSets[2]
  
  q = list(name1 = z, name2 = a)
  names(q) = twoSets
  q
}

subMips = mips2mips$subcomplex
sM = subC(subMips, c("Mips1", "Mips2"))
subGO = go2go$subcomplex
sG = subC(subGO, c("GO1","GO2"))
subMG = mips2go$subcomplex
sMG = subC(subMG, c("Mips","GO"))
subGav = gavin2gavin$subcomplex
sGav = subC(subGav, c("Gavin1","Gavin2"))
#subMGG = gavin2mergeMG$subcomplex
subHo = ho2ho$subcomplex
sH = subC(subHo, c("Ho1","Ho2"))
#subMGGH = ho2mergeMGG$subcomplex
subKrogan = krogan2krogan$subcomplex
sK = subC(subKrogan, c("Krogan1","Krogan2"))
#subMGGHK = krogan2mergeMGGH$subcomplex
subGavM = gavin2mips$subcomplex
sGavM = subC(subGavM, c("Gavin","Mips"))
subGavG = gavin2go$subcomplex
sGavG = subC(subGavG, c("Gavin","GO"))
subGavH = gavin2ho$subcomplex
sGavH = subC(subGavH, c("Gavin","Ho"))
subGavK = gavin2krogan$subcomplex
sGavK = subC(subGavK, c("Gavin","Krogan"))
subHoM = ho2mips$subcomplex
sHM = subC(subHoM, c("Ho","Mips"))
subHoG = ho2go$subcomplex
sHG = subC(subHoG, c("Ho","GO"))
subHoK = ho2krogan$subcomplex
sHK = subC(subHoK, c("Ho","Krogan"))
subKroM = krogan2mips$subcomplex
sKM = subC(subKroM, c("Krogan","Mips"))
subKroG = krogan2go$subcomplex
sKG = subC(subKroG, c("Krogan","GO"))


redundantM = matrix(0, nrow=5, ncol=5)
subCompM = matrix(0, nrow = 5, ncol = 5)
repos = c("Mips","GO","Gavin","Ho","Krogan")
dNames1 = list(complexNames = repos, complexNames = repos)
dNames2 = list(subCompNames = repos, complexNames = repos)
dimnames(redundantM) = dNames1
dimnames(subCompM) = dNames2

redundantM["Mips","Mips"] = rMM 
redundantM["GO","GO"] = rGG
redundantM["Gavin","Gavin"] = rGav
redundantM["Ho","Ho"] = rH
redundantM["Krogan","Krogan"] = rK
redundantM["Mips","GO"] = rMG
redundantM["Mips","Gavin"] = rGavM
redundantM["Mips","Ho"] = rHM
redundantM["Mips","Krogan"] = rKM
redundantM["GO","Gavin"] = rGavG
redundantM["GO","Ho"] = rHG
redundantM["GO","Krogan"] = rKG
redundantM["Gavin","Ho"] = rGavH
redundantM["Gavin","Krogan"] = rGavK
redundantM["Ho","Krogan"] = rHK

subCompM["Mips","Mips"] = sM$"Mips1" + sM$"Mips2" 
subCompM["GO","GO"] = sG$"GO1" + sG$"GO2"
subCompM["Gavin","Gavin"] = sGav$"Gavin1" + sGav$"Gavin2"
subCompM["Ho","Ho"] = sH$"Ho1" + sH$"Ho2"
subCompM["Krogan","Krogan"] = sK$"Krogan1" + sK$"Krogan2"
subCompM["Mips","GO"] = sMG$"GO"
subCompM["Mips","Gavin"] = sGavM$"Gavin"
subCompM["Mips","Ho"] = sHM$"Ho"
subCompM["Mips","Krogan"] = sKM$"Krogan"
subCompM["GO","Gavin"] = sGavG$"Gavin"
subCompM["GO","Ho"] = sHG$"Ho"
subCompM["GO","Krogan"] = sKG$"Krogan"
subCompM["Gavin","Ho"] = sGavH$"Ho"
subCompM["Gavin","Krogan"] = sGavK$"Krogan"
subCompM["Ho","Krogan"] = sHK$"Krogan"
subCompM["GO","Mips"] = sMG$"Mips"
subCompM["Gavin","Mips"] = sGavM$"Mips"
subCompM["Ho","Mips"] = sHM$"Mips"
subCompM["Krogan","Mips"] = sKM$"Mips"
subCompM["Gavin","GO"] = sGavG$"GO"
subCompM["Ho","GO"] = sHG$"GO"
subCompM["Krogan","GO"] = sKG$"GO"
subCompM["Ho","Gavin"] = sGavH$"Gavin"
subCompM["Krogan","Gavin"] = sGavK$"Gavin"
subCompM["Krogan","Ho"] = sHK$"Ho"


Tables <- list()
Tables$R <- redundantM
Tables$S <- subCompM


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


Tables

}
