getLocOrfs <- function(imList, goNode, pathToSave=NULL){

    options(error=recover)
    yG2AP <- as.list(YEASTGO2ALLPROBES)
    locOrf <- yG2AP[goNode]

    #xx = names(as.list(GOTERM))
    #gt <- getGOTerm(xx)
    #gtcc <- gt$CC
    #yy <- as.list(YEASTGO2PROBE)

    #goCCO <- as.list(GOCCOFFSPRING)
    #nucOff <- unlist(goCCO[goNode])

    #nucProt <- unique(unlist(yy[nucOff]))
    #nucProt

    localizationL <- vector("list", length = length(locOrf))
    names(localizationL) <- goNode
    
    for(i in 1:length(imList)){
        for(j in 1:length(locOrf)){
        
            rnames <- rownames(imList[[i]])
            common <- intersect(rnames, locOrf[[j]])
            indexR <- rnames %in% common
            newIM <- imList[[i]][common,]
            newIM <- newIM[, -(which(colSums(newIM)==0))]
            newIM <- newIM[, -(which(colSums(newIM)==1))]
            indexC <- colnames(imList[[i]]) %in% colnames(newIM)
            truncIM <- imList[[i]][,indexC]
            
            ratio <- colSums(newIM) / colSums(truncIM)
            
            statL <- list()
            statL$restrictedOrfsComp <- newIM
            statL$restrictedOrfsOnly <- truncIM
            statL$ratio <- ratio
            
            localizationL[[goNode[j]]][[names(imList)[i]]] <- statL

            
        }
    }

    if(!is.null(pathToSave)){
        save(localizationL, file = paste(pathToSave,"localizationL.rda", sep=""),
             compress=TRUE)
    }
    
    localizationL
}
