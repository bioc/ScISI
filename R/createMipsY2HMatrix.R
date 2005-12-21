createMipsY2HMatrix <- function(dataY2HMat){

    allProt = unique(c(dataY2HMat[,1], dataY2HMat[,3]))

    ppi = matrix(0, nrow = length(allProt), ncol = length(allProt))
    rownames(ppi) = allProt
    colnames(ppi) = allProt

    
    for(i in 1:nrow(dataY2HMat)){
        ppi[dataY2HMat[i,1], dataY2HMat[i,3]] = 1
        ppi[dataY2HMat[i,3], dataY2HMat[i,1]] = 1
    }

    ppi

}
