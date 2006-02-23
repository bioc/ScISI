\name{checkComplex}
\alias{checkComplex}

\title{Function to check a list of protein complexes wrt ScISI}
\description{
  This function takes a named list of protein complexes (where
  each protein complex name indexes an item of the list and each
  list entry is the protein composition of the complex) and
  an interactome (in the bi-partite matrix representation) and
  checks to see if each complex of the list is either in the
  interactome, a sub-complex of some complex(es) of the
  interactome, or a super-complex of some complex(es) of the
  interactome.
}
\usage{
checkComplex(comps, interactome)
}

\arguments{
  \item{comps}{A named list of protein complexes. The names
    corresponds the protein complexes and the entries correspond
    to the complex composition}
  \item{interactome}{A bi-partite graph representation of
    some interactome}
}
\details{
  This is another QC function to check the participation of
  certain protein complexes. The out-put will describe how
  the various protein complexes in question relate to the
  protein complexes of the interactome in question.
}
\value{
  A named list:
  \item{equal}{A named character vector - the name equals
    the entry}
  \item{subset}{A named char vector - the name is a subset
    of the entry}
  \item{superset}{A named char vector - the name is a superset
    of the entry}
  \item{sameNameNotEqual}{A named char vector - the name is
    equal to the name of the entry but the composition is not
    equal}
}

\author{T Chiang}

\examples{
##data(moreGO)
##data(ScISI)
##checkComplex(moreGO, ScISI)
}
\keyword{datagen}
