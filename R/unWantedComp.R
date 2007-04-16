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
                           

    
  upDatedISI <- ISI
  
  index = sapply(unwantedComplex, function(x) which(colnames(ISI) == x))
  if(length(index !=0)){
    upDatedISI <- upDatedISI[,-index]
  }
  index2 <- which(colSums(upDatedISI)==1)
  if(length(index2)!=0){
    upDatedISI <- upDatedISI[, -index2]
  }
  index3 = which(rowSums(upDatedISI) == 0)
  if(length(index3)!=0){
    upDatedISI <- upDatedISI[-index3,]
  }
  index4 = sapply(unwantedGenes, function(x) which(rownames(upDatedISI)==x))
  if(length(index4)!=0){
    upDatedISI <- upDatedISI[-index4,]
  }
  
  upDatedISI
}
