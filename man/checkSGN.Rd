\name{checkSGN}
\alias{checkSGN}

\title{A function to check that the protein names are all systematic
  gene names.}
\description{
  This function takes the in silico interactome and checks the rownames
  against the names of the meta-data set org.Sc.sgdALIAS from the meta-data
  package org.Sc.sgd
}
\usage{
checkSGN(ISI)
}

\arguments{
  \item{ISI}{The in silico interactome as a bipartite graph}
}
\value{
  A character vector of potential gene names not found to be a
  systematic gene name
}

\author{T. Chiang}
\note{
}
\examples{

}
\keyword{datagen}

