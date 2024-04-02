library(R.matlab)
library(igraph)

# Load the .mat files
network1 <- readMat("network001.mat")

# network2 <- readMat("network019.mat")
# network3 <- readMat("network075.mat")
# network4 <- readMat("network180.mat")
# network5 <- readMat("network215.mat")
# network6 <- readMat("network332.mat")
# network7 <- readMat("network372.mat")
# network8 <- readMat("network426.mat")
# network9 <- readMat("network513.mat")
# network10 <- readMat("network600.mat")

# Transform lists into matrices, to obtain adjacency matrices
network1
adjacency1 <- matrix(unlist(network1), ncol = 74, byrow=TRUE)
# Remove the first row
adjacency1 <- adjacency1[-1, ]
# Replace all NAN values with zero 
adjacency1[is.nan(adjacency1)] <- 0

# Create an igraph graph object from the adjacency matrix
graph1 <- graph.adjacency(adjacency1, mode = "undirected", weighted = NULL)

# Check adjacency matrix
graph1[]

# Plot the graph
plot(graph1, 
     vertex.label=NA,
     vertex.size = 5,                 # Set the size of vertices
     vertex.color = "#da6b8e",       # Set the color of vertices
     edge.color = "black",             # Set the color of edges
     edge.width = 1)                   # Set the width of edges

# 