\name{findSubComp}
\alias{findSubComp}

\title{A function that looks for either equality between two complexes
  or complete containment of one complex in another}
\description{
  This function determines if either a complex C-i of bg1 is equal to
  some complex K-j of bg2 or if a complex C-i (or K-j) is a subcomplex
  to K-j (or C-i). 
}
\usage{
findSubComp(bg1, bg2, interSectMat, simMat)
}

\arguments{
  \item{bg1}{The first bipartite graph matrix}
  \item{bg2}{The second bipartite graph matrix}
  \item{interSectMat}{A matrix whose rows and columns are indexed by
    protein complexes: the rows are indexed by complexes of bg1
    (colnames of bg1) and the columns indexed by complexes of bg2
    (colnames of bg2). The (i,j) entries is the cardinality of the
    intersection between the i-th complex of bg1 and the j-th complex
    of bg2.}
  \item{simMat}{A matrix of similarity measures (e.g. Jaccard Index)
    between two bipartite graphs where the rows are indexed by complexes
    of the first bipartite graph, bg1, and the columns are indexed by the
    complexes of the second bipartite graph, bg2. The (i,j) entry of this
    matrix would be the similarity between C-i of bg1 and K-j of bg2.}
}
\details{
  This function uses interSectMat and simMat to determine which
  complexes C-i of bg1 is equal to which complexes K-j of bg2. When the
  function finds an equality, C-i = K-j, it produces 5 statistics:

  1. The name of C-i
  2. The name of K-j
  3. The cardinality of C-i
  4. The cardinality of K-j
  5. The cardinality of (C-i intersect K-j)

  When all the equality of complexes have been found, this function also
  uses interSectMat and simMat to find which complexes C-i (or K-j)
  completely contain complexes K-n (or C-m respectively), i.e. which
  complexes are subcomplexes. It also returns the 5 statistics listed
  above.

  NB - from the 5 statistics above, it will be clear if the relationship
  between the complexes is that of equality or sub-ordination.
}
\value{

  \item{record1}{A list of lists. The value of each sublist is: 1. a
    complex of bg1, 2. a complex of bg2, 3. the cardinality of the
    complex of bg1, 4. the cardinality of the complex of bg2, 5. the
    cardinality of these two complexes mutual intersection.}
  \item{record3}{A list of lists. The value of each sublist is: 1. a
    complex of bg1, 2. a complex of bg2, 3. the cardinality of the
    complex of bg1, 4. the cardinality of the complex of bg2, 5. the
    cardinality of these two complexes mutual intersection.}
  \item{toBeRm1}{A character vector of the names of complexes in bg1
    that equal some complex in bg2. These complexes should be deleted to
    avoid redundancy if these two bipartite graphs are merged.}
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
\keyword{array}
