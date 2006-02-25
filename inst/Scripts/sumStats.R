sumStats <- function(imList){

    subC <- function(dataL, twoSets){

        x = sapply(dataL, function(v) v$orderBG1Comp)
        y = sapply(dataL, function(w) w$orderBG2Comp)
        
        z = sum(y<x)
        
        a = sum(x<y)
        
        name1 = twoSets[1]
        name2 = twoSets[2]
        
        q = list(name1 = z, name2 = a)
        names(q) = twoSets
        q
    }

    
    redundantM <- matrix(0, nrow=length(imList), ncol=length(imList))
    subM <- matrix(0, nrow=length(imList), ncol=length(imList))
    
    sumStats <- list()
    
    for(i in 1:length(imList)){
        for(j in 1:i)){
            sumStats[[i]][[j]] <- runCompareComplex(imList[[i]],
                                                    imList[[j]],
                                                    byWhich="ROW")
            if(i==j){
                redundantM[i,j] <- length(sumStats[[i]][[j]]$toBeRm) - ncol(imList[[i]])
            }
            else{
                redundantM[i,j] <- length(sumStats[[i]][[j]]$toBeRm)
            }

            
            
        }
    }
    
    
    
    tableL <- list()
    tableL$redundantM <- redundantM
    tableL$subM <- subM

    tableL
    
}
