\name{redundantM}
\alias{redundantM}
\docType{data}
\title{A matrix of redundant complex summary statistics}
\description{
  This matrix contains the redundant protein complex summary statistics
  for the ScISI. The rows and columns are indexed by the individual data-set
  from where the protein complex estimates orginated. The (i,j) entry
  details how many protein complexes of the index i are identical to those
  with respect to index j. This matrix is symmetric.
}
\usage{data(redundantM)}
\format{
  Matrix
}

\examples{
data(redundantM)
}
\keyword{datasets}
