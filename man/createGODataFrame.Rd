\name{createGODataFrame}
\alias{createGODataFrame}

\title{A function to create a Dataframe from the GO protein complexes}
\description{
  This function takes a named list (the names are the GO ID's
  representing some protein complex and the list elements are character
  vectors consisting of the members of each particular complex) and an
  Bipartite Graph Incidence Matrix and creates a dataframe with three
  columns: complex name, GO ID, and complex description.
}
\usage{
createGODataFrame(cMembers, goMat)
}
\arguments{
  \item{cMembers}{Named list with GO ID's as names and character vector
    consisting of proteins of the respective complex}
  \item{goMat}{Bipartite Graph Incidence Matrix}
}
\details{
  This function takes the output parameters of
  \code{\link{createGOMatrix}} and \code{\link{getGOInfo}} and creates
  the bipartite graph incidence matrix.
}
\value{
  Dataframe:
  \item{names}{The names of the GO Complexes}
  \item{ID}{The GO IDs' of the complexes}
  \item{description}{The description give by GO}
}
\references{www.geneontology.org }
\author{Tony Chiang}
\examples{
#go = getGOInfo(wantAllComplexes = FALSE)
#goM = createGOMatrix(go)
#createGODF(go, goM)
}
\keyword{datagen}

