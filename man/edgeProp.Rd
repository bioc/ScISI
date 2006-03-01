\name{edgeProp}
\alias{edgeProp}

\title{A function to estimate the edge proportion of a y2h induced graph
  on a protein complex}
\description{
  This function first creates the Y2H symmetric adjacency matrix on a
  protein complex (as we ignore directionality). Then it calculates an
  estimate for the proportion of edges the complex might have with high
  probability (if the sampling is unbaised and without error). In
  addition to this statistic, it also generates an instance of graph,
  specifically a graphNEL, on the adjcency matrix.
}
\usage{
edgeProp(comp, compB2P, sampled)
}

\arguments{
  \item{comp}{A character vector of the constitutent members of the
    protein complex of interest}
  \item{compB2P}{A named list; the names correspond to constituent
    proteins used as baits and the entries are the found hits (prey)}
  \item{sampled}{A character vector of constituent members used as baits}
}
\details{
  
}
\value{

  \item{eProp}{The estimated edge proportion of the complex}
  \item{y2hGraph}{A graphNEL instance of graph}

}

\author{T Chiang}

\examples{

}
\keyword{datagen}

