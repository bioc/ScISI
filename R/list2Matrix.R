list2Matrix <- function(hgList){
  
  proteins = unique(unlist(hgList))
  complexID = names(hgList)
  stopifnot(length(complexID) == length(unique(complexID)))
  hgMatrix <- Matrix(0, nrow=length(proteins), ncol=length(hgList))
  dimnames(hgMatrix) <- list(proteins, complexID)
  
  for(i in 1:length(complexID)){
    hgMatrix[hgList[[i]], complexID[i]] <- 1
  }

  prot <- toupper(proteins)
  rownames(hgMatrix) <- prot
  hgMatrix
  
}
