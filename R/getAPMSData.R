getAPMSData <- function(author = NULL){
    authorVect = c("Gavin", "Ho", "Krogan")
    if(length(intersect(author,authorVect)) != 1){
        stop("You need to specify one experiment: Gavin, Ho, or Krogan")
    }

    if(author == "Gavin"){
        data(yNameTAP)
        mat = yNameTAP
        complexN = vector(length=ncol(mat))
        for(i in 1:ncol(mat)){
            compN = paste("Gavin",i,sep="")
            complexN[i] = compN
        }
        colnames(mat) = complexN
      
    }
    if(author == "Ho"){
        data(MBMEcHMSPCI)
        mat = MBMEcHMSPCI
        complexN = vector(length=ncol(mat))
        for(i in 1:ncol(mat)){
            compN = paste("Ho",i,sep="")
            complexN[i] = compN
        }
        colnames(mat) = complexN
    }
    if(author == "Krogan"){
        data(MBMEcKrogan)
        mat = MBMEcKrogan
        complexN = vector(length=ncol(mat))
        for(i in 1:ncol(mat)){
            compN = paste("Krogan",i,sep="")
            complexN[i] = compN
        }
        colnames(mat) = complexN
    }

    mat



}
