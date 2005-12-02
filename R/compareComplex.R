compareComplex <- function(BGMat1, BGMat2){

    ##We would like to compare the complexes derived from the two different Bipartite Graph Matrices.
    ##To this end, we calculate three
    ##statistics: (1) the numbers of proteins common to both complex C_i and K_j (denoted by a),
    ##(2) the number of proteins present in C_i but absent in K_j (denoted by b), and (3)
    ## the number of proteins present in K_j and absent in C_i (denoted by c). NB C_i are the
    ##columns of BGMat1, and K_j, BGMat2. 
    
    identical(rownames(BGMat1),rownames(BGMat2)) || stop("Rownames of both matrices must be identical.") 
    dlist <- list(intersect= t(BGMat1)  %*%  BGMat2,  ## calculates statistic "a",
                  cminusk= t(BGMat1) %*% !BGMat2,     ## calculates statistic "b"
                  kminusc = t(!BGMat1) %*% BGMat2)    ## calculates statistic "C"

    dlist
}






































                                      
