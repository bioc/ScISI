
library(apComplex)
load("bpAllRedAPMS.rda")
mList <- as.list(bpAllRedAPMS)
Gavin06CompEst <- findComplexes(mList[["Gavin2006BPGraph"]], commonFrac=.5)
save(Gavin06CompEst, file="Gavin06CompEst.rda", compress=TRUE)

