\name{list2Matrix}
\alias{list2Matrix}

\title{A function to that maps a list representation of a	
	 hypergraph (equivalently a bipartite graph) graph 
	 to its corresponding sparse-matrix representation.}
\usage{
list2Matrix(hgList)
}
\description{
This function takes a named list representation of a 
hyper-graph (bipartite graph) and generates the 
sparse-matrix representation. Each entry of the list
is a character vector corresponding to a hyper-edge.
The character vector represents the vertices of 
hyper-graph.

There are a few caveats:

1. The names of the list must be unique.
2. Each hyper-edge must also be unique.
}
\arguments{
  \item{hgList}{A named list consisting of character vectors. Each
  element of the list corresponds to a hyper-edge of the hyper-graph,
  and the names of the list determine each hyper-edge. The vectors
  contain the vertices of the hyper-graphs. NB - the names of the 
  hyper-edges must all be distinct.}	
}

\value{
A sparse-matrix representation of the hyper-graph. The rows of this matrix
are indexed by the union of the elements of the list (i.e. the vertices of
the graph). The columns are indexed by the hyper-edges. A value of 1 
in the (i,j) position states that vertex i belongs to hyper-edge j, and 
a value of 0 otherwise.
}
\author{Tony Chiang}

\examples{
hgList = getGOInfo(wantAllComplexes = FALSE)
list2Matrix(hgList)
}
\keyword{datagen}

