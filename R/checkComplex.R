checkComplex <- function(comps,interactome){
    dataL <- list("equal"  = NULL, "subset" = NULL, "superset" = NULL,
                  "noContainment" = NULL, "sameNameNotEqual" = NULL)

    
    print(!is.null(dataL$"equal"[[names(comps)[1]]]))
    for(i in 1:length(comps)){
        dataL$"equal"[[names(comps)[i]]] = NULL
        dataL$"subset"[[names(comps)[i]]] = NULL
        dataL$"superset"[[names(comps)[i]]] = NULL
        dataL$"sameNotEqual"[[names(comps)[i]]] = NULL
        
        if (names(comps)[i] %in% colnames(interactome)){
            same = setdiff(comps[[i]], names(which(interactome[,names(comps)[i]] == 1)))
            if (length(same) == 0){
                print(names(comps)[i])
                if(!is.null(dataL$"equal"[[names(comps)[i]]])){
                    dataL$"equal"[[names(comps)[i]]] <- c(dataL$"equal"[[names(comps)[i]]],
                                                          names(comps)[i])
                }
                else{
                    dataL$"equal"[[names(comps)[i]]] <- names(comps)[i]
                }
            }
            else {
                if(!is.null(dataL$"sameNameNotEqual"[[names(comps)[i]]])){
                    dataL$"sameNameNotEqual"[[names(comps)[i]]] <- c(dataL$"sameNameNotEqual"[[names(comps)[i]]],
                                                                     colnames(interactome)[j])
                }
                else{
                    dataL$"sameNameNotEqual"[[names(comps)[i]]] <- colnames(interactome)[j]
                }
            }
                
        }
        else {
            for (j in 1:ncol(interactome)){
                inCompNotI <- setdiff(comps[[i]], names(which(interactome[,j]==1)))
                inINotComp <- setdiff(names(which(interactome[,j]==1)), comps[[i]])

                if(length(inCompNotI) == 0 && length(inINotComp) == 0){
                    if(!is.null(dataL$"equal"[[names(comps)[i]]])){
                        dataL$"equal"[[names(comps)[i]]] <- c(dataL$"equal"[[names(comps)[i]]],
                                                              colnames(interactome)[j])
                    }
                    else{
                        dataL$"equal"[[names(comps)[i]]] <- colnames(interactome)[j]
                    }
                }

                if(length(inCompNotI) == 0 && length(inINotComp) != 0){
                    if(!is.null(dataL$"subset"[[names(comps)[i]]])){
                        dataL$"subset"[[names(comps)[i]]] <- c(dataL$"subset"[[names(comps)[i]]],
                                                               colnames(interactome)[j])
                    }
                    else{
                        dataL$"subset"[[names(comps)[i]]] <- colnames(interactome)[j]
                    }
                }

                if(length(inCompNotI) != 0 && length(inINotComp == 0)){
                    if(!is.null(dataL$"superset"[[names(comps)[i]]])){
                        dataL$"superset"[[names(comps)[i]]] <- c(cdataL$"superset"[[names(comps)[i]]],
                                                                 colnames(interactome)[j])
                    }

                    else{
                       dataL$"superset"[[names(comps)[i]]] <- colnames(interactome)[j] 
                    }
                }

                if(length(inCompNotI) != 0 && length(inINotComp) != 0){
                    
                }
            }
                
        }

    }

    dataL
}
