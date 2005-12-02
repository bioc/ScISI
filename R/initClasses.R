setClass("yeastData", representation(reference="data.frame"))


setGeneric("ID", function(object, name) standardGeneric("ID"))


setMethod("ID", "yeastData",
          function(object, name){
              ind = which(object@reference[,"names"] == name)
              object@reference[ind,"id"]
          })

setGeneric("Desc", function(object, name) standardGeneric("Desc"))

setMethod("Desc", "yeastData",
          function(object, name){
              ind = which(object@reference[,"names"] == name)
              object@reference[ind,"description"]
          })

setGeneric("getURL", function(object, name) standardGeneric("getURL"))

setMethod("getURL", "yeastData",
          function(object, name){
              
              goInto = TRUE                           
              if (length(grep("MIPS", name)>0)){
                  goInto = FALSE
                  
                  ind = which(object@reference[,"names"] == name)
                  ref = object@reference[ind,"id"]
                  
                  if (length(ref) != 0){
                      outPut = paste("http://mips.gsf.de/genre/proj/yeast/searchCatalogListAction.do?style=cataloglist.xslt&table=CELLULAR_COMPLEXES&num=",ref,"&db=CYGD&order=", sep="")
                  }
                  else{
                      outPut = "There is no such complex"
                  }
              }
              if (length(grep("GO", name)>0)){
                  goInto = FALSE
                  
                  ind = which(object@reference[,"names"] == name)
                  ref = object@reference[ind,"id"]
                  if (length(ref) != 0){
                      outPut = paste("http://www.godatabase.org/cgi-bin/amigo/go.cgi?view=details&show_associations=list&search_constraint=terms&depth=0&query=",ref,"&session_id=44b1131058323", sep="")
                  }
                  else{
                      outPut = "There is no such complex"
                  }
               }

              if (goInto == TRUE){
                  outPut = print("No URL info available for this entry.")
              }

              print(outPut)
          }
          )

