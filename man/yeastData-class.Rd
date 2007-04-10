\name{yeastData-class}
\docType{class}
\alias{yeastData-class}
\alias{yeastData}

\title{Class "yeastData"}

\description{
  A class representing an interactome of yeast. The object is in the
  form of a dataframe with three generic methods. The methods take two
  arguments: the first is the instance of the class yeastData; the
  second is the name of a protein complex with respect as given by the
  bi-partite graph incidence matrix.
  }

\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("yeastData",
  reference = dataFrameISI)}.
}
\section{Slots}{
  \describe{
    \item{yeastData:}{The yeastData slot is merely a data frame
      for some in silico interactome.}
   }
}

\section{Methods}{
  \describe{
    \item{ID}{\code{signature(object = "yeastData", name = "character")}: ... }
    \item{Desc}{\code{signature(object = "yeastData", name = "character")}: ... }
    \item{getURL}{\code{signature(object = "yeastData", name = "character")}: ... }
  }
}
\author{Tony Chiang}


\examples{
go = getGOInfo(wantAllComplexes = FALSE)
goM = createGOMatrix(go)
cNames = colnames(goM)
goDF = createGODataFrame(go, goM)
goOb = createYeastObj(goDF)
ID(goOb, cNames[5])
Desc(goOb, cNames[5])
getUrl(goOb, cNames[5])
}

\keyword{classes}
