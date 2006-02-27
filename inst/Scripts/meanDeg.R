meanDeg <- function(comp, bait2PreyL){

  genWide <- sapply(bait2PreyL, function(x) x$expList[["GW"]])
  b2GWPreyL <- bait2PreyL[genWide]
  b2GWPreyL <- b2GWPreyL[!sapply(b2GWPrey, is.null)]
  b2GWPreyL <- lapply(b2GWPreyL, function(x) x$bpList)

  degBait <- list()
  compB2P <- list()
  for(j in 1:length(comp)){
    hits <- unique(unlist(lapply(b2GWPreyL, function(x) x[[comp[j]]])))
    hitsInComp <- intersect(comp, hits)
    degBait[[j]] <- length(hitsInComp)
    compB2P[[j]] <- hitsInComp
  }

  names(compB2P) <- comp
  ##there will be an error here for subscript out of bounds...
  b2pAM <- matrix(0, nrow=length(compB2P), ncol=length(unique(unlist(compB2P))))
  for(i in 1:length(compB2P)){
    
  }
  
  popMeanDeg <- (length(comp)*(sum(unlist(degBait))))/(2*length(degBait))

  
  
  sumStats <- list()
  sumStats$degBait <- degBait
  sumStats$comp <- comp
  sumStats$popMeanDeg <- popMeanDeg
}
