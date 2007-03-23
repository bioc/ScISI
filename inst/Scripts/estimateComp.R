
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
  deg <- calcInOutDegStats(bpGraphs[[name]])
  check <- names(which(deg$inDegreeMinusOutDegree>0))
  keep <- intersect(systematic, check)
  dontKeep <- setdiff(systematic, check)
  keepR <- setdiff(rownames(bpAllMat[[name]]), dontKeep)
  keepC <- setdiff(colnames(bpAllMat[[name]]), dontKeep)
  sel[keep] <- TRUE 
  
  assign(name, bpVBPMat[[name]][sel, sel], envir=bpVBPRed)
  assign(name, bpAllMat[[name]][keepR, keepC], envir=bpAllRed)
}

bpVBPRedAPMS <- new.env(parent=globalenv(), hash=FALSE)
bpAllRedAPMS <- new.env(parent=globalenv(), hash=FALSE)

for(name in bpExperimentNames[8:12]){
  assign(name, bpVBPRed[[name]], envir=bpVBPRedAPMS)
  assign(name, bpAllRed[[name]], envir=bpAllRedAPMS)
}
