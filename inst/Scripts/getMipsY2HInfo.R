getMipsY2HInfo <- function(wantDefault = TRUE, toGrep = NULL,
                           parseType = NULL, eCode = NULL){

    fileToRead <- gzfile(system.file("extdata", "PPI_141105.tab.gz", package = "ScISI"), open = "rt")
    dataMat <- as.matrix(read.table(fileToRead, sep = "|"))
    close(fileToRead)

    desc = dataMat[,5]

    index = grep("two hybrid", desc)

    dataY2HMat = dataMat[index,]
    
}
