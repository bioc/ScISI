\name{runCompareComplex}
\alias{runCompareComplex}

\title{A function that calls all other types of comparison functions}
\description{
  This function begins by acquiring the same vertex set for both BGMat1
  and BGMat2. Then it calls the \code{\link{compareComplex}} function to
  calculate three statistics (see \code{\link{compareComplex}} man page
  for details). Next it calls calculates a similarity measure (default
  is Jaccard). Next it calls the \code{\link{runAlignment}} function to
  greedily calculate an alignment between BGMat1 and BGMat2.
}
\usage{
runCompareComplex(BGMat1, BGMat2, index = "Jaccard", byWhich)
}
\arguments{
  \item{BGMat1}{The first bipartite graph matrix}
  \item{BGMat2}{The second bipartite graph matrix}
  \item{index}{The type of similarity index used}
  \item{byWhich}{A parameter for the maximizeSimilarity
    function. It can either be "ROW", "COL", or "BOTH"}
}
\details{

}
\value{

  The return value of runCompareComplex is a list with the
  following statistics:
  
  \item{simInd}{The matrix of similarity measures between two bipartite
    graphs.}
  \irem{maxIntersect}{The output of maximizeSimilarity. A list. The
    first value is the largest similarity indices between complexes of
    the row and complexes of the columns if byWhich is "ROW" and vice
    versa if byWhich="COL". The second value returns the actual complex
    of highest similarity (column complexes if byWhich="ROW" and row
    complexes if byWhich="COL"}
  \item{equal}{A list of complexes of BGMat1 equal to complexes of
    BGMat2. The values of the list are the complex, C, of BGMat1, the
    complex, K,  of BGMat2, the cardinality of C, the cardinality of K,
    and the cardinality of the intersection of C and K}
  \item{toBeRm}{A character vector of complexes that should be removed
    if two bipartite graphs are merged since they would represent
    redundant complexes. These complexes are derived from BGMat1 only.}
  \item{subcomplex}{A list of complexes of BGMat1 which is contained in
    complexes of BGMat2 or vice versa. The values of the list are the
    complex, C, of BGMat1, the complex, K,  of BGMat2, the cardinality
    of C, the cardinality of K, and the cardinality of the intersection
    of C and K}
}

\author{Tony Chiang}

\examples{
go = getGOInfo()
mips = getMipsInfo()
goM = createGOMatrix(go)
mipsM = createMipsMatrix(mips)
cc = runCompareComplex(mipsM, goM, byWhich = "ROW")
}
\keyword{datagen}
