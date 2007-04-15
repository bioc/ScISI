\name{ScISI}
\alias{ScISI}
\alias{ScISIverified}
\docType{data}
\title{The In Silico Interactome for Saccharomyces cerevisiae}
\description{
  This is the incidence matrix representatin for the bi-partite graph
  for the in silico interactome given by Saccharomyces cerevisiae. The
  rows are indexed by the systematic gene names and the colunmns are
  indexed by the protein complexes. This matrix contains a 1 in the
  (i,j) postion if the protein in indexed in the i-th row is a member of
  the protein complex of the j-th column; it contains a 0 otherwise.

  For the ScISIverified, the protein complex estimates from high
  throughput AP-MS experiments were not incorporated. Only protein 
  complexes obtained from GO and MIPS which are extensively studied
  and curated remain in the incidence matrix representation.
}
\usage{data(ScISI)}
\format{
  The format is:
 chr "ScISI"
}
\details{
  This is the working in silico interactome built for computational
  experimentation. The data from which this interactome is built is from
  the Gene Ontology, Mips, and estimated protein complexes from
  apComplex. 
}
\source{
  http://www.geneontology.org
  
}
\references{
  http://www/bioconductor.org
}
\examples{
data(ScISI)
}
\keyword{datasets}
