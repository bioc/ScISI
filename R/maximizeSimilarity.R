maximizeSimilarity <- function(simMat, bywhich = "ROW", zeroSim = "NO"){

    ##This function takes in a matrix of similarity indices where the rows
    ##are indexed by certain protein complexes of one interactome and the
    ##colunms are indexed by another and (WLOG if we inspect the row
    ##interactome) returns the most similar complexes in the column inter-
    ##actome for each row complex. This is neither a well defined mapping since
    ##we can get many column complexes for each row complex nor is its inverse
    ##mapping

    ##NB - the matrix of similarity indices (simMat) is not symmetric
    if (bywhich == "ROW"){

        maximize = apply(simMat, 1, max)
        maxComp = list()
        for(i in 1:length(maximize)){
            maxComp[[i]] = which(simMat[i,] == maximize[i])
         
        }
        names(maxComp) = names(maximize)
    }

    if (bywhich == "COL"){

        maximize = apply(simMat, 2, max)
        maxComp = list()
        for(i in 1:length(maximize)){
            maxComp[[i]] = which(simMat[,i] == maximize[i])
        }
        names(maxComp) = names(maximize)
    }

    if(bywhich == "BOTH"){
        maxRow = apply(simMat, 1, max)
        maxRowComp = list()
        for(i in 1:length(maxRow)){
            maxRowComp[[i]] = which(simMat[i,] == maxRow[i])
        }
        names(maxRowComp) = names(maxRow)

        maxCol = apply(simMat, 2, max)
        maxColComp = list()
        for(j in 1:length(maxCol)){
            maxColComp[[j]] = which(simMat[,j] == maxCol[j])
        }
        names(maxColComp) = names(maxCol)

        maximize = list()
        maximize$row = maxRow
        maximize$column = maxCol
        maxComp = list()
        maxComp$row = maxRowComp
        maxComp$column = maxColComp
    }
        

    if (zeroSim == "NO"){
        if(bywhich != "BOTH"){
            isZero = which(maximize == 0)
            maxComp = maxComp[-isZero]
        }
        else{
            isRowZero = which(maxRow == 0)
            maxComp$row = maxComp$row[-isRowZero]
            isColZero = which(maxCol == 0)
            maxComp$column = maxComp$column[-isColZero]
        }
    }

    maxList = list()
    maxList$maximize = maximize
    maxList$maxComp = maxComp
    maxList

}
