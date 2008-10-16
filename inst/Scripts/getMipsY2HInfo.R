getMipsY2HInfo <- function(wantDefault = TRUE, toGrep = NULL,
                           parseType = NULL, eCode = NULL){

    fileToRead <- gzfile(system.file("extdata", "PPI_141105.tab.gz", package = "ScISI"), open = "rb")
    dataTable <- rbind.data.frame(strsplit(scan(fileToRead, what = ""), split = "|", fixed = TRUE))

    dataMat = as.matrix(dataTable)

    desc = dataMat[,5]

    index = grep("two hybrid", desc)

    dataY2HMat = dataMat[index,]
    
}
