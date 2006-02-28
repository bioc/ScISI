calcGraphStats <- function(comp, bait2PreyL){

    genWide <- sapply(bait2PreyL, function(x) x$expList[["GW"]])
    b2GWPreyL <- bait2PreyL[genWide]
    b2GWPreyL <- b2GWPreyL[!sapply(b2GWPreyL, is.null)]
    b2GWPreyL <- lapply(b2GWPreyL, function(x) x$bpList)
    
    degBait <- list()
    compB2P <- list()
    for(j in 1:length(comp)){
        
        hits <- unique(unlist(lapply(b2GWPreyL, function(x) x[[comp[j]]])))
        
        hitsInComp <- intersect(comp, hits)
        degBait[[j]] <- length(hitsInComp)
        if(is.null(hitsInComp)){
            compB2P[[j]] <- character(0)
        }
        else{
            compB2P[[j]] <- hitsInComp 
        }
        
    }

    sampleTest <- sapply(compB2P, length)
    sampled <- sampleTest[which(sampleTest != 0)]

    
    names(compB2P) <- comp

    eProp <- edgeProp(comp, compB2P, sampled)

    mDeg <- meanDeg(comp, degBait, sampled)


    #print("--------------------------")
    sumStats <- list()
    sumStats$degBait <- degBait
    sumStats$comp <- comp
    sumStats$popMeanDeg <- mDeg
    sumStats$edgeProp <- eProp
    sumStats
    #print(sumStats)


}
