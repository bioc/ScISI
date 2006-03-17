sumStats <- function(imList, pathToSave = NULL){

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
    dimnames(redundantM) <- list(names(imList), names(imList))
    subCompM <- matrix(0, nrow=length(imList), ncol=length(imList))
    dimnames(subCompM) <- list(names(imList), names(imList))
    
    sumStats <- list()

    
    for(i in 1:length(imList)){
        sumStats[[i]] = list()
        for(j in 1:length(imList)){
            sumStats[[i]][[j]] <- runCompareComplex(imList[[i]],
                                                    imList[[j]],
                                                    byWhich="ROW")

            subCStats <- subC(sumStats[[i]][[j]]$subcomplex, c("one", "two"))
            
            if(i==j){
                redundantM[i,j] <- length(sumStats[[i]][[j]]$toBeRm)
                subCompM[i,j] <- subCStats$one + subCStats$two
            }
            else{
                redundantM[i,j] <- length(sumStats[[i]][[j]]$toBeRm)
                subCompM[i,j] <- subCStats$two
            }

            

            
            
        }
    }

    dimnames(redundantM) <- list(names(imList), names(imList))
    dimnames(subCompM) <- list(names(imList), names(imList))
    
    if(!is.null(pathToSave)){
        save(redundantM, file = paste(pathToSave,"redundantM.rda", sep=""), compress=TRUE)
        save(subCompM, file = paste(pathToSave,"subCompM.rda", sep=""), compress=TRUE)
    }
    
    tableL <- list()
    tableL$redundantM <- redundantM
    tableL$subCompM <- subCompM

    tableL

    
    
}
