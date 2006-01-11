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
                           "GO:0001400")){
                           

    
    
    index = sapply(unwantedComplex, function(x) which(colnames(ISI) == x)) 
    upDatedISI <- ISI[,-index]
    index2 = which(rowSums(upDatedISI) == 0)
    upDatedISI <- upDatedISI[-index2,]
    
}
