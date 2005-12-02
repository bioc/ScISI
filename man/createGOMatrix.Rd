\name{createGOMatrix}
\alias{createGOMatrix}

\title{A function to create the bipartite graph (BG) incidence matrix
  from the protein complexes parsed from the GO Database}
\description{
  This function takes the output from the \code{\link{getGOInfo}} function and
  creates the bipartite graph (BG) incidence matrix from the output.
}
\usage{
createGOMatrix(cMembers)
}
\arguments{
  \item{cMembers}{A named list consisting of vectors. Each list item is
    named by a protein complex GO ID and points to a character vector
    where each character vector consists of the proteins composing of
    that protein complex.}
}

\value{
  A bipartite graph matrix of the corresponding GO protein complexes
  where the rows are indexed by the protein names and the colunms by
  GO ID's.
}
\author{Tony Chiang}

\examples{
cMembers = getGOInfo(wantAllComplexes = FALSE)
createGOMatrix(cMembers)
}
\keyword{datagen}
\keyword{array}
