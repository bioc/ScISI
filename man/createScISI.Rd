\name{createScISI}
\alias{createScISI}

\title{A function (script) to create the in silico interactome for yeast}
\description{
  This function will create the working estimate in silico interactome
  for budding yeast. Presently, this function will use data parsed from
  GO, Mips, and the high through-put experiments (Gavin, Ho, Krogan) via
  apComplex.  
}
\usage{
createScISI(pathToSave = NULL)
}

\arguments{
  \item{pathToSave}{A character: details the path to where the ScISI
    should be stored.}
}
\details{
  This function will build the working estimate for ScISI. Please note
  that the high through-put estimates located in MIPS will not be used
  but rather these estimates will be obtained from apComplex via
  bioconductor. In addition, certain protein complexes have been
  manually added or deleted (cf createScISI.Rnw).

  If pathToSave is not NULL, the estimtate will be saved to the
  specified directory as an .rda file. In addition, 5 data files will
  also be saved: these five files contain the summary statistics
  obtained during each iteration of the merging process to create the in
  silico interactome. 
}
\value{
  The bi-partite graph incidence matrix for budding yeast. The rows are
  indexed by the systematic gene names and the columns are indexed by
  the protein complexes (denoted by the data repository from where they
  were culled).
}
\references{http://www.geneontology.org}
\author{TC}
\examples{

}
\keyword{datagen}

