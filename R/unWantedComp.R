unWantedComp <- function(ISI, unwantedComplex =
                         c("GO:0000262",
                           "GO:0000228",
                           "GO:0000775",
                           "GO:0010008",
                           "GO:0005792",
                           "GO:0005768",
                           "GO:0005769",
                           "GO:0005770",
                           "GO:0005777",
                           "GO:0005844",
                           "GO:0001400"),
                         unwantedGenes = c("RNA_TLC1",
                           "SNRNA_NME1", "RNA_RNASE-P")){
                           

    
    
    index = sapply(unwantedComplex, function(x) which(colnames(ISI) == x)) 
    upDatedISI <- ISI[,-index]
    index3 <- which(colSums(upDatedISI)==1)
    upDatedISI <- upDatedISI[, -index3]
    index2 = which(rowSums(upDatedISI) == 0)
    upDatedISI <- upDatedISI[-index2,]
    index4 = sapply(unwantedGenes, function(x) which(rownames(upDatedISI)==x))
    print(index4)
    upDatedISI <- upDatedISI[-index4,]
        
    
}
