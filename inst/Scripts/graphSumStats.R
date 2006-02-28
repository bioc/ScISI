graphSumStats <- function(ISI, bait2PreyL){

    stats <- list()
    for(i in 1:ncol(ISI)){

        comp <- rownames(ISI[which(ISI[,i]==1), i ,drop=FALSE])
        stats[[i]] <- calcGraphStats(comp, bait2PreyL)
        
    }

    names(stats) = colnames(ISI)

    
    stats <- stats[sapply(stats, function(x) !is.na(x$edgeProp))]

    stats
    
}
