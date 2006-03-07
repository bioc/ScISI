\name{xtraGONodes}
\alias{xtraGONodes}

\title{A function to check manually curated GO nodes}
\description{
  This function takes any manually curated GO nodes and checks to see if
  those nodes belong should be incorporated to the ScISI
}
\usage{
xtraGONodes(xtraGO, goM)
}
\arguments{
  \item{xtraGO}{A character vector of the GO nodes to be checked}
  \item{goM}{A bi-partite graph incidence matrix of the complexes
    selected by the getGOInfo function and put together by the
    createGOMatrix function.}
}
\value{
  A bi-partite graph incidence matrix with whichever xtraGO nodes
  checked and deemed appropriate added to the goM matrix.
}

\author{T. Chiang}

\examples{

}
\keyword{datagen}

