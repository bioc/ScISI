\name{getAPMSData}
\alias{getAPMSData}

\title{A function to get the estimated complexes from high
  throughput data determined by the package apComplex.}
\description{
  This function will generate the bipartite graph (BG) incidence matrix
  from either the experiments of Gavin, Ho, or Krogan.
}
\usage{
getAPMSData(author = NULL)
}

\arguments{
  \item{author}{A character - name of the lead experimentor. It can be
    either "Gavin", "Ho", or "Krogan"}
}
\details{
  This function is called to gain access to the protein complex
  co-membership bipartite graph matrices stored in the
  apComplex package.

  The matrix that is returned will be an incidence matrix with yeast
  standard gene name indexing the rows and ad hoc protein complex names
  indexing the columns.

  The matrix that is obtained from apComplex database will be the
  multi-bait, multi-edge (MBME) estimate from each of the experiment. We
  have elected to take the MBME estimates rather than the cumulative
  estimates because the MBME's are generated from more statistically 
  significant data sets.
}
\value{
  BG Incidence Matrix with rows indexed by proteins and columns by complexes
}
\author{Tony Chiang}


\examples{
getAPMSData("Gavin")
}
\keyword{datagen}
\keyword{array}
