\name{JaccardCoef}
\alias{JaccardCoef}

\title{A function to calculate the Jaccard similarity index between two sets}
\description{
  The JaccardCoef function takes the return values of
  \code{\link{compareComplex}} function and calculates, for each pair
  of complexes C-i and K-j (where C-i is in first bipartite graph matrix
  and K-j is second), the similarity coefficient of Jaccard.
}
\usage{
JaccardCoef(dataMat)
}

\arguments{
  \item{dataMat}{A list which is the output from
    \code{\link{compareComplex}}, which is a list of three matrices:
      intersect, cminusk, and kminusc which are explained in the details.}
}
\details{
  The argument of this function is a list of three matrices all of whom
  are indexed exactly in the same manner - the rows of each of the
  matrix is indexed by the complexes, \{C-i\}, of the first bipartite
  graph, bg1, and the colunms are indexed by the complexes, \{K-j\} of
  the second bipartite graph, bg2.

  The first matrix of the list is the intersect matrix, I. The (i,j)
  entry of I is the cardinality of complex C-i of bg1 and K-j of bg2.

  The second matrix of the list is the cminusk matrix, Q. The (i,j)
  entry of Q is the cardinality of the set difference between C-i and
  K-j.

  The third matrix of the list is the kminusc matrix, P. The (i,j) entry
  of P is the cardinality of the set difference between K-j and C-i.

  The Jaccard Coefficient between two sets (here between two complexes)
  C-i and K-j is given by the quotient of cardinality(C-i intersect K-j)
  and cardinality(C-i union K-j). Note that cardinality(C-i intersect
  K-j) is the (i,j) entry of I, and that cardinality(C-i union K-j) is
  the sum of the (i,j) entry of I, Q, P.
}
\value{
  
  The return value is a matrix consisting of the
  Jaccaard coefficient for each pair of complexes C-i and K-j
  with rows in indexed by C-i and columns indexed by K-j.
  
}

\author{Tony Chiang}

\examples{
go = getGOInfo(wantAllComplexes=FALSE)
mips = getMipsInfo(wantAllComplexes=FALSE)
goM = createGOMatrix(go)
mipsM = createMipsMatrix(mips)
cc = runCompareComplex(mipsM, goM, byWhich = "ROW")
cc$simInd
}
\keyword{datagen}
