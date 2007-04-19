ScISIverified <- function(){
  if("ScISI" %in% loadedNamespaces())
    .Deprecated("ScISIC")
}
ScISIverified()
rm("ScISIverified")
load("ScISIverified.rda")
