\name{recCompSize}
\alias{recCompSize}

\title{A function that records the relative sizes of complex C-i from
  one bipartite graph with complex K-j from a different bipartite graph.}
\description{
  This function takes two bipartite graph matrices, bg1 and bg2. For
  each complex C-i of bg1, we find the relative size of C-i for every
  complex K-j of bg2. A matrix of these ratios is returned with all
  cardinalities of C-i as the numerators and K-j as denominators. A
  second matrix is calculated where the cardinality of K-j is the
  numerator and C-i is the denominator.
}
\usage{
recCompSize(bg1, bg2)
}

\arguments{
  \item{bg1}{The first bipartite graph as an incidence matrix}
  \item{bg2}{The second bipartite graph as an incidence matrix}
}

}
\value{
  The return value is a list:
  \item{OneOverTwo}{The matrix where the cardinalities of complexes from
  bg1 are numerators.}
  \item{TwoOverOne}{Matrix where cardinalities of complexes from bg2 are
    numerators.}
  ...
}

\author{Tony Chiang}

\examples{
go = getGOInfo(wantAllComplexes = FALSE)
goM = createGOMatrix(go)
mips = getMipsInfo(wantSubComplexes = FALSE)
mipsM = createMipsMatrix(mips)
recCompSize(goM, mipsM)
}
\keyword{datagen}
