rmByEvi <- function(protKept, complex){


  protDel = setdiff(complex, protKept)
  

  
  if(length(protDel) != 0){
  
      toDel = vector()
      for(i in 1:length(protDel)){
          
          del = which(complex == protDel[i])
          
          toDel = c(toDel, del)
  
      }

      if (length(toDel) != 0){
          complex = complex[-toDel]
          
      }
      
  }
  
  
  
  complex
}


  
