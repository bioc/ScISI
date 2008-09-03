xtraGONodes <- function(xtraGO, goM){

    xtraGO <- setdiff(xtraGO, colnames(goM))
    yG2P <- as.list(org.Sc.sgdGO2ORF)
    xtraComp <- yG2P[xtraGO]
    xtraComp <- xtraComp[!sapply(xtraComp, is.null)]
    xCM <- list2Matrix(xtraComp)
    

    goM <- mergeBGMat(goM, xCM)
    goM
    
}
