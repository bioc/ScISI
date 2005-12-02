runAlignment <- function(TSNMat, estMat, c2kMat){

    num = min(dim(c2kMat))
    bijMat = matrix(nrow = num, ncol = 3)
    dimnames(bijMat) = list(1:num, c("BG1-Complexes", "BG2-Complexes", "Similarity Index"))

    compBijection(TSNMat, estMat, c2kMat, bijMat, 1)



}
