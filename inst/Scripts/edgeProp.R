edgeProp <- function(comp, compB2P, sampled){

    b2pAM <- matrix(0, nrow=(length(compB2P)+length(unique(unlist(compB2P)))),
                    ncol=(length(compB2P)+length(unique(unlist(compB2P)))))
    rownames(b2pAM) <- c(comp, unique(unlist(compB2P)))
    colnames(b2pAM) <- c(comp, unique(unlist(compB2P)))
                         
    
    for(i in 1:length(compB2P)){
        if(length(compB2P[[i]] != 0)){
            for(j in 1:length(compB2P[[i]])){
                b2pAM[comp[i], compB2P[[i]][j]] = 1
                b2pAM[compB2P[[i]][j], comp[i]] = 1
            }
        }
    }

    if (length(sampled) != 0){
        denominator <- vector()
        for(l in 1:length(sampled)){
            denominator[l] = length(comp) - l
        }
        
        eProp <- (((sum(b2pAM))/2)*(length(comp))*(length(comp) - 1))/(2*(sum(denominator)))
    }


    else{
        eProp <- NA
    }
    
  eProp

}
