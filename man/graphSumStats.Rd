\name{graphSumStats}
\alias{graphSumStats}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{An initiation function to generate graph statistics}
\description{
  This function takes an in silico interactome and a list of Y2H
  experimental data (see details) and generates various graph summary
  statistics. 
}
\usage{
graphSumStats(ISI, bait2PreyL)
}

\arguments{
  \item{ISI}{An incidence matrix representation of a bi-partite graph of
  an in silico interactome}
  \item{bait2PreyL}{A list of y2h information. The data structure is
    that of intactInfo.rda of the y2hStat package}
}
\details{

}
\value{
  \item{complex}{A character vector of the constituent members of the
    proteinn complex of interest}
  \item{complexBait}{A character vector of those protein members which
    were also tested as baits in the y2h experiment}
  \item{notBait}{A character vector of those protein members which were
    not tested as baits}
  \item{avgDegOut}{The average out-degree of the bait proteins of the
    complex of interest}
  \item{notIsolated}{A character vector of proteins that showed
    experimental binary affiliation for some other complex member}
  \item{y2hGraph}{An instance of the class graph; a graphNEL induceds
    Y2H graph on the protein complex}
  \item{popMeanDegree}{The population mean degree derived from the
    bait proteins}
  \item{edgeProp}{The estimated edge proportions derived between
    undirected Y2H edges}
  \item{degBait}{A named list; each name corresponds to each member of
    the protein complex with the entry the number of proteins to which
    it is adjacent}
}

\author{T Chiang}

\examples{

}
\keyword{datagen}

