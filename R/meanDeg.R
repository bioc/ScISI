meanDeg <- function(comp, degBait, sampled){

        
    if (length(sampled) != 0){
        popMeanDeg <- (length(comp)*(sum(unlist(degBait))))/(2*length(sampled))
    }


    else{
        popMeanDeg <- NA
    }
    
}


