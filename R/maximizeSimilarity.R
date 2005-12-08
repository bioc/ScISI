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
  
        counter = 1
        maximize = apply(simMat, 1, max)
        maxComp = list()
        
        for(i in 1:length(maximize)){
            if (maximize[i] != 0){


                maxComp[[counter]] = names(which(simMat[i,] == maximize[i]))
                names(maxComp[[counter]]) = rep(names(maximize[i]), length(maxComp[[counter]]))
                counter = counter+1
                
            }
        }
        
    }

    if (bywhich == "COL"){

        maximize = apply(simMat, 2, max)
        maxComp = list()
        counter = 1
        for(i in 1:length(maximize)){
            if(maximize[i] != 0){
                maxComp[[counter]] = names(which(simMat[,i] == maximize[i]))
                names(maxComp[[counter]]) = rep(names(maximize[i]), length(maxComp[[counter]]))
                counter = counter +1
            }
        }

    }

    if(bywhich == "BOTH"){
        maxRow = apply(simMat, 1, max)
        maxRowComp = list()
        counter1 = 1
        for(i in 1:length(maxRow)){
            if (maxRow[i] != 0){
                maxRowComp[[counter1]] = names(which(simMat[i,] == maxRow[i]))
                names(maxRowComp[[counter1]]) = rep(names(maxRow[i]), length(maxRowComp[[counter1]]))
                counter1 = counter1+1
            }
        }


        maxCol = apply(simMat, 2, max)
        maxColComp = list()
        counter2 = 1
        for(j in 1:length(maxCol)){
            if (maxCol[j] != 0){
                maxColComp[[counter2]] = names(which(simMat[,j] == maxCol[j]))
                names(maxColComp[[counter2]]) = rep(names(maxCol[j]), length(maxColComp[[counter2]]))
                counter2 = counter2+1
            }
        }


        maximize = list()
        maximize$row = maxRow
        maximize$column = maxCol
        maxComp = list()
        maxComp$row = maxRowComp
        maxComp$column = maxColComp
    }
        

    ##if (zeroSim == "NO"){
     ##   if(bywhich != "BOTH"){
      ##      isZero = which(maximize == 0)
       ##     maxComp = maxComp[-isZero]
        ##}
        ##else{
         ##   isRowZero = which(maxRow == 0)
          ##  maxComp$row = maxComp$row[-isRowZero]
           ## isColZero = which(maxCol == 0)
           ## maxComp$column = maxComp$column[-isColZero]
        ##}
    ##}

    maxList = list()
    maxList$maximize = maximize
    maxList$maxComp = maxComp
    maxList

}
