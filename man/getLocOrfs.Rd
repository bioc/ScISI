\name{getLocOrfs}
\alias{getLocOrfs}

\title{A function to obtain ORFs for the ScISI}
\description{
  This function takes a list of bi-partite graph incidence matrices as
  well as a vector of GO nodes, and for each protein complex of each
  bi-partite graph, finds those constituent member proteins which are
  annotated to each GO node. 
}
\usage{
getLocOrfs(imList, goNode, pathToSave = NULL, name = NULL)
}
\arguments{
  \item{imList}{A list of bi-partite graph incidence matrices}
  \item{goNode}{A character vector of GO ID's}
  \item{pathToSave}{A character denoting where to save the resultant data}
  \item{name}{The name by which the resulting R-object as well as the file
    will be named}
}
\details{
  Currently, this function will take a protein complex and find those
  constituent protein members which have also been annotated to the user
  specified GO ID. For instance, the GO ID "" is the nucleus ID. This
  function will find all proteins within an interactome which has been
  annotated with the ID "". NB - if n GO ID is supplied, the
  function returns n different interactomes, each is has proteins
  uniquely annotated with each GO ID. 
}
\value{
  The return value is a list of lists of lists:

  1. The top level list contains entries named by each GO ID
  2. The second tier level contains entries after each entry of imList
  3. The third tier level contains three entries:
        i.   A bi-partite graph incidence matrix which only has protein
             complexes restricted to the respective GO ID annotation
        ii.  A bi-partite graph incidence matrix which only has protein
             complexes listed in (i) but contains all the original
             proteins
        iii. A vector of proportions. We look at the column sums of (i)
             divided by the column sums fo (ii). This gives the ratio of
             proteins which are annotated by the GO ID over all other
             proteins in that complex    
  
  \item{restrictedOrfsComp}{A bi-partite graph incidence matrix which
    only has protein complexes restricted to the respective GO ID
    annotation}
  \item{restrictedOrfsOnly}{A bi-partite graph incidence matrix which
    only has protein complexes listed in (i) but contains all the
    original proteins}
  \item{ratio}{A vector of proportions. We look at the column sums of
    (i) divided by the column sums fo (ii). This gives the ratio of
    proteins which are annotated by the GO ID over all other proteins in
    that complex} 
}
\references{ ~put references to the literature/web site here ~ }
\author{TC}

\examples{
}
\keyword{datagen}
