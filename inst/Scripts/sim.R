
 library("graph")
 library("RBGL")


 simFun = function(nnode=30, p=.1, nsim, nsamp=5, seed) {
  set.seed(seed)
  ans = NULL
  V = paste("V", 1:nnode, sep="")
  for(i in 1:nsim) {
    g1 = randomEGraph(V,  p)
    s1 = sample(V, nsamp)
    eL = edges(g1, s1) 
    outD = sum(sapply(eL, length))
    #if we find an edge to an element of s1 we find it twice
    numTwice = sum(sapply(eL, function(x) sum(s1 %in% x)))
    numE = outD - (numTwice/2)
    estE1 = outD*nnode/(2*nsamp)
    estE2 = (numE*nnode*(nnode-1))/(2*sum(nnode-(1:nsamp)))
    ans[[i]] = list(graph=g1, edges=s1, estE1 = estE1, estE2=estE2, 
       nT=numTwice)
  }
  return(ans)
 }

  ##this seems to come close to giving 1/2 connected 1/2 not 

  v1=simFun(nsim=1000, p= .125, seed=123)
  tE = sapply(v1, function(x) numEdges(x$graph))
  eE1 = sapply(v1, function(x) x$estE1)
  eE2 = sapply(v1, function(x) x$estE2)

  ##suggests eE2 is better
  sum(abs(tE-eE1))
  sum(abs(tE-eE2))

  connG = sapply(v1, function(x) isConnected$graph))

  ##now we want to use the sampled nodes to predict connectivity
  ## of the graph. 

  ##so there is an association
  sapply(split(tE, connG), mean)
   t.test(tE~connG)

  ##look at number of distinct edges
  ##more distinct edges suggests connected
  ##this is ok, but we have left out the nodes
  ## selected - so that needs a little fixing up
 
  numUE = sapply(v1, function(x) 
         length(unique(unlist(edges(x$graph, x$edges)))))

  sapply(split(numUE, connG), mean)

  ##so we do see a relationship
  t.test(numUE~connG)

  
  ##combine both by trying to see how to connect the
  ##whole graph, given the observed part

  buildSubG = function( inV ) {
      testE = edges(inV$graph, inV$edges)
      obsvdN = unique(c(unlist(testE), inV$edges))
      tE2 = lapply(testE, function(x) 
                list(edges=match(x, obsvdN)))
      eL = lapply(obsvdN, function(x) character(0))
      names(eL) = obsvdN
      eL[names(tE2)] = tE2
      new("graphNEL", nodes=obsvdN, edgeL=eL)
  }


  subGs = lapply(v1, buildSubG)

  ##compute number of edges needed to get a complete graph
  ##given what we already know
  ## one edge for each node in the large graph that we did
  ## not select (numNode - mN) + how ever many are needed
  ## to make the subgraph connected

  nNeeded = function( gL, sGL) {
    numNode = sapply(gL, function(x) numNodes(x$graph))
    cc1 = sapply(sGL, function(x) 
             length(connectedComp(x)))
    mN = sapply(sGL, numNodes)
    numNode - mN + (cc1-1)
  }


  nn2=nNeeded(v1, subGs)

  ##again a small p-value
  t.test(nn2~connG)

  ss1=split(connG, nn2)
  ss2 = sapply(ss1, table)
  ss3 = sapply(ss1, function(x) sum(x)/length(x))

##we need a simulator - to see how likely it is that a graph is connected
##
