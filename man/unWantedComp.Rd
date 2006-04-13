\name{unWantedComp}
\alias{unWantedComp}

\title{A function to manually remove protein complexes from some in
  silico interactome}
\description{
  This function takes in an in silico interactome by its bipartite graph
  representation and a character vector of complex ID's. The function
  parses through the column names of the in silico interactome and
  removes those columns whose names are found in the character vector.
}
\usage{
unWantedComp(ISI, unwantedComplex = c("GO:0000262", "GO:0000228",
"GO:0000775", "GO:0010008", "GO:0005792", "GO:0005768", "GO:0005769",
"GO:0005770", "GO:0005777", "GO:0005844", "GO:0001400"), unwantedGenes =
c("RNA_TLC1", "SNRNA_NME1","RNA_RNASE-P"))
}

\arguments{
  \item{ISI}{The in silico interactome as a bipartite graph}
  \item{unwantedComplex}{A character vector. Each entry is a protein
    complex id for which should be removed from the interactome.}
  \item{unwantedGenes}{A character vector of gene names that will be
    deleted from the row indexing set of the in silico interactome.}
}
\value{
  An incidence matrix. A new matrix with those columns indexed by
  unwantedComplex removed. It will also remove any protein which is now
  no longer contained in any protein complex.
}

\author{T. Chiang}
\note{
  The entries of unwantedComplex must be found in the column names of
  ISI, otherwise, they will not be removed. This is especially important
  since there are many id's that index the same protein complex.
}
\examples{

mips = getMipsInfo()
go = getGOInfo()
mipsM = createMipsMatrix(mips)
goM = createGOMatrix(go)
mips2go = runCompareComplex(mipsM, goM, byWhich = "ROW")
merged = mergeBGMat(mipsM, goM, mips2go$toBeRm)
ISI = unWantedComp(merged)

}
\keyword{datagen}

