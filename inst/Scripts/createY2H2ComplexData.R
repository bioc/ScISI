createY2H2ComplexData <- function(y2hList){

    library(ScISI)
    data(ScISI)
    data(baitsSystematic)
    
    y2hBaitInEachScISI = list()

    for(i in 1:ncol(ScISI)){
        baits = intersect(baitsSystematic, names(ScISI[which(ScISI[,i] == 1),i]))
        y2hBaitInEachScISI[[i]] = baits
    }
    
    names(y2hBaitInEachScISI) <- colnames(ScISI)
    
    subSetY2HList <- lapply(y2hBaitInEachScISI, function(x) y2hList[x])
    
    numPreyFound <- lapply(subSetY2HList, function(x) {sapply(x,rowSums)})
    
    for (i in 1:length(numPreyFound)){
        
        if (class(numPreyFound[[i]]) == "matrix"){
            index = which(rowSums(numPreyFound[[i]]) != 0)
            numPreyFound[[i]] = numPreyFound[[i]][index,,drop=FALSE]
        }
    }

}
