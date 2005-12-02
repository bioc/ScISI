
 library("ScISI")
##create the GO bipartite graph 
 go = getGOInfo(eCode=NULL, wantAllComplexes = FALSE)
 goCoded = getGOInfo(eCode=c("ISI","ND", "IPI"), toGrep = NULL, wantAllComplexes = FALSE)
 grepL = vector("list", length=1)
 grepL[[1]]$pattern = "\\Bsomal\\b"
 goPhrase = getGOInfo(eCode=NULL, toGrep = grepL, parseType = "grep", wantAllComplexes = TRUE)

##create the Bipartite graph matrix
 goM = createGOMatrix(go)

##create the data frame with all the corresponding information
 goDF = createGODataFrame(go, goM)

##create an instance of yeastData from the GO dataframe
 goOb = createYeastDataObj(goDF)

##create the mips bipartite graph
 mips = getMipsInfo(wantAllComplexes = FALSE)

##create the mips bipartite graph matrix
 mipsM = createMipsMatrix(mips)

##create the mips dataframe
 mipsDF = createMipsDataFrame(mips$DESC, mipsM)

##create an instance of the yeastData object from Mips dataframe
 mipsOb = createYeastDataObj(mipsDF)

##compare the complexes via Jaccard Index
cc = runCompareComplex(mipsM, goM, index="Jaccard", byWhich = "ROW")

##Some of the data stored in cc
cc$equal  ##those complexes that are equal
cc$subcomplex  ##those complexes that are subordinate to another
cc$maxIntersect ## since I set byWhich = "ROW" it will find the column complexes
                ## most similar to each row complex
cc$JC  ##The matrix of Jaccard Coefficients between the two bipartite graphs


##merging and removing the equal complexes
v2=mergeBGMat(mipsM,goM, cc$toBeRm)

##some of these are of length 1
s1= colSums(v2)

v3 = v2[,s1>1]

g1 = getAPMSData("Gavin")

#test to see if rm by code works:

nam = names(go)
sapply(nam, function(w) {setdiff(go[[w]], goCoded[[w]])})

#getting the url and launching the webpages:

cNamesGO = colnames(goM)
urlGO = vector(length = length(cNamesGO))

for (i in 1:length(cNamesGO)){
    urlGO[i] = getURL(goOb, cNamesGO[i])
}


isiLaunchBrowser(urlGO)


cNamesMips = colnames(mipsM)
urlMips = vector(length=length(cNamesMips))

for (i in 1:length(cNamesMips)){
    urlMips[i] = getURL(mipsOb, cNamesMips[i])
}

isiLaunchBrowser(urlMips)
