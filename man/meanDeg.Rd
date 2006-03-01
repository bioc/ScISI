\name{meanDeg}
\alias{meanDeg}
\title{A function to estimate the population mean nodal degree of a
  protein complex of interest}
\description{
  This function uses the nodal degree from Y2H data and estimates the
  overall mean nodal degree for all proteins of a particular complex
}
\usage{
meanDeg(comp, degBait, sampled)
}

\arguments{
  \item{comp}{A character vector of the constituent members of some
    protein complex of interest}
  \item{degBait}{A named list; each name is a constituent member and the
    entry is the out deg}
  \item{sampled}{A character vector of those constituent members tested
    as baits in the Y2H experiments}
}
\details{

}
\value{
  A scalar - the estimate of the population mean nodal degree
}
\author{TC}
\examples{
}
\keyword{datagen}
