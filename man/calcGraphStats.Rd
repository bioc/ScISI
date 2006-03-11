\name{calcGraphStats}
\alias{calcGraphStats}

\title{A function to calculate the various summary statistics for Y2H
  induced graphs}
\description{
  This function takes a putative protein complex (given by comp) and a
  list of bait to prey associations, and from these two data-sets
  computes various summary statistics on the induced Y2H graph which
  include: edge proportion of sampled nodes (baits to prey); estimated
  population mean nodal degree; proportion of sampled baits with hits to
  baits with no hits; the average out degree of baits; the proteins
  (bait and prey) which are not isolated; the number of connected
  components to the y2h graph, etc. 
}
\usage{
calcGraphStats(comp, bait2PreyL)
}

\arguments{
  \item{comp}{The \code{comp} argument is a character vector containing
    the constituent proteins of some putative protein complex}
  \item{bait2PreyL}{A named list of lists. Each name represents a
    particular Y2H experiment; within each experimental entry, there is
    two more lists: 1. bpList and 2. expList. bpList is a named list of
    character vectors; each name corresponds to a bait protein of that
    particular experiment, and the enry is a chracater vecotor of the
    hit proteins found as prey. the expList is a named list concerning
    experimental data: ActD gives the activation domain; GW is a logical
    denoting if the prey list is genome wide; and numBaits details the
    number of baits used in the experiment.}
}
\details{
  For the bait2PreyL; use the the intactInfo.rda data-set of the package y2hStat.
}
\value{


  \item{complex}{A character vector of the constituent members of the
    proteinn complex of interest}
  \item{complexBait}{A character vector of those protein members which
    were also tested as baits in the y2h experiments}
  \item{b2CompP}{A character vector of all proteins which were tested as
    baits in the y2h experiments and also found a prey in the complex of
    interest}
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
\references{}
\author{T Chiang}

\examples{



}
\keyword{datagen}

