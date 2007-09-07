\name{compareComplex}
\alias{compareComplex}

\title{A function to compare two bipartite graph matrices}
\description{
  The \code{\link{compareComplex}} function takes two bipartite graph matrix
  representations and calculates three statistics between all pairs of
  complexes, C-i and K-j: (1) the intersection between C-i and K-j, (2) the
  proteins in C-i and not in K-j, (3) the proteins in K-j and not in
  C-i. These stats are later used to calculate Jaccard and Dice-Sorenson
  Coefficients as well as probability distributions of a protein p in a
  complex C. 
}
\usage{
compareComplex(BGMat1, BGMat2)
}

\arguments{
  \item{BGMat1}{The first bipartite graph matrix}
  \item{BGMat2}{The second bipartite graph matrix}
}
\details{
  The main point to remember is that we don't compare complexes within
  the same matrix. We only compare pairs of complexes from the BGMat1 and
  BGMat2. The \code{\link{runCompareComplex}} function must be
  called first since all the labelled vertices present in BGMat1
  must be present in the BGMat2 and vice versa so a true comparison can
  be made.
}
\value{
  A list with the following entries:
  
  \item{intersect}{A matrix of pairwise intersections of the complexes
    of BGMat1 and BGMat2}
  \item{cminusk}{A matrix of the setdiff of the complexes of BGMat1 and
    those of BGMat2}
  \item{kminusc}{A matric of the setdiff of the complexes of BGMat2 and
    those of BGMat1}

}

\author{Tony Chiang}


\examples{

}
\keyword{array}
\keyword{datagen}
