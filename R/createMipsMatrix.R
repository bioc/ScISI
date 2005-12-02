createMipsMatrix <- function(mipsL){

    MIPs = mipsL$Mips

    proteins = unlist(MIPs)
    uProteins = unique(proteins)
    mips = matrix(0, nrow=length(uProteins), ncol=length(MIPs))
    compNames1 = vector(length=length(MIPs))
    #for(n in 1:length(MIPs)){
    #    compNames1[n] = paste("MIPS",n,sep="")
    #}
    dimnames(mips) = list(uProteins, names(MIPs))
    
    for(i in 1:length(MIPs)){
        
        nameofMip = names(MIPs)
        
        for(j in 1:length(MIPs[[i]])){
            
            mips[MIPs[[i]][j], nameofMip[i]] = 1
            
    }
        
    }
    #colnames(mips) = compNames1
    uProteins = toupper(uProteins)
    rownames(mips) = uProteins

    mips
  }
