edgeProp <- function(comp, compB2P, sampled){

    proteins <- unique(c(comp, unlist(compB2P)))    
    b2pAM <- matrix(0, nrow=length(proteins),
                    ncol=length(proteins))
    rownames(b2pAM) <- proteins
    colnames(b2pAM) <- proteins
                         
    
    for(i in 1:length(compB2P)){
        if(length(compB2P[[i]] != 0)){
            for(j in 1:length(compB2P[[i]])){
                b2pAM[comp[i], compB2P[[i]][j]] = 1
                b2pAM[compB2P[[i]][j], comp[i]] = 1
            }
        }
    }

    ###print(b2pAM)
    if(sum(b2pAM)>0){
        y2hGraph <- as(b2pAM, "graphNEL")
    }

    else{
        y2hGraph <- NA
    }
    ###print(y2hGraph)
    
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
    
    eList <- list()
    eList$eProp <- eProp
    eList$y2hGraph <- y2hGraph
    eList
}
