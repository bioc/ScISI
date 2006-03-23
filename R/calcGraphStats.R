calcGraphStats <- function(comp, bait2PreyL){

    #options(error=recover)
    #genWide <- sapply(bait2PreyL, function(x) x$expList[["GW"]])
    #b2GWPreyL <- bait2PreyL[genWide]
    #b2GWPreyL <- b2GWPreyL[!sapply(b2GWPreyL, is.null)]
    #b2GWPreyL <- lapply(b2GWPreyL, function(x) x$bpList)

    b2PGWPreyL <- bait2PreyL
    
    degBait <- list()
    compB2P <- list()
    notBait <- vector()
    complexBaits <- vector()
    for(j in 1:length(comp)){
        
        hits <- unique(unlist(lapply(b2GWPreyL, function(x) x[[comp[j]]])))
        if(is.null(hits)){
            notBait <- c(notBait, comp[j])
        }

        else{
            complexBaits <- c(complexBaits, comp[j])
        }
        
        hitsInComp <- intersect(comp, hits)
        degBait[[j]] <- length(hitsInComp)
        
                    
        if(is.null(hitsInComp)){
            compB2P[[j]] <- character(0)
            
        }
        else{
            compB2P[[j]] <- hitsInComp
          
        }
        
    }

    names(compB2P) <- comp
    names(degBait) <- comp
    
    sampleTest <- sapply(compB2P, length)
    b2CompP <- names(compB2P)[which(sampleTest!=0)]
    
    print("------------------------------")
    
    degSampledBait <- unlist(degBait[which(sampleTest != 0)])

    foundPrey <- unique(unlist(compB2P))

    notIsolated <- c(b2CompP, foundPrey)

    if(length(b2CompP) !=0){
        avgOutDeg <- (sum(degSampledBait))/(length(b2CompP))
    }

    else{
        avgOutDeg = NA
    }
    
    

    eList <- edgeProp(comp, compB2P, b2CompP)
    

    mDeg <- meanDeg(comp, degBait, b2CompP)

    #print(eList$y2hGraph)
    #print(eList$eProp)
    
    #print("--------------------------")
    sumStats <- list()
    sumStats$complex <- comp
    sumStats$complexBaits <- complexBaits
    sumStats$b2CompP <- b2CompP
    sumStats$notBait <- notBait
    sumStats$avgOutDeg <- avgOutDeg
    sumStats$notIsolated <- notIsolated
    sumStats$y2hGraph <- eList$y2hGraph
    sumStats$popMeanDeg <- mDeg
    sumStats$edgeProp <- eList$eProp
    sumStats$degBait <- degBait
    sumStats
    #print(sumStats)


}
