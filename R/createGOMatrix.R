createGOMatrix <- function(cMembers){

    proteins = unique(unlist(cMembers))
    goId = names(cMembers)
    goMat <- matrix(0, nrow=length(proteins), ncol=length(cMembers))
    dimnames(goMat) <- list(proteins, goId)

    for(i in 1:length(cMembers)){

        for(j in 1:length(cMembers[[i]])){

            goMat[cMembers[[i]][j], goId[i]] = 1

        }

    }
    goMat
}
