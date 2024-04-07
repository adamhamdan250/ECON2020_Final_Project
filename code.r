# Install all necessary libraries
library(R.matlab)
library(igraph)
library(patchwork)
library(ggplot2)
library(gridExtra)
library(igraph)

# Load network data from .mat file
network <- readMat("network001.mat")

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

# Remove isolated edges
graph_connected <- delete_vertices(graph, which(degree(graph) == 0))

# Find all the connected components of the network
components <- components(graph)

# Extract the largest connected component
largest_component <- graph
max_size <- 0
for (i in 1:length(components$csize)) {
  if (components$csize[i] > max_size) {
    max_size <- components$csize[i]
    largest_component <- induced.subgraph(graph1, which(components$membership == i))
  }
}

# PLOT 1: Original network
fig_network <- plot(graph,
     vertex.label=NA,
     vertex.size = 5,                  # Set the size of vertices
     vertex.color = "#d15ba5",       # Set the color of vertices
     edge.color = "#a4a4a4",         # Set the color of edges
     edge.width = 1,
     main = "Network 001")

# PLOT 2: All connected components
fig_network_connected <- plot(graph_connected, 
     vertex.label=NA,
     vertex.size = 5,                  # Set the size of vertices
     vertex.color = "#d15ba5",       # Set the color of vertices
     edge.color = "#a4a4a4",         # Set the color of edges
     edge.width = 1,
     main = "Network 001 - Connected Components")

# PLOT 3: Largest connected component
fig_network_largest <- plot(largest_component, 
     vertex.label=NA,
     vertex.size = 5,                  # Set the size of vertices
     vertex.color = "#d15ba5",       # Set the color of vertices
     edge.color = "#a4a4a4",         # Set the color of edges
     edge.width = 1,
     main = "Network 001 - Largest Connected Component")

