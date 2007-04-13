
library(apComplex)
load("bpAllRedAPMS.rda")
mList <- as.list(bpAllRedAPMS)
Krogan06CompEst <- findComplexes(mList[["Krogan2006BPGraph"]], commonFrac=.5)
save(Krogan06CompEst, file="Krogan06CompEst.rda", compress=TRUE)
