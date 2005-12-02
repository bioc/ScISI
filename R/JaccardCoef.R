JaccardCoef <- function(dataMat){

    ##The Jaccard Coefficient varies in the closed set [0,1]
    ##and measures similarity based on the statistics calculated in
    ##CompareComplex.R. The Jaccard coefficient is essentially
    ##$\frac{a}{a+b+c}$. See also the Dice-Sorenson Coefficient.
    
    similarityMat = matrix(0.00, nrow = dim(dataMat$intersect)[1], ncol = dim(dataMat$intersect)[2])
    dimnames(similarityMat) = dimnames(dataMat$intersect)

    for (i in 1:dim(dataMat$intersect)[1]){

        for(j in 1:dim(dataMat$intersect)[2]){

            num = dataMat$intersect[i,j]
            denom = dataMat$intersect[i,j] + dataMat$cminusk[i,j] + dataMat$kminusc[i,j]

            if (denom != 0){
                similarityMat[i,j] = num/denom
            }

        }

    }

    similarityMat
}
