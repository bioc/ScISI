\name{ID}
\alias{ID}
\alias{ID,yeastData,character-method}


\title{A method to return the ID of a protein complex}

\usage{
ID(object, name)
}
\arguments{
  \item{object}{An instance of a subclass of \code{\link{yeastData}}.}
  \item{name}{A \code{character}. It is the name of the protein complex
    with respect to the bi-partite graph incidence matrix}
}

\description{
  The \code{ID} method takes in the protein complex name of a bi-partite
  graph incidence matrix (usually an ad hoc name) and returns its MIPS,
  GO, etc id. The object to be referenced is an instance of the class
  yeastData.
  
}
\keyword{classes}

