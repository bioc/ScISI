collectY2HData <- function(wantDataFrame = TRUE, wantAM = TRUE, wantY2HList = TRUE){

    library(YEAST)
    load("yeastIntAct_tableList.RData")


    ##This is the Intact ID's for the different y2h data
    y2hID <- c("EBI-375746", "EBI-531419", "EBI-295760", "EBI-698096",
               "EBI-592695", "EBI-476385", "EBI-476699", "EBI-493706", "EBI-620118",
               "EBI-619785", "EBI-492533", "EBI-492535", "EBI-697014", "EBI-538313",
               "EBI-538324", "EBI-531492", "EBI-526219", "EBI-491968", "EBI-707901",
               "EBI-74070",  "EBI-603898", "EBI-597864", "EBI-455820", "EBI-457380",
               "EBI-457455", "EBI-79957",  "EBI-603955", "EBI-600030", "EBI-600812",
               "EBI-601450", "EBI-75443",  "EBI-727915", "EBI-607722", "EBI-525791",
               "EBI-476132", "EBI-49802",  "EBI-491628", "EBI-491642", "EBI-762635",
               "EBI-389903", "EBI-392769")

    sLabel <- tableList[["acInfo"]][,"ac"] %in% y2hID

    shortL <- tableList[["acInfo"]][sLabel,"shortLabel"]

    n <- length(y2hID)


    ##We chose all the id's that were either labelled bait or prey
    isBait <- tableList[["interaction2interactor"]][, "role"] == "bait"
    isPrey <- tableList[["interaction2interactor"]][, "role"] == "prey"
    
    ##For each experiment, we wanted to collect every interaction associated;
    ##So for each experiment, there will be k interactions...we want them all
    ##Here we simple get the row indices...
    isExp = vector("list", length = n)
    for (i in 1:n){
        
        isExp[[i]] <- tableList[["experiment2interaction"]][, "experiment"] == y2hID[i]
    }

    ##From the indices collected above, we subset the table so all the interactions of
    ##a particular experiment are collected:
    interaction <- vector("list", length = n)
    for (i in 1:n){

        interaction[[i]] <-  tableList[["experiment2interaction"]][isExp[[i]],"interaction"]
    }

    ##Now we go to another table. We want to find all the players in the interactions we
    ##have collected above. The following returns a logical...we will get the row index
    ##if the interaction is the one in which we are interested: 
    interactor <- vector("list", length = n)
    for (i in 1:n){

        interactor[[i]] <- tableList[["interaction2interactor"]][,"interaction"]%in% interaction[[i]]
    }
    
    ##Now we go into the same table as above; for each interaction, we want only those
    ##players corresponding to that interaction...since this is y2h, everyone element
    ##should only have two items...here we merely get the row indices
    b2p <- vector("list", length = n)
    for (i in 1:n){
        
        b2p[[i]] <- lapply(interaction[[i]], function(x)
                       which(tableList[["interaction2interactor"]][, "interaction"] == x))
    }

    ##In this list, we systematically build our interactions. We take the double row numbers
    ##collected above, and create a list of interactions.
    b2pList <- vector("list", length = n)
    for (i in 1:n){
        b2pList[[i]] <- lapply(b2p[[i]], function(x){
            tableList[["interaction2interactor"]][x[1]:x[2],]
        })
    }

    ##This checks to see which element in b2pList is the bait
    check1 <- vector("list", length = n)
    for(i in 1:n){
        check1[[i]] <- sapply(b2pList[[i]], function(x) which(x[,"role"] == "bait"))
    }

    ##This checks for the prey
    check2 <- vector("list", length = n)
    for(i in 1:n){
        check2[[i]] <- sapply(b2pList[[i]], function(x) which(x[,"role"] == "prey"))
    }

    ##Later we will use the bait-prey pairs to build either a data.frame, an adjacency
    ##matrix, or a list of matrices. From the b2pList, we simple extract the bait element
    ##and then the prey element.
    indexSetAll <- vector("list", length = n)
    for (i in 1:n){
        indexSet <- vector("list", length = length(b2pList[[i]]))
        for(j in 1:length(indexSet)){
            indexSet[[j]] = c(b2pList[[i]][[j]][check1[[i]][j], "interactor"],
                              b2pList[[i]][[j]][check2[[i]][j], "interactor"])
        }

        indexSetAll[[i]] <- indexSet
    }

    ##We create a list of all the baits for each experiment.
    baits <- vector("list", length = n)
    for (i in 1:n){
        Baits <- tableList[["interaction2interactor"]][(interactor[[i]] & isBait),"interactor"]
        uBait = unique(Baits)
        #whichbait <- match(uBait, tableList[["acInfo"]][, "ac"])
        #geneBait <- tableList[["acInfo"]][whichbait, "shortLabel"]
        #stanNameTmp = sapply(geneBait, function(x) strsplit(x, "_yeast"))
        #stanGeneNameBait = unlist(stanNameTmp)
        baits[[i]] <- uBait       
    }

    ##We create a list of all the prey for each experiment
    preys <- vector("list", length = n)
    for (i in 1:n){
        Preys <- tableList[["interaction2interactor"]][(interactor[[i]] & isPrey),"interactor"]
        uPrey = unique(Preys)
        #whichprey <- match(uPrey, tableList[["acInfo"]][, "ac"])
        #genePrey <- tableList[["acInfo"]][whichprey, "shortLabel"]
        #stanNameTmp = sapply(genePrey, function(x) strsplit(x, "_yeast"))
        #stanGeneNamePrey = unlist(stanNameTmp)
        preys[[i]] <- uPrey        
    }

    ##We take the union of all the baits
    allBaits <- vector()
    for (i in 1:length(baits)){
        allBaits <- union(allBaits, baits[[i]])
    }

    ##We take the union of all the preys
    allPreys <- vector()
    for (i in 1:length(baits)){
        allPreys <- union(allPreys, preys[[i]])
    }


    r = length(allBaits)
    c = length(allPreys)
#################################
    ##The baitSystematic vector will be a mapping of the Intact codes to Yeast Systematic Names
    baitsSystematic <- vector(length = length(allBaits))
    yeast2Sys <- as.list(YEASTCOMMON2SYSTEMATIC)
    yeast2Sys <- yeast2Sys[!is.na(yeast2Sys)]
    yeastAlias <- names(unlist(as.list(YEASTALIAS)))
    notfound <- vector()
    notfoundSGD <- vector()
    notfound2 <- vector()
    notfound2SGD <- vector()
    
    for(i in 1:length(allBaits)){

        baitN <- allBaits[i]
        whichbait <- tableList[["ac2xref"]][, "ac"] %in% baitN
        subTable <- tableList[["ac2xref"]][whichbait,1:4]

        onlyWantSgd = which(subTable[,"db"] == "sgd")
        ac2SgdCode = split(subTable[onlyWantSgd,4], subTable[onlyWantSgd,1])
        ac2SgdCode <- lapply(ac2SgdCode, unique)
        sgdC <- unlist(ac2SgdCode)
        
        if (length(sgdC) == 1){
            if (!is.null(yeast2Sys[[sgdC]])){
                baitsSystematic[i] <- yeast2Sys[[sgdC]][1]
            }
            
            else {

                
                
                if(sgdC %in% yeastAlias){
                    baitsSystematic[i] <- sgdC
                }
                else{
                    baitsSystematic[i] <- baitN
                    notfound <- c(notfound, baitN)
                    notfoundSGD <- c(notfoundSGD, sgdC)
                }
            }
        }

        else{
            if(is.null(sgdC)){
                baitsSystematic[i] <- baitN
            }
            else {
                baitsSystematic[i] <- sgdC[1]
                notfound2 <- c(notfound2, baitN)
                notfound2SGD <- c(notfound2SGD, sgdC)
            }
        }

    }

    ##NB, there will still some names, 114, that did not map and
    ##needed to be mapped by hand

    
    ##Mappng the prey to Systematic names    
    preysSystematic <- vector(length = length(allPreys))
    notfoundP <- vector()
    notfoundSGDP <- vector()
    notfound2P <- vector()
    notfound2SGDP <- vector()
    
    for(i in 1:length(allPreys)){

        preyN <- allPreys[i]

        whichprey <- tableList[["ac2xref"]][, "ac"] %in% preyN
        subTableP <- tableList[["ac2xref"]][whichprey,1:4]

        onlyWantSgd = which(subTableP[,"db"] == "sgd")
        ac2SgdCode = split(subTableP[onlyWantSgd,4], subTableP[onlyWantSgd,1])
        ac2SgdCode <- lapply(ac2SgdCode, unique)
        sgdC <- unlist(ac2SgdCode)

        if (length(sgdC) == 1){
            if (!is.null(yeast2Sys[[sgdC]])){
                #print(yeast2Sys[sgdC][1])
                preysSystematic[i] <- yeast2Sys[[sgdC]][1]
            }
            
            else {

                
                
                if(sgdC %in% yeastAlias){
                    preysSystematic[i] <- sgdC
                }
                else{
                    preysSystematic[i] <- preyN
                    notfoundP <- c(notfoundP, preyN)
                    notfoundSGDP <- c(notfoundSGDP, sgdC)
                }
            }
        }

        else{
            if(is.null(sgdC)){
                preysSystematic[i] <- preyN
            }
            else{
                preysSystematic[i] <- sgdC[1]
                notfound2P <- c(notfound2P, preyN)
                notfound2SGDP <- c(notfound2SGDP, sgdC)
            }
        }

    }



#######################################################################################################
    if(wantY2HList){
        y2hList <- vector("list", length = r)
        names(y2hList) <- allBaits
        
        prey2ExpMat <- matrix(0, nrow = c, ncol = length(y2hID))
        rownames(prey2ExpMat) <- allPreys
        colnames(prey2ExpMat) <- y2hID
        
        for(i in 1:r){
            y2hList[[i]] <- prey2ExpMat
        }
        
        for (i in 1:length(indexSetAll)){
            for(j in 1:length(indexSetAll[[i]])){
                y2hList[[indexSetAll[[i]][[j]][1]]][indexSetAll[[i]][[j]][2], y2hID[i]] = 1
            }
        }

    }

    names(y2HList) <- baitsSystematic
    for (i in 1:length(y2HList)){

        rownames(y2HList[[i]]) <- preysSystematic

    }

    
##########################

    ##creating the data.frame
    if(wantDF){
        for (i in 1:length(indexSetAll)){
            for (j in 1:length(indexSetAll[[i]])){
                indexSetAll[[i]][[j]] <- c(indexSetAll[[i]][[j]], y2hID[i])
                
            }
        }
        
        indDF <- lapply(indexSetAll, function(y) t(data.frame(y)))
        
        aggDF <- data.frame()
        for (i in 1:length(indDF)){
            
            aggDF <- rbind(aggDF, indDF[[i]])
        }
        
        colnames(aggDF) = c("Bait","Prey","Experiment")

        
    }

##########################    
    if(wantAM){
        ##create two matrices: an adjacency matrix y2hBPadjMat
        y2hBPadjMat <- matrix(0, nrow = r, ncol = c)
        ##and an indexing matrix of the same name
        indexingMat <- matrix("|empty|", nrow = r, ncol = c)
        ##the latter matrix is a matrix of characters...for each bait/prey
        ##double (i.e. a entry based on row and column) the indexing matrix
        ##will keep all those experiments which either verified a binary
        ##interaction or did not
        
        
        ##both matrices are indexed identically by the baits and prey
        rownames(y2hBPadjMat) = allBaits
        colnames(y2hBPadjMat) = allPreys
        
        rownames(indexingMat) = allBaits
        colnames(indexingMat) = allPreys

        for (i in 1:length(indexSetAll)){
            for (j in 1:length(indexSetAll[[i]])){
                y2hBPadjMat[indexSetAll[[i]][[j]][1], indexSetAll[[i]][[j]][2]] = 1
                indexingMat[indexSetAll[[i]][[j]][1], indexSetAll[[i]][[j]][2]] =
                  paste(indexingMat[indexSetAll[[i]][[j]][1], indexSetAll[[i]][[j]][2]], shortL[i], "|", sep = "")
            }
        }

        rownames(y2hBPadjMat) <- baitsSystematic
        colnames(y2hBPadjMat) <- preysSystematic

    }
    
    
}






#rNames <- allBaits
#whichbait <- match(rNames, tableList[["acInfo"]][, "ac"])
#geneBait <- tableList[["acInfo"]][whichbait, "shortLabel"]
#stanNameTmp = sapply(geneBait, function(x) strsplit(x, "_yeast"))
#stanGeneNameBait = unlist(stanNameTmp)
#stanGeneNameBait <- toupper(stanGeneNameBait)
#getRid <- strsplit(stanGeneNameBait, "_", fixed=TRUE)
#stanGeneNameBait <- sapply(getRid, function(t) t[1])

#index1 <- grep("^Q", stanGeneNameBait)
#test1 = allBaits[index1]
#tmpIndex <- tableList[["ac2xref"]][,"ac"] %in% test1
#tmpIndex <- match(test1, tableList[["ac2xref"]][,"ac"])
#tmpIndex <- tmpIndex[!is.na(tmpIndex)]
#nT = tableList[["ac2xref"]][tmpIndex,]
#dbIndex = which(nT[,"db"] == "sgd")
#sgdInfo = split(nT[dbIndex,4], nT[dbIndex,1])
#lapply(sgdInfo, unique)

#test2 = allBaits[-index1]
#tmp2Index <- match(tableList[["ac2xref"]][,"ac"], test2)
#tmp2Index <- tmp2Index[!is.na(tmp2Index)]
#nT2 = tableList[["ac2xref"]][tmp2Index,]
#dbIndex2 = which(nT2[,"db"] == "sgd")
#sgdInfo2 = split(nT2[dbIndex2,4], nT2[dbIndex2,1])
#lapply(sgdInfo2, unique)

#cNames <- allPreys
#whichprey <- match(cNames, tableList[["acInfo"]][, "ac"])
#genePrey <- tableList[["acInfo"]][whichprey, "shortLabel"]
#stanNameTmp = sapply(genePrey, function(x) strsplit(x, "_yeast"))
#stanGeneNamePrey = unlist(stanNameTmp)
#stanGeneNamePrey <- toupper(stanGeneNamePrey)
#getRid <- strsplit(stanGeneNamePrey, "_", fixed=TRUE)
#stanGeneNamePrey <- sapply(getRid, function(t) t[1])

#index3 <- grep("^Q", stanGeneNameBait)
#test3 = allPreys[index3]
#tmp3Index <- tableList[["ac2xref"]][,"ac"] %in% test3
#tmpIndex <- match(test1, tableList[["ac2xref"]][,"ac"])
#tmpIndex <- tmpIndex[!is.na(tmpIndex)]
#nT3 = tableList[["ac2xref"]][tmp3Index,]
#dbIndex3 = which(nT3[,"db"] == "sgd")
#sgdInfo3 = split(nT3[dbIndex3,4], nT3[dbIndex3,1])
#lapply(sgdInfo3, unique)

#test4 = allBaits[-index3]
#tmp4Index <- match(tableList[["ac2xref"]][,"ac"], test4)
#tmp4Index <- tmp4Index[!is.na(tmp4Index)]
#nT4 = tableList[["ac2xref"]][tmp4Index,]
#dbIndex4 = which(nT4[,"db"] == "sgd")
#sgdInfo4 = split(nT4[dbIndex4,4], nT2[dbIndex4,1])
#lapply(sgdInfo4, unique)



#c2S <- as.list(YEASTCOMMON2SYSTEMATIC)
#c2S <- c2S[!is.na(c2S)]

#sysBaitN <- c2S[stanGeneNameBait]
#sysPreyN <- c2S[stanGeneNamePrey]

#names(y2hList) <- sysBaitN
#lapply(y2hList, function(s) rownames(s) = sysPreyN)


