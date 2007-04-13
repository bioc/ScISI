
library(apComplex)
load("bpAllRedAPMS.rda")
mList <- as.list(bpAllRedAPMS)
Ho02CompEst <- findComplexes(mList[["Ho2002BPGraph"]])
save(Ho02CompEst, file="Ho02CompEst.rda", compress=TRUE)

