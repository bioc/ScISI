\name{createScISIverified}
\alias{createScISIverified}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{A function (script) to create the verified in silico interactome for yeast}
\description{
  This function will create the working estimate in silico interactome
  for budding yeast. Presently, this function will use data parsed from
  GO and MIPS exclusively.
}
\usage{
createScISIverified(pathToSave = NULL)
}

\arguments{
  \item{pathToSave}{A character: details the path to where the ScISI
    should be stored.}
}
\details{
  This function will build a working estimate of ScISI with only
  verified protein complexes of GO and MIPS.

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
\author{ TC }

\examples{

}
\keyword{datagen}
