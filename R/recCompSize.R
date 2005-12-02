recCompSize <- function(bg1, bg2){

  
  sizeOfComp1 = colSums(bg1)
  sizeOfComp2 = colSums(bg2)

  invComp1 = 1/sizeOfComp1
  invComp2 = 1/sizeOfComp2

  ratio1 = sizeOfComp1 %*% t(invComp2)
  dimnames(ratio1) = list(colnames(bg1), colnames(bg2))
  ratio2 = sizeOfComp2 %*% t(invComp1)
  dimnames(ratio2) = list(colnames(bg2), colnames(bg1))

  ratioList = list()
  ratioList$OneOverTwo = ratio1
  ratioList$TwoOverOne = ratio2

  ratioList

}
