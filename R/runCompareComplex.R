runCompareComplex <- function(BGMat1, BGMat2, index="Jaccard", byWhich){
    options(error=recover)
    ##This function prepares two matrix representation of bipartite
    ##graphs for comparison. We need the rows of TSNMat and erComplex
    ##to be identical if reasonable comparisons can be made. To that
    ##end, both TSNMat and erComplex are extended so that all proteins
    ##are listed and in the same order.
    
    rNamesBGMat1 = rownames(BGMat1)
    rNamesBGMat2 = rownames(BGMat2)

    ##grabbing names of proteins in one matrix and not the other...
    onlyInBGMat1 = setdiff(rNamesBGMat1, rNamesBGMat2)
    onlyInBGMat2 = setdiff(rNamesBGMat2, rNamesBGMat1)

    ##creating zero matrices indexed by the two sets above....
    apendBGMat1 = matrix(0, nrow = length(onlyInBGMat2), ncol = ncol(BGMat1))
    dimnames(apendBGMat1) = list(onlyInBGMat2, colnames(BGMat1))
    apendBGMat2 = matrix(0, nrow = length(onlyInBGMat1), ncol = ncol(BGMat2))
    dimnames(apendBGMat2) = list(onlyInBGMat1, colnames(BGMat2))

    ##binding the matrices created above to TSNMat and erComplex...
    BGMat1 = rbind(BGMat1, apendBGMat1)
    BGMat2 = rbind(BGMat2, apendBGMat2)

    ##aggregate set of preteins listed in some order
    unionNames = union(rNamesBGMat1, rNamesBGMat2)

    ##makes sure ordering in TSN and erComplex are identical...
    BGMat1 = BGMat1[unionNames,]
    BGMat2 = BGMat2[unionNames,]

    ##calls compareComplex and gets the necessary statistics
    compArray = compareComplex(BGMat1, BGMat2)
    simInd = NULL
    if (index == "Jaccard"){
        simInd = JaccardCoef(compArray)
    }

    maxInterS = maximizeSimilarity(simInd, byWhich)
    #align = runAlignment(BGMat1, BGMat2, simInd)
    
    #rowToDel = which(apply(align, 1, function(x) all(is.na(x))))
    #align = align[-rowToDel,]

    subC <- findSubComp(BGMat1, BGMat2, compArray$intersect, simInd)

    
    comparisonList = list()

    
    comparisonList$JC = simInd
    comparisonList$maxIntersect = maxInterS
    comparisonList$equal = subC$equal
    comparisonList$toBeRm = subC$toBeRm
    
    comparisonList$subcomplex = subC$subcomplex
    comparisonList$toBeRmSubC = subC$toBeRmSubC
    comparisonList

    

}
    
