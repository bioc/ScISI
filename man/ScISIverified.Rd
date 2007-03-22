\name{ScISIverified}
\alias{ScISIverified}
\alias{ScISIV21.03.07}
\docType{data}
\title{The In Silico Interactome for Saccharomyces cerevisiae}
\description{
  This is the incidence matrix representatin for the bi-partite graph
  for the in silico interactome given by Saccharomyces cerevisiae. The
  rows are indexed by the systematic gene names and the colunmns are
  indexed by the protein complexes. This matrix contains a 1 in the
  (i,j) postion if the protein in indexed in the i-th row is a member of
  the protein complex of the j-th column; it contains a 0 otherwise.

  The R data file ScISIV21.03.07 is an update to ScISIverified with the 
  updated GO and MIPS data on 21 March 2007. This will replace and 
  obsolete ScISIverified prior to the release in April 2007.
}
\usage{data(ScISIverified)}
\format{
  The format is:
 chr "ScISIverified"
}
\details{
 The only data sources are GO and Mips.
}
\source{
 http://www.geneontology.org
}
\examples{
data(ScISIverified)
}
\keyword{datasets}
