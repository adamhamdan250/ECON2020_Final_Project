# Install all necessary libraries
library(R.matlab)
library(igraph)
library(patchwork)

# Load the .mat file, corresponding to network data for Indonesian Village
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

# Plot the graph
fig_network <- plot(graph, 
     vertex.label=NA,
     vertex.size = 5,                  # Set the size of vertices
     vertex.color = "#d15ba5",       # Set the color of vertices
     edge.color = "#a4a4a4",         # Set the color of edges
     edge.width = 1)                   # Set the width of edges)


# Remove isolated edges
graph_connected <- delete_vertices(graph, which(degree(graph) == 0))

# Plot the graph
fig_network_connected <- plot(graph_connected, 
     vertex.label=NA,
     vertex.size = 5,                  # Set the size of vertices
     vertex.color = "#d15ba5",       # Set the color of vertices
     edge.color = "#a4a4a4",         # Set the color of edges
     edge.width = 1)                   # Set the width of edges)

# Find the connected components of the network
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

# Plot the largest connected component of the network
fig_largest_component <- plot(largest_component,
     vertex.label=NA,
     vertex.size = 5,                  # Set the size of vertices
     vertex.color = "#d15ba5",       # Set the color of vertices
     edge.color = "#a4a4a4",         # Set the color of edges
     edge.width = 1)                   # Set the width of edges)

# Combining plots with patchwork
network_plots <- fig_network / fig_network_connected / fig_largest_component
ggsave("network_plots.pdf", network_plots, path="output", width=11, height=8.5, units="in")

# Compute set 

