createGOMatrix <- function(cMembers){
  proteins = unique(unlist(cMembers))
  goId = names(cMembers)
  goMat <- matrix(0, nrow=length(proteins), ncol=length(cMembers))
  dimnames(goMat) <- list(proteins, goId)
  
  for(i in 1:length(cMembers)){      
    goMat[cMembers[[i]], goId[i]] = 1
  }
  goMat
}


