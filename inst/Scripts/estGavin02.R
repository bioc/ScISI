
library(apComplex)
load("bpAllRedAPMS.rda")
mList <- as.list(bpAllRedAPMS)
Gavin02CompEst <- findComplexes(mList[["Gavin2002BPGraph"]])
save(Gavin02CompEst, file="Gavin02CompEst.rda", compress=TRUE)

