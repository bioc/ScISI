createGODataFrame <- function(cMembers, goMat){

    goID <- names(cMembers)
    goNames <- getGOTerm(goID)
    interactomeNames <- intersect(colnames(goMat), goID)
    goReference <- data.frame(names=I(interactomeNames), id=I(goID),
                              description=I(goNames$CC))

    goReference
}
