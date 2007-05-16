\name{createYeastDataObj}
\alias{createYeastDataObj}

\title{Creates an object of class yeastData}
\description{
  Creates an instance of the class yeastData.
}
\usage{
createYeastDataObj(dataFrameISI)
}
\arguments{
  \item{dataFrameISI}{A dataframe with three slots: complex name (from
    the incidence matrix), complex ID (from some database), complex description.}
}
\value{
  An object of class yeastData.
}
\author{Tony Chiang}

\examples{
 mips = createMipsMatrix(wantList=TRUE)
 mipsDF = createMipsDF(mips$DESC, mips$Matrix)
 mipsOb = createYeastDataObj(mipsDF)
}
\keyword{classes}
