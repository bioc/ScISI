\name{getGOInfo}
\alias{getGOInfo}

\title{A function that parses through the GO database; it agreps for the
  term "complex" and greps suffixes "-ase" and "-some" and returns nodes
  whose description contains such terms.}
\description{
  This function parses through the Cellular Component ontology for the
  GO nodes and searchs for the term "complex" or the suffix "-ase"
  (e.g. RNA Polymerase) or "-some" (e.g. ribosome) and (or) other user
  defined phrases in the description of these nodes.}
\usage{
getGOInfo(wantDefault = TRUE, toGrep = NULL,
parseType=NULL, eCode = NULL, wantAllComplexes = TRUE)
}

\arguments{
  \item{wantDefault}{A logical. If TRUE, the default parameters ("complex",
    "\\Base\\b" and "\\Bsome\\b") are used.}
  \item{toGrep}{A character vector of the phrases (with Perl regular
    expressions) for which the function will parse through the GO
    database and search.}
  \item{parseType}{A character vector.This vector is in one to one
    correspondence with toGrep; it takes in the parse type such as
    "grep", "agrep", etc.}
  \item{eCode}{A character vector of evidence codes (see
    "http://www.geneontology.org/GO.evidence.shtml" for details). The
    function will disallow any protein inclusion in the protein
    complexes if they are not indexed by evidence code other than those
    found in eCode.}
  \item{wantAllComplexes}{A logical. If TRUE, the function will
    incorporate all GO children of the nodes found by term searches. In
    addition, children of node GO:0043234 (the protein complex node)
    will also be incorporated.}
}
\details{
  This function's generic operation is to parse the GO database and
  search for pre-determined or chosen terms. It returns a named list of
  chracter vectors where the names are GO id's from the CC ontoloy and
  the vectors consist of proteins corresponding to that particular GO
  id. Running this function has multiple combinations:

  1. If the wantDefault parameter is TRUE, the function will agrep for
  "complex" and grep for "\\Base\\b" and "\\Bsome\\b".

  2. If toGrep is not NULL, it will be a character vector with terms and
  perl regular expressions that are intended for searching in the GO
  database. NB - it toGrep is not NULL, then parseType should also not
  be NULL as the parseType indicates how each term should be searched.

  3. parseType needs to be supplied if toGrep is not NULL. It is a
  character vector, either a single entry or of length equal to the
  length of toGrep, detailing how each term in toGrep will be parsed in
  the GO database. If only one term is supplied for parseType, then all
  the terms in toGrep will be parsed identically. Otherwise, the i-th
  term in parseType will reflect the parsing of the i-th term in toGrep.

  4. The eCode argument is a user determined refining mechanism. It
  takes in a vector of evidence codes (as detailed by the GO
  website). The function will dis-allow proteins if and only if these
  proteins are only indexed by evidence codes found within eCodes.

  5. If wantAllComplexes parameter is True, the function will also
  return the children of nodes found by parsing terms. In addition, the
  children of GO ID GD:0043234 (the protein complex ID) will be
  returned. The union of complexes is then returned.
  
}
\value{
  The return value is a list of size n (n depends on the current status
  of the GO database) where the name of each list element is a GO ID and
  each list element itself is a character vector consisting of the
  proteins corresponding to a particular GO ID:
  
  \item{"GO:XXXXXXX"}{A character vector containing proteins (not indexed
  by only eCode evidence codes) which make up protein complex "GO:XXXXXXXX"}


}
\references{www.geneontology.org}
\author{Tony Chiang}
\examples{
go = getGOInfo(wantAllComplexes = FALSE)
goCoded = getGOInfo(code = c("IPI","ND","IDA"))
goPhrase = getGOInfo(wantDefault = FALSE, toGrep = "\\Bsomal\\b",
parseType = "grep", wantAllComplexes = FALSE)
nam1 = names(go)
nam2 = names(goCoded)
if(length(nam1) == length(nam2) && nam1 == nam2){
sapply(nam1, function(x) setdiff(go[[x]], goCoded[[x]]))
}

}
\keyword{datagen}
