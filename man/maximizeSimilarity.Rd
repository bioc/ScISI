\name{maximizeSimilarity}
\alias{maximizeSimilarity}

\title{A function compares two bipartite graph matrices and finds the most
similar matches between the clusters}
\description{
  This function takes a matrix of similarity indices between two
  bipartite graph matrices and determines, for each complex of the first
  bipartite graph matrix (bg1), the most similiar complexes of
  the second bipartite graph matrix (bg2).  
}
\usage{
maximizeSimilarity(simMat, bywhich = "ROW", zeroSim = "NO")
}

\arguments{
  \item{simMat}{A matrix of similarity coefficients between two
    bipartite graph matrices (bg1 and bg2) where the rows are indexed by
    the first bipartite graph matrix and the colunms are indexed by the
    second bipartite graph matrix. The (i,j)th entry is the similarity
    index between complex i of bg1 and complex j of bg2.}
  \item{bywhich}{Takes one of these three arguments: "ROW", "COL",
    "BOTH"}
  \item{zeroSim}{Takes either one of the following arguments: "NO", "YES"}
}
\details{
  This function's purpose is to take one (or both) bipartite graph
  matrix, wlog we take bg1, and, for each complex, C-i, of bg1, finds
  the complex(es) of bg2 that are the most similiar to C-i based on the
  similarity index. Since the complexes of bg1 is indexed by the rows of
  simMat argument, finding the complexes of bg2 that are the most similar
  to C-i means finding the maximal value, m, of row i and then the complexes,
  K-j, that index the colunm for which m belongs.

  If byWhich argument is set to "ROW", the function parses through each
  complex of bg1 and finds the complex(es) of bg2 which are most
  similar. If byWhich is set to "COL", the function parses
  through each complex of bg2 and finds the complex(es) of bg1 which are
  most similar. If byWhich is set to "BOTH", the function parses
  through both the complexes of bg1 and bg2. Since this matrix is not
  symmetric (this matrix is usually not square) this maximizing is
  different between row and column.

  If zeroSim argument is set to "NO", the only maximal matching occurs if
  the similarity index is nonzero; e.g. if we want to maximize the match
  for complex C-i of bg1, but row i is comprised only of 0, C-i will not
  be matched to any complex of bg2.

}
\value{
  The return value is a list consisting of a vector and a list:
  \item{maximize}{A named numeric vector. The name is the complex, C-i,
    for which the function is trying to find a maximal match. The
    entries of the vector is the maximal similarity index between C-i
    and all of the complexes of the other bipartite graph matrix,
    i.e. the maximal entry row i in \code{simMat}.}
  \item{maxComp}{A named list of named vectors. The name is the complex,
    C-i, for which the function is trying to find a maximal match. The
    named vector consists of the positions of the maximal matches
    (either which row or which column) and the names correspond to the
    conmplex of maximal matching.}

}

\author{Tony Chiang}

\examples{
go = getGOInfo(wantAllComplexes = FALSE)
mips = getMipsInfo(wantAllComplexes = FALSE)
goM = createGOMatrix(go)
mipsM = createMipsMatrix(mips)
cc = runCompareComplex(mipsM, goM, byWhich="ROW")
m = maximizeSimilarity(cc$JC, byWhich = "ROW")
m$maximize
m$maxComp
}
\keyword{datagen}
