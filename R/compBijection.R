compBijection <- function (TSNMat, estMat, c2kMatrix, bijMat, counter = 1){

    if(nrow(bijMat) != min(dim(c2kMatrix))+ (counter-1)){
        stop("The number of rows in the Bijection Matrix must be equal min(dim(c2kMatrix)).")
    }
    
    maxEntry = max(c2kMatrix)

    maxInd = which(c2kMatrix == maxEntry, arr.ind = TRUE)
    ##bijMat = matrix(ncol = 2, nrow = nrow(c2kMatrix))

    complexNames = rownames(c2kMatrix)[maxInd[,"row"]]
    komplexNames = colnames(c2kMatrix)[maxInd[,"col"]]

    if (nrow(maxInd) == 1){
        
        #alignedComp <- compAlignment(maxInd, c2kMatrix)
        bijMat[counter, 1] = complexNames
        bijMat[counter, 2] = komplexNames
        bijMat[counter, 3] = maxEntry
        rowToDel = which(rownames(c2kMatrix) == complexNames)
        colToDel = which(colnames(c2kMatrix) == komplexNames)
        c2kMatrix = c2kMatrix[-rowToDel,,drop=FALSE]        
        c2kMatrix = c2kMatrix[, -colToDel, drop=FALSE]
    }

    if (nrow(maxInd) != 1){

        maxc2k = colSums(TSNMat[,complexNames]) + colSums(estMat[,komplexNames])
        best = which(maxc2k == max(maxc2k))
        if (length(best) > 1){
            best = best[1]
        }
        bijMat[counter,1] = complexNames[best]
        bijMat[counter,2] = komplexNames[best]
        bijMat[counter, 3] = maxEntry
        rowToDel = which(rownames(c2kMatrix) == complexNames[best])
        colToDel = which(colnames(c2kMatrix) == komplexNames[best])
        c2kMatrix = c2kMatrix[-rowToDel,, drop=FALSE]
        c2kMatrix = c2kMatrix[,-colToDel, drop=FALSE]

    }

    counter = counter+1
    if ((nrow(c2kMatrix) != 0) && (ncol(c2kMatrix) != 0) && sum(c2kMatrix) != 0){
        bijMat = compBijection(TSNMat, estMat, c2kMatrix, bijMat, counter)
    }

    bijMat
}
    
        
