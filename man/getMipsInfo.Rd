\name{getMipsInfo}
\alias{getMipsInfo}

\title{A function that reads the downloaded text file from the MIPS
  repository and generates a named list of protein complexes.}
\description{
  This function reads the downloaded text file from the MIPS database
  and parses the file for those collection of proteins either referred
  to as a "complex", an "-ase" (e.g. RNA Polymerase), or a "-some"
  (e.g. ribosome)  and (or) user supplied terms as the protein complex of interest. It
  returns a list containing two items: a named list of protein complexes
  and a character vector (of the same length as the named list)
  describing each protein complex.
}
\usage{
getMipsInfo(wantDefault = TRUE, toGrep = NULL,
parseType = NULL, wantAllComplexes=TRUE)
}
\arguments{
  \item{wantDefault}{A logical. If true, the default parameters
    "complex", "\\Base\\b" and "\\Bsome\\b" are grepped.}
  \item{toGrep}{A character vector. Each entry is a term with perl
    regular expressions which are intended to be searched in the Mips
    text file.}
  \item{parseType}{A character vector. Each entry is a term that tells
    how each entry of toGrep should be parsed; e.g. "grep" or "agrep"}
  \item{wantAllComplexes}{A logical.If TRUE, the function only returns
    aggregate protein complexes. If FALSE, the function will also return
    subcomplexes as well.}
  }

\details{
  This function's generic operation is to parse the Mips protein complex
  database (as given by the downloaded text file) and search for
  pre-determined or chosen terms. It returns a named list of chracter
  vectors where the names are MIPS id's from the protein complex
  sub-category and the vectors consist of proteins corresponding to that
  particular MIPS id. Running this function has multiple combinations:

  1. If the wantDefault parameter is TRUE, the function will grep for
  "complex", "\\Base\\b", and "\\Bsome\\b".

  2. If toGrep is not NULL, it will be a character vector with terms and
  perl regular expressions that are intended for searching in the MIPS
  database. NB - it toGrep is not NULL, then parseType should also not
  be NULL as the parseType indicates how each term should be searched.

  3. parseType needs to be supplied if toGrep is not NULL. It is a
  character vector, either a single entry or of length equal to the
  length of toGrep, detailing how each term in toGrep will be parsed in
  the GO database. If only one term is supplied for parseType, then all
  the terms in toGrep will be parsed identically. Otherwise, the i-th
  term in parseType will reflect the parsing of the i-th term in toGrep.

  5. If wantAllComplexes parameter is True, the function will return the
  sub-groupings (sub-complexes or sub-structures) as given by the
  clusterings in the MIPS protein complex database. 
}
\value{
  The return value is a list - 

  \item{Mips}{A named list of the protein complexes. Each list entry
    is denoted by some particlar MIPS ID (with the pre-fix "MIPS-")
    attachedand points to a character vector which are the members of
    that protein complex}
  \item{DESC}{A named chracter vector describing each protein complex
    parsed by the function. (The names are the MIPS ID)}
  
}
\references{mips.gsf.ed}
\author{Tony Chiang}

\examples{
mips = getMipsInfo(wantAllComplexes = FALSE)
mipsPhrase = getMipsInfo(wantDefault = FALSE, toGrep = "\\Bsomal\\b",
parseType = "grep", wantAllComplexes=FALSE)

}
\keyword{datagen}
