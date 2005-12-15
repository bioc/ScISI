
findSubComp <- function(bg1, bg2, interSectMat, simMat){

    ##This sets up all the recording keeping sets
    record1 = list()
    record3 = list()
    toBeRm1 = vector()
    toBeRm2 = vector()
    rnames = rownames(simMat)
    cnames = colnames(simMat)
    ##This function will allow us an easy way to see if ove complex includes another
    ratio = recCompSize(bg1, bg2)
    
    ratioO = ratio$OneOverTwo
    ratioT = ratio$TwoOverOne
    counter1 = 1
    counter3 = 1

    ##This is a way to gain useful information about two related complexes:
    ##The return value is names of the two complexes, their respective
    ##cardinality, and the cardinality of their mutual intersection.
    if (nrow(bg1) == nrow(bg2) && ncol(bg1) == ncol(bg2)){
        if (sum(rownames(bg1) != rownames(bg2)) == 0
            && sum(colnames(bg1) != colnames(bg2)) == 0) {
            if (sum(bg1 != bg2) == 0){
                for (i in 1:nrow(simMat)){
                    for (j in 1:i){
                        if(simMat[i,j] == 1){
                            rec = list()
                            rec$BG1Comp <- rnames[i]
                            rec$BG2Comp <- cnames[j]
                            rec$orderBG1Comp <- sum(bg1[,rnames[i]])
                            rec$orderBG2Comp <- sum(bg2[,cnames[j]])
                            rec$intersect <- interSectMat[rnames[i], cnames[j]]
                            
                            record1[[counter1]] = rec
                            counter1 = counter1+1
                            toBeRm1 = c(toBeRm1, rnames[i])
                        }
                        
                        if (simMat[i,j] != 0 && simMat[i,j] != 1){
                            
                            if (simMat[i,j] == ratioO[rnames[i], cnames[j]]
                                || simMat[i,j] == ratioT[cnames[j], rnames[i]]){
                                
                                rec = list()
                                rec$BG1Comp = rnames[i]
                                rec$BG2Comp = cnames[j]
                                rec$orderBG1Comp = sum(bg1[,rnames[i]])
                                rec$orderBG2Comp = sum(bg2[,cnames[j]])
                                rec$intersectionBG1BG2 = interSectMat[rnames[i], cnames[j]]
                                record3[[counter3]] = rec
                                counter3 = (counter3)+1
                                if(rec$orderBG1Comp > rec$orderBG2Comp){
                                    toBeRm2 = c(toBeRm2, cnames[j])
                                }
                                if(rec$orderBG1Comp < rec$orderBG2Comp){
                                    toBeRm2 = c(toBeRm2, rnames[i])
                                }
                                
                            }
                        }
                    }
                }
            }
        }
    }

    else{
      for(i in 1:nrow(simMat)){
        for(j in 1:ncol(simMat)){
          ##First we work with those complexes with total simialarity
          if (simMat[i,j] == 1){
            rec = list()
            rec$BG1Comp <- rnames[i]
            rec$BG2Comp <- cnames[j]
            rec$orderBG1Comp <- sum(bg1[,rnames[i]])
            rec$orderBG2Comp <- sum(bg2[,cnames[j]])
            rec$intersect <- interSectMat[rnames[i], cnames[j]]
            
            record1[[counter1]] = rec
            counter1 = counter1+1
            toBeRm1 = c(toBeRm1, rnames[i])
                
            }

            ##Next we look at complexes where one is entirely contained in the other
          if (simMat[i,j] != 0 && simMat[i,j] != 1){
            
            if (simMat[i,j] == ratioO[rnames[i], cnames[j]]
                || simMat[i,j] == ratioT[cnames[j], rnames[i]]){
              
              rec = list()
              rec$BG1Comp = rnames[i]
              rec$BG2Comp = cnames[j]
              rec$orderBG1Comp = sum(bg1[,rnames[i]])
              rec$orderBG2Comp = sum(bg2[,cnames[j]])
              rec$intersectionBG1BG2 = interSectMat[rnames[i], cnames[j]]
              record3[[counter3]] = rec
              counter3 = (counter3)+1
              if(rec$orderBG1Comp > rec$orderBG2Comp){
                  toBeRm2 = c(toBeRm2, cnames[j])
              }
              if(rec$orderBG1Comp < rec$orderBG2Comp){
                  toBeRm2 = c(toBeRm2, rnames[i])
              }
            }
          }
          
        }
      }
    }

    index = which(sapply(record1, function(q) q$BG1Comp != q$BG2Comp))
    toBeRm1 = toBeRm1[index]
    
    SubCompList = list()
    SubCompList$equal = record1
    SubCompList$subcomplex = record3
    SubCompList$toBeRm = toBeRm1
    SubCompList$toBeRmSubC = toBeRm2
    SubCompList
}




    
