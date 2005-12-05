\name{getURL-methods}
\docType{methods}
\alias{getURL-methods}
\alias{getURL}

\title{A method to return an url location of a protein complex}

\usage{
getURL(object, name)
}
\arguments{
  \item{object}{An instance of a subclass of \code{\link{yeastData}}.}
  \item{name}{A \code{character}. It is the name of the protein complex
    with respect to the bi-partite graph incidence matrix}
}

\description{
  The \code{getURL} method takes in the protein complex name of a bi-partite
  graph incidence matrix (usually an ad hoc name) and returns the MIPS,
  GO, etc url containing all information of that protein complex.

  The object to be referenced is an instance of the class
  yeastData.
  
}
\keyword{methods}

