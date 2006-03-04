createScISIverified <- function(pathToSave=NULL){
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

mergeMipsGo <- unWantedComp(mergeMipsGo)

ScISIverified <- mergeMipsGo

if(!is.null(pathToSave)){
    save(mips2go, file=paste(pathToSave,"mips2go.rda", sep=""), compress=TRUE)
    save(ScISIverified, file=paste(pathToSave,"ScISIverified.rda", sep=""), compress=TRUE)
}

ScISIverified

}
