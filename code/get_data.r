# Install all necessary libraries
library(R.matlab)
library(igraph)

# Load raw network data from .mat file
network <- readMat("villageWithGroupsAndLeaders001network.mat")

# Transform connection lists into connection matrix
adjacency <- matrix(unlist(network), ncol = 74, byrow=TRUE)

# Remove the first row, to make it a square adjacency matrix
adjacency <- adjacency[-1, ]

# Replace all NAN values with zeros
adjacency[is.nan(adjacency)] <- 0

# Create an igraph graph object from the adjacency matrix
graph <- graph.adjacency(adjacency, mode = "undirected", weighted = NULL)

# Check adjacency matrix
graph[]

# Remove isolated nodes (nodes with no links)
graph_connected <- delete_vertices(graph, which(degree(graph) == 0))

# Find all connected components of the network
components <- components(graph)

# Extract the largest connected component from the network
graph_large <- graph
max_size <- 0
for (i in 1:length(components$csize)) {
  if (components$csize[i] > max_size) {
    max_size <- components$csize[i]
    graph_large <- induced.subgraph(graph, which(components$membership == i))
  }
}

# Export cleaned graph objects to "/data" folder
write_graph(graph, file = "data/graph.graphml", format = "graphml")
write_graph(graph_connected, file = "data/graph_connected.graphml", format = "graphml")
write_graph(graph_large, file = "data/graph_large.graphml", format = "graphml")
