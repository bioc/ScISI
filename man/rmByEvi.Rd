\name{rmByEvi}
\alias{rmByEvi}

\title{A function that parses through each GO protein complex and
  removes proteins based on evidence codes.
}
\description{
  The set of proteins protKept argument is a filtered set of proteins
  based on evidence codes given by the users. If complex contains
  any protein not in protKept, that protein will be deleted.
}
\usage{
rmByEvi(protKept, complex)
}
\arguments{
  \item{protKept}{A character vector of filtered proteins. Only the
    proteins listed in this vector should be kept in the protein complexes}
  \item{complex}{A list of the GO protein complexes}
}
\details{
  When \code{\link{getGOInfo}} is called, the user can specify a set of
  evidence codes in the argument (see getGOInfo.Rd). The function
  \code{\link{getGOInfo}} then generates a set of proteins,
  protKept (which are indexed by evidence codes other than the
  user specified set of evidence codes), that are valid proteins.

  This function takes this set of proteins and compares it with each GO
  protein complex. If any protein is found within a GO protein complex
  and does not belong to protKept, it is deleted from that
  protein complex.

}
\value{
  The return value is the "complex" list with a protein removed from the
  protein complex if that protein is not found in protKept. 
}

\author{Tony Chiang}

\examples{

}
\keyword{datagen}