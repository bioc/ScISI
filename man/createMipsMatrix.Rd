\name{createMipsMatrix}
\alias{createMipsMatrix}

\title{A function to create the bipartite graph incidence matrix from
  MIPS protein complexes}
\description{
  This function takes the output from the \code{\link{getMipsInfo}} function
  and creates the bipartite graph incidence matrix where the rows are
  indexed by proteins and colunms by protein complexes (given by the
  MIPS ID's).
}
\usage{
createMipsMatrix(mipsL)
}
\arguments{
  \item{mipsL}{A list consisting of the two items: mipsL$Mips is a
    named list of character vectors. The names correspond to MIPS
    protein complexes and the character vector correspond to the
    proteins within that complex; and mipsL$DESC is a named character
    vector where the names are the protein complex MIPS ID and the
    values is the description of the complex.}
}

\value{
  A bipartite graph incidence matrix of the MIPS protein complexes
  where rows are indexed by proteins names  and colunms by the MIPS ID's
  pre-fixed with "MIPS-".
}
\references{mips.gfs.de }
\author{Tony Chiang}

\examples{
mips= getMipsInfo(wantAllComplexes = FALSE)
mipsM = createMipsMatrix(mips)
}
\keyword{datagen}
\keyword{array}
