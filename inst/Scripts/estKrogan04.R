
library(apComplex)
load("bpAllRedAPMS.rda")
mList <- as.list(bpAllRedAPMS)
Krogan04CompEst <- findComplexes(mList[["Krogan2004BPGraph"]])
save(Krogan04CompEst, file="Krogan04CompEst.rda", compress=TRUE)
