createMipsMatrix <- function(mipsL){

  MIPs = mipsL$Mips
  complexID <- names(MIPs)
  uProteins = unique(unlist(MIPs))
  mips = matrix(0, nrow=length(uProteins), ncol=length(MIPs))
  dimnames(mips) = list(uProteins, names(MIPs))
  for(i in 1:length(complexID)){
    mips[MIPs[[i]], complexID[i]] = 1
  }
  uProteins = toupper(uProteins)
  rownames(mips) = uProteins
  mips
}
