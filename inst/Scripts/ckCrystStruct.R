ckCrystStruct <- function(){

    data(arp23)
    data(cfia)
    data(arp23Orf)
    data(cfiaOrf)
    
    library("y2hStat")
    data(intactInfo)

    bp <- lapply(intactInfo, function(x) x$bpList)
    bp2arp23 <- list()
    for(i in 1:length(arp23Orf)){
        bp2arp23[[i]] <- lapply(bp, function(x) x[[arp23Orf[i]]])
    }

    print(bp2arp23)
    
    bp2cfia <- list()
    for(i in 1:length(cfiaOrf)){
        bp2cfia[[i]] <- lapply(bp, function(x) x[[cfia[i]]])
    }

    print(bp2cfia)
    
    data(ppipred)

    check1a <- ppipred[,1] %in% arp23
    newPpipred <- ppipred[check1a,]
    check1b <- ppipred[check1a,2] %in% arp23
    print(newPpipred[check1b,])
    
    
    check2a <- ppipred[,2] %in% arp23
    newPpipred2 <- ppipred[check2a,]
    check2b <- ppipred[check2a,1] %in% arp23
    print(newPpipred2[check2b,])

    
    check3a <- ppipred[,1] %in% cfia
    newPpipred3 <- ppipred[check3a,]
    check3b <- ppipred[check3a,2] %in% cfia
    print(newPpipred3[check3b,])


    check4a <- ppipred[,2] %in% cfia
    newPpipred4 <- ppipred[check4a,]
    check4b <- ppipred[check4a,1] %in% cfia
    print(newPpipred4[check4b,])

    
}
