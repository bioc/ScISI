\name{compBijection}
\alias{compBijection}

\title{A recursive function that greedily handles the alignment issue}
\description{
  This function takes a matrix of similarity measures (e.g. Jaccard
  Index) between the TSNMat and the estMat and finds the maximal value
  of this matrix and records its position (i,j). Then it matches C-i to
  K-j and then deletes row i and colunm j creating a matrix with one
  less row and one less colunm. The function calls itself recursively
  using this smaller matrix as the new argument. It stops when there are
  either no rows left or no columns left or the matrix of similarity
  measures is reduced to a 0-matrix and breaks from the recursive
  loop. 
}
\usage{
compBijection(TSNMat, estMat, c2kMatrix, bijMat, counter = 1)
}

\arguments{
  \item{TSNMat}{The first bipartite graph matrix}
  \item{estMat}{The second bipartite graph matrix}
  \item{c2kMatrix}{A matrix of similarity measure}
  \item{bijMat}{A recording matrix to keep the alignment}
  \item{counter}{A place keeping index}
}
\details{
  The function creates a greedy matching between two bipartite graphs
  (where complexes C-i of the first bipartite graph matrix, bg1, is
  matched to complexes K-j of the second bipartite graph matrix,
  bg2). The particular greedy algorithm is as follows:

  1. When the function is called, the parameter c2kMatrix is parsed and
  the maximal element, m, is found. If m is not unique in the matrix,
  the function looks to every position where m occurs:
  (i,j)...(m,n). To chose a particular position, the size of the
  complexes are taken into consideration, i.e. the function compares the
  cardinalities of (C-i + K-j) ... (C-n + K-n). And the pair, wlog (i,j), of
  complexes with the largest cardinality is selected (if there is again
  a tie amongst cardinalities, then a random choice is made).

  2. The function matches C-i to K-j and records this alignment into
  bijMat. Row i and colunm j is deleted from c2kMatrix, creating a new
  matrix called c2kM.

  3. If the dimension of this matrix is nonzero or if the matrix itself
  has some nonzero element, the function recursively calls itself with
  the new argument, c2kM.

  4. Because the dimension is always decreased with every call, this
  function must terminate in some finite number of steps.

  5. bijMat will have recorded the greedily matched complexes between
  bg1 and bg2.

  
}
\value{
 A matrix with the rows recording the alignment: the first colunm records
 complexes of TSNMat; the second column records complexes of estMat; and
 the third column records the similarity measure. The rows will also
 denote the ordering of the matchings, i.e. row 1 will denote the first
 match, etc.
}

\author{Tony Chiang}

\examples{
}
\keyword{array}
\keyword{datagen}
