\name{runAlignment}
\alias{runAlignment}

\title{A function to establish preliminaries for the
  compBijection function.}
\description{
  This function creates the record keeping bijMat and calls the
  \code{\link{compBijection}} function.
}
\usage{
runAlignment(TSNMat, estMat, c2kMat)
}

\arguments{
  \item{TSNMat}{The first bipartite graph matrix}
  \item{estMat}{The second bipartite graph matrix}
  \item{c2kMat}{The matrix of similarity index between TSNMat and estMat}
}

\value{
  The matrix bijMat with an alignment calculated by the function
  \code{\link{compBijection}}
  
}

\author{Tony Chiang}

\examples{
#go = getGOInfo()
#mips = getMipsInfo()
#goM = createGOMatrix(go)
#mipsM = createMipsMatrix(mips)
#cc = runCompareComplex(mipsM, goM, byWhich = "ROW")
#align = runAlignment(mipsM, goM, cc$simInd)
}
\keyword{array}
\keyword{datagen}
