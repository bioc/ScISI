checkComplex <- function(comps,interactome){
    dataL <- list("equal"  = NULL, "subset" = NULL, "superset" = NULL,
                  "sameNameNotEqual" = NULL)
    
    
    for(i in 1:length(comps)){
        if (names(comps)[i] %in% colnames(interactome)){
            same = setdiff(comps[[i]], names(which(interactome[,names(comps)[i]] == 1)))
            if (length(same) == 0){
              dataL$"equal"[[names(comps)[i]]] <- names(comps)[i]
            }
          
            else {
              dataL$"sameNameNotEqual"[[names(comps)[i]]] <- colnames(interactome)[j]
            }
          }
      
                
    
        else {
            for (j in 1:ncol(interactome)){
              v = vector()
              w = vector()
              z = vector()
                inCompNotI <- setdiff(comps[[i]], names(which(interactome[,j]==1)))
                inINotComp <- setdiff(names(which(interactome[,j]==1)), comps[[i]])

              if(length(inCompNotI) == 0 && length(inINotComp) == 0){
                v = c(v, colnames(ScISI)[j])
              }
              if(length(v) > 0){
                dataL$"equal"[[names(comps)[i]]] = v
              }
              
              

              if(length(inCompNotI) == 0 && length(inINotComp) != 0){
                w = c(w,colnames(interactome)[j])
              }

              if(length(w) > 0){
                dataL$"subset"[[names(comps)[i]]] = w
              }

              if(length(inCompNotI) != 0 & length(inINotComp) == 0){
                z = c(z, colnames(interactome)[j])
              }

              if(length(z) > 0){
                dataL$"superset"[[names(comps)[i]]] = z
              }

            }
                
        }

    }

    dataL
}
