getMipsY2HInfo <- function(wantDefault = TRUE, toGrep = NULL,
                           parseType = NULL, eCode = NULL){

    fileToRead <- gzfile(system.file("extdata", "PPI_141105.tab.gz", package = "ScISI"), open = "rb")
    dataTable <- do.call("rbind.data.frame", strsplit(gsub("\\|$", "||", scan(fileToRead, what = "")), split = "|", fixed = TRUE))
    close(fileToRead)

    dataMat = as.matrix(dataTable)

    desc = dataMat[,5]

    index = grep("two hybrid", desc)

    dataY2HMat = dataMat[index,]
    
}
