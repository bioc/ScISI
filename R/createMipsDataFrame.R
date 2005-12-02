createMipsDataFrame <- function(desc, mips){

    MipsID = names(desc)
    MipsNames = desc
    interactomeNames = colnames(mips)
    MipsReference = data.frame(names=I(interactomeNames),id=I(MipsID), description=I(MipsNames))

    MipsReference
}
