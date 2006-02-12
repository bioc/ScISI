
 library("graph")
 library("RBGL")


 simFun = function( nnode=30, p=.1, nsim, nsamp=5, seed) {
  set.seed(seed)
  ans = NULL
  V = paste("V", 1:nnode, sep="")
  for(i in 1:nsim) {
    g1 = randomEGraph(V,  p)
    s1 = sample(V, nsamp)
    eL = edges(g1, s1) 
    outD = sum(sapply(eL, length))
    estE = outD*nnode/(2*nsamp)
    ans[[i]] = list(graph=g1, edges=s1, estE = estE)
  }
  return(ans)
 }

  ##this seems to come close to giving 1/2 connected 1/2 not 

  v1=simFun(nsim=100, p= .125, seed=123)
  tE = sapply(v1, function(x) numEdges(x$graph))
  eE = sapply(v1, function(x) x$estE)

  connG = sapply(v1, function(x) isConnected(x$graph))

  ##now we want to use the sampled nodes to predict connectivity
  ## of the graph. 

  ##so there is an association
  sapply(split(tE, connG), mean)
   t.test(tE~connG)

  ##look at number of distinct edges

  numUE = sapply(v1, function(x) 
         length(unique(unlist(edges(x$graph, x$edges)))))

  sapply(split(numUE, connG), mean)

  t.test(numUE~connG)

