xtraGONodes <- function(xtraGO, goM){

    xtraGO <- setdiff(xtraGO, colnames(goM))
    yG2P <- as.list(YEASTGO2PROBE)
    xtraComp <- yG2P[xtraGO]
    xtraComp <- xtraComp[!sapply(xtraComp, is.null)]
    xCM <- createGOMatrix(xtraComp)
    

    goM <- mergeBGMat(goM, xCM)
    goM
    
}
