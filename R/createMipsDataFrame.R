createMipsDataFrame <- function(desc, mips){

    #leftInMipsM <- strsplit(colnames(mips), "MIPS-")
    #leftInMipsM <- sapply(leftInMipsM, function(x) x[2])
    nm <- colnames(mips)
    MipsID = intersect(nm, names(desc))
    MipsNames = desc[MipsID]
    interactomeNames = colnames(mips)
    MipsReference = data.frame(names=I(interactomeNames),id=I(MipsID), description=I(MipsNames))

    MipsReference
}
