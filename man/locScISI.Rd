\name{locScISI}
\alias{locScISI}
\docType{data}
\title{A data file used to estimate the location of the complexes of the
ScISI}
\description{
  This is a three tier-ed list. The top list contains two sub-lists
  which have either the nucleus GO term or the cytoplasm GO terms as
  reference. For each sub-list, we have three entries: 1. A matrix
  indexed by only nuclear proteins in the rows and only non-trivial
  complexes with respect to the row indices; 2. A matrix with all
  proteins of the original ScISI indexing the rows, but the same
  complexes of (1) indexing the columns; 3. a numeric vector with the
  ratio of the column sums of (1) by the column sums of (2). This is
  used to derive nuclear protein complexes - those complexes with 75
  percent or more of its constituent members belonging to the nucleus. 
}
\usage{data(locScISI)}
\format{
  The format is:
 chr "locScISI"
}

\examples{
data(locScISI)

}
\keyword{datasets}
