mergeBGMat <- function(mat1, mat2, toBeRm = NULL){

    if(!is.null(toBeRm)){
        if(length(setdiff(toBeRm,colnames(mat1))) == 0){
            indToDel = sapply(toBeRm, function(z) which(z == colnames(mat1)))
            mat1 = mat1[,-indToDel]
        }
        
        if(length(setdiff(toBeRm,colnames(mat2))) == 0){
            indToDel = sapply(toBeRm, function(z) which(z == colnames(mat2)))
            mat2 = mat2[,-indToDel]
        }
    }
        
    proteins <- union(rownames(mat1), rownames(mat2))
    complexes <- c(colnames(mat1), colnames(mat2))
    mergedMat <- matrix(0, nrow=length(proteins), ncol=length(complexes))

    dimnames(mergedMat) = list(proteins, complexes)
    mergedMat[rownames(mat1), colnames(mat1)] = mat1
    mergedMat[rownames(mat2), colnames(mat2)] = mat2

    mergedMat
}
