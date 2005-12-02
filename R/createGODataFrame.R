createGODataFrame <- function(cMembers, goMat){

    goID <- names(cMembers)
    goNames <- getGOTerm(goID)
    interactomeNames <- colnames(goMat)
    goReference <- data.frame(names=I(interactomeNames), id=I(goID), description=I(goNames$CC))

    goReference
}
