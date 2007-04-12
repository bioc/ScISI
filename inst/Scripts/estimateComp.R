
library(apComplex)
library(ppiData)
library(ppiStats)

bpGraphs = new.env(parent=globalenv(), hash=FALSE)
data(list=bpExperimentNames, envir=bpGraphs)
for(j in ls(bpGraphs))
  assign(j, eval(get(j, env=bpGraphs)), env=bpGraphs)

makeBPMat <- function(){
  ##test <- mapply(intersect, viableBaits, viablePrey)
  bpVBPMat = new.env(parent=globalenv(), hash=FALSE)
  bpAllMat <- new.env(parent=globalenv(), hash=FALSE)
  for(g in bpExperimentNames) {
    m = as(get(g), "matrix")

    if(nrow(m)>1) {
      assign(g, m, envir=bpAllMat)}else {
      cat(sprintf("Omitting %s, there is nothing much to do.\n", g))
    }
    
    ## delete self-edges
    diag(m) = 0
    

    stopifnot(identical(rownames(m), colnames(m)))
    vbp = rownames(m)[ (rowSums(m)>0) & (colSums(m)>0) ]
    
    
    m = m[vbp, vbp]

    if(nrow(m)>1) {
      assign(g, m, envir=bpVBPMat)
    } else {
      cat(sprintf("Omitting %s, there is nothing much to do.\n", g))
    }
  }

  ans <- list()
  ans$bpVBPMat <- bpVBPMat
  ans$bpAllMat <- bpAllMat
  
  return(ans)
}

cache(ans <- makeBPMat())

bpVBPMat <- ans$bpVBPMat
bpAllMat <- ans$bpAllMat

pLevels = 1e-4
pThresh = 0.01
bpVBPRed = new.env(parent=globalenv(), hash=FALSE)
bpAllRed <- new.env(parent=globalenv(), hash=FALSE)

for(name in ls(bpVBPMat)) {
  
  f = assessSymmetry(bpVBPMat[[name]], pLevels=pLevels)
  sel = (f$p>=pThresh)
  systematic <- names(sel[!sel])
  #deg <- calcInOutDegStats(bpGraphs[[name]])
  #check <- names(which(deg$inDegreeMinusOutDegree>0))
  #keep <- intersect(systematic, check)
  #dontKeep <- setdiff(systematic, check)
  keepR <- setdiff(rownames(bpAllMat[[name]]), systematic)
  keepC <- setdiff(colnames(bpAllMat[[name]]), systematic)
  #sel[keep] <- TRUE

  vbpRedMat <- bpVBPMat[[name]][sel, sel]
  allRedMat <- bpAllMat[[name]][keepR, keepC]

  vbpRedMat <- vbpRedMat[rownames(vbpRedMat)[rowSums(vbpRedMat)>0],
                         colnames(vbpRedMat)[colSums(vbpRedMat)>0]]

  allRedMat <- allRedMat[rownames(allRedMat)[rowSums(allRedMat)>0],
                         colnames(allRedMat)[colSums(allRedMat)>0]]
  
  assign(name, vbpRedMat, envir=bpVBPRed)
  assign(name, allRedMat, envir=bpAllRed)
}

bpVBPRedAPMS <- new.env(parent=globalenv(), hash=FALSE)
bpAllRedAPMS <- new.env(parent=globalenv(), hash=FALSE)

for(name in bpExperimentNames[8:12]){
  assign(name, bpVBPRed[[name]], envir=bpVBPRedAPMS)
  assign(name, bpAllRed[[name]], envir=bpAllRedAPMS)
}

#save(bpAllRedAPMS, file="bpAllRedAPMS.rda", compress=TRUE)
#save(bpVBPRedAPMS, file="bpVBPRedAPMS.rda", compress=TRUE)

library(apComplex)
#load("bpVBPRedAPMS.rda")
#matList = as.list(bpVBPRedAPMS)
#t = matList[[5]]
#test = findComplexes(t, commonFrac=.5)

mList <- as.list(bpAllRedAPMS)
Gavin02CompEst <- findComplexes(mList[["Gavin2002BPGraph"]], commonFrac=.5)
save(Gavin02CompEst, file="Gavin02CompEst.rda", compress=TRUE)
Ho02CompEst <- findComplexes(mList[["Ho2002BPGraph"]], commonFrac=.5)
save(Ho02CompEst, file="Ho02CompEst.rda", compress=TRUE)
Krogan04CompEst <- findComplexes(mList[["Krogan2004BPGraph"]], commonFrac=.5)
save(Krogan04CompEst, file="Krogan04CompEst.rda", compress=TRUE)
Gavin06CompEst <- findComplexes(mList[["Gavin2006BPGraph"]], commonFrac=.5)
save(Gavin06CompEst, file="Gavin06CompEst.rda", compress=TRUE)
Krogan06CompEst <- findComplexes(mList[["Krogan2006BPGraph"]], commonFrac=.5)
save(Krogan06CompEst, file="Krogan06CompEst.rda", compress=TRUE)
