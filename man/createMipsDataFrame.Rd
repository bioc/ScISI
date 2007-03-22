\name{createMipsDataFrame}
\alias{createMipsDataFrame}
\title{A function that creates a data frame from the MIPS Data}
\description{
  This function takes two parameters: (1) a named vector that has a
  description of the MIPS protein complexes (this vector is one of the
  two outputs from \code{\link{getMipsInfo}} referenced by DESC);
  (2) the matrix representation of the bipartite graph. The output of
  the function is a dataframe with three columns: the names of the
  complexes in the matrix; the ID of the corresponding complex;
  the description of the corresponding complex.
}
\usage{
createMipsDataFrame(desc, mips)
}
\arguments{
  \item{desc}{A named character vector (where the name is the MIPS ID for
    each protein complex obtained by \code{\link{getMipsInfo}}) whose
    entries describe the corrsponding protein complex.}
  \item{mips}{The matrix representation of the protein complex
    membership graph for the MIPS protein complexes}
}

\value{
  The return value is a data frame with three coluumns: the names column
  records the names of the protein complexes as indexed in the incidence
  matrix; the ID column records the MIPS ID that corresponds to each
  protein complex; the Desc column describes each of the protein
  complexes. 
}
\references{mips.gsf.de}
\author{Tony Chiang}


\examples{
mips = getMipsInfo(wantSubComplexes=FALSE)
mipsM = createMipsMatrix(mips)
mipsDF = createMipsDF(mips$DESC, mipsM)
}
\keyword{datagen}

