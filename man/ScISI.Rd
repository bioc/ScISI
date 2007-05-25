\name{ScISI}
\alias{ScISI}
\alias{ScISIC}
\alias{ScISIverified}
\docType{data}
\title{The In Silico Interactome for Saccharomyces cerevisiae}
\description{
  This is the incidence sparse-matrix representatin for the bi-partite graph
  for the in silico interactome given by Saccharomyces cerevisiae. The
  rows are indexed by the systematic gene names and the colunmns are
  indexed by the protein complexes. This matrix contains a 1 in the
  (i,j) postion if the protein in indexed in the i-th row is a member of
  the protein complex of the j-th column; it contains a 0 otherwise.

  ScISIC is a sub-interactome of ScISI which consists of protein complexes
  derived from small scale experiments and have been curated by Gene Ontology (GO)
  or MIPS. While these complexes have been curated, not all of them have
  been completely verified to be true. Periodic changes to GO and MIPS 
  will percolate through the protein complexes or protein complex composition
  and so the ScISIC will need to be rebuilt. A script located in the 
  inst/Scripts/ entitled createScISIC.R creates an updated ScISIC if the GO and
  MIPS's files are up to date. GO 1.15.13 and complexcat-data-20062005 (MIPS) were 
  used to build ScISIC for Bioconductor 2.0 release of the package ScISI. Both are 
  the most up to date versions of the repository as of 19 April 2007.

  In addition to the protein complexes found within MIPS and GO, ScISIC also
  contains manually curated protein complexes obtained from IntAct. Because IntAct
  has yet to version its release, the protein complexes were obtained on 25 May 2007. 

  ScISIC replaces ScISIverified which has been deprecated.

  ScISI combines ScISIC with protein complex estimates on the datasets
  derived by Gavin et al (2002), Ho et al (2002), and Krogan et al (2004)
  using the penalized algorithm found with apComplex
  developed by Scholtens et al (2004). 

  

}
\usage{data(ScISI)}
\format{
  The format is:
 chr "ScISI"
}
\details{
  This is the working in silico interactome built for computational
  experimentation. The data from which this interactome is built is from
  the Intact, Gene Ontology, Mips, and estimated protein complexes from
  apComplex. 
}
\source{
  http://www.geneontology.org
  
}
\references{
  http://www/bioconductor.org
}
\examples{
data(ScISIC)
}
\keyword{datasets}
