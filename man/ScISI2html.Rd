\name{ScISI2html}
\alias{ScISI2html}

\title{A function that generates an html page for the GO and MIPs
  protein complexes}
\description{
  This function takes a vector or url's and a vector of the protein
  complex description names (known names of the protein complexes) and
  creates an html file that lets the user link to each of the protein
  complex description site based on the particular url.
}
\usage{
ScISI2html(urlVect, linkName, filename, title,
othernames, table.head, table.center = TRUE)
}
\arguments{
  \item{urlVect}{A character vector containing the url for each
    speficied protein complex}
  \item{linkName}{A character vector containing a description name for
    each of the url's in urlVect that will be the anchor for the url}
  \item{filename}{The output file; an html file written to the home directory}
  \item{title}{The title given to the html file}
  \item{othernames}{Other titles that are needed; sub-titles}
  \item{table.head}{The title for the table}
  \item{table.center}{Logical; to center the table}
}

\value{
  An html file written to the user's home directory. The file contains a
  page of links (given by the url's) where each link is anchored by a
  description name for each url.
}

\author{Tony Chiang}

\examples{
go = getGOInfo(wantAllComplexes = FALSE)
goM = createGOMatrix(go)
goDF = createGODataFrame(go, goM)
goOb = createYeastDataObj(goDF)
goNames = colnames(goM)
url = vector(length = length(goNames))
for(i in 1:length(goNames)){
url[i] = getURL(goOb, goNames[i])
}
ScISI2html(url, goNames, test, GO Complexes}
}
\keyword{datagen}
