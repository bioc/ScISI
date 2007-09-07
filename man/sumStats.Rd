\name{sumStats}
\alias{sumStats}

\title{A function to calculate some summary statistics between an two
  interactomes}
\description{
  This function takes in a named list of in silico interactomes (by its
  incidence matrix representation of the bi-partite graph). The function
  compares each interactome pairwise (with itself as well as with each
  other interactome) and generates some summary statistics: e.g. the
  number of redundant protein complexes, the number of protein
  sub-complexes one interactome may posses with respect to some other
  interactome (possibly itself), etc.
}
\usage{
sumStats(imList, pathToSave = NULL)
}

\arguments{
  \item{imList}{A named list of in silic interactomes (incidence matrix)}
  \item{pathToSave}{A character vector of a path location to where the
    summary statistics will be saved}
}
\details{

}
\value{

  \item{redundantM}{A symmetric matrix with the row and column names
    named by the interactome names. The shows the number of redundancies
    (i.e. the number of repeated protein complexes) within two
    interactomes}
  \item{subM}{A matrix with the row and column names
    named by the interactome names. Each entry details how many protein
    sub-complexes are found within the interactome indexed by the row
    with respect to the interactome indexed by the column}

}
\author{TC}

\examples{
#gavin <- getAPMSData("Gavin")
#krogan <- getAPMSData("Krogan")
#imList <- vector("list", length=2)
#imList[[1]] <- gavin
#imList[[2]] <- krogan
#names(imList) <- c("Gavin", "Krogan")

#sumStats(imList)

}
\keyword{datagen}
