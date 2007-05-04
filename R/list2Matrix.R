list2Matrix <- function(hgList, stoichiometry=FALSE){
  
  proteins = unique(unlist(hgList))
  complexID = names(hgList)
  stopifnot(length(complexID) == length(unique(complexID)))
  hgMatrix <- matrix(0, nrow=length(proteins), ncol=length(hgList))
  dimnames(hgMatrix) <- list(proteins, complexID)

  if(!stoichiometry){
    for(i in 1:length(complexID)){
      hgMatrix[hgList[[i]], complexID[i]] <- 1
    }
  }

  else{
    for(i in 1:length(complexID)){
      t <- table(hgList[[i]])
      v <- as.vector(t)
      n <- names(t)
      hgMatrix[n, complexID[i]] <- v
    }
  }

  prot <- toupper(proteins)
  rownames(hgMatrix) <- prot
  hgMatrix
  
}


