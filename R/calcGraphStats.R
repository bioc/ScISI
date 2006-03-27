calcGraphStats <- function(comp, bait2PreyL){

    b2GWPreyL <- bait2PreyL

    degCompBait <- list()
    degBait <- list()
    compB2P <- list()
    notBait <- vector()
    complexBaits <- vector()
    for(j in 1:length(comp)){

        ##hits are those proteins found by the bait, comp[j] in any y2h experiment.
        ##these proteins need not be in comp
        hits <- unique(unlist(lapply(b2GWPreyL, function(x) x[[comp[j]]])))
        if(is.null(hits)){
            ##we define a bait to be any protein that finds at least one prey
            ##in at least one experiment
            notBait <- c(notBait, comp[j])
        }

        else{
            ##we record this as a bait for this complex, comp
            ##NB - this bait might not find any other comp preys tough...
            complexBaits <- c(complexBaits, comp[j])
        }

        ##degBait = the degree of the baits when prey is GW
        degBait[[j]] <- length(hits)
        

        ##we would like to know what preys are found in this complex, comp
        hitsInComp <- intersect(comp, hits)
        ##degCompBaits = the degree of the baits when restricted to the comp
        degCompBait[[j]] <- length(hitsInComp)
        
        ##now we can record the complex preys for each bait            
        if(is.null(hitsInComp)){
            compB2P[[j]] <- character(0)
            
        }
        else{
            ##compB2P = for each bait, we find the hits in the complex
            compB2P[[j]] <- hitsInComp
          
        }
        
    }

    names(compB2P) <- comp
    names(degBait) <- comp

    
    ##the sample test wants to see the number of preys found by each element of comp
    ##NB - if the sampleTest[i] = 0, this does not mean comp[i] is not a bait...it
    ##simply implies that if comp[i] were a bait, it did not find any comp prey
    sampleTest <- sapply(compB2P, length)
    ##b2CompP (nonTrivialBaits) = those complex baits that found some complex preys
    ##b2CompP stands for "bait to comp preys"
    b2CompP <- names(compB2P)[which(sampleTest!=0)]

    ##degSampledBait = for each non-trivial, how many GW prey did it find:
    ###degSampledBait <- unlist(degBait[which(sampleTest != 0)])

    ##foundPrey = a vector of all the proteins found as baits in the comp
    foundPrey <- unique(unlist(compB2P))

    ##notIsolated = a vector of all proteins that interacte non-trivially with another
    ##protein in the comp
    notIsolated <- c(b2CompP, foundPrey)

    
        
    if(length(complexBaits) != 0){
        ##the avgOutDeg calc the gw average out degree for each bait which is why
        ##it uses degBait and not degCompBait
        avgOutDeg <- (sum(unlist(degBait)))/(length(complexBaits))
    }
    else{
        avgOutDeg = NA
    }

    ###allBaitsPreys <- lapply(bait2PreyL, function(x) x[comp])
    ###allBaits <- unique(unlist(lapply(allBaitsPreys, names))[!is.na(unlist(lapply(allBaitsPreys, names)))])
    ###allPreys <- unique(unlist(allBaitsPreys))

    ##eList = calc the edge proportion and the y2h Adj Mat
    eList <- edgeProp(comp, compB2P, complexBaits)
    
    ##mDeg = calc the meanPopDegree of the baits in comp
    mDeg <- meanDeg(comp, degCompBait, complexBaits)

    
    sumStats <- list()
    sumStats$complex <- comp
    sumStats$complexBaits <- complexBaits
    sumStats$nonTrivialCompBaits <- b2CompP
    sumStats$nonTrivialCompPreys <- unique(unlist(compB2P))
    sumStats$notBait <- notBait
    sumStats$gwAvgOutDeg <- avgOutDeg
    sumStats$nonIsolatedCompProt <- unique(notIsolated)
    sumStats$y2hGraph <- eList$y2hGraph
    sumStats$estNumEdges <- mDeg
    sumStats$edgeProp <- eList$eProp
    #sumStats$degBait <- degBait
    sumStats
    


}
