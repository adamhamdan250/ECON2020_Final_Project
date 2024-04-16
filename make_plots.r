# Install all necessary libraries
library(igraph)
library(ggplot2)

# Import igraph objects from "/data" folder
graph <- read_graph("data/graph.graphml", format = "graphml")
graph_connected <- read_graph("data/graph_connected.graphml", format = "graphml")
graph_large <- read_graph("data/graph_large.graphml", format = "graphml")

# Open PDF device
pdf("output/original_network.pdf")

# PLOT 1: Original network
fig_network <- plot(graph,
     vertex.label=NA,
     vertex.size = 5,
     vertex.color = "#7777ff",
     edge.color = "#dadada",
     edge.width = 1,
     main = "Original Network Structure"
)

# Close PDF device
dev.off()

# PLOT 2: Connected components
fig_network_connected <- plot(graph_connected, 
     vertex.label=NA,
     vertex.size = 5,
     vertex.color = "#7777ff",
     edge.color = "#dadada",
     edge.width = 1,
     main = "All Connected Components"
)

# PLOT 3: Largest connected component
fig_network_largest <- plot(graph_large,
     vertex.label=NA,
     vertex.size = 5,
     vertex.color = "#7777ff",
     edge.color = "#dadada",
     edge.width = 1,
     main = "Largest Connected Component"
)

# PLOT 4: Most connected node

# Find degree (# of connections) of each node (household)
g_degree <- degree(graph_large)

# Find most connected node
g_most_connected <- which.max(g_degree)

# Find the neighbours of most connected node
g_most_connected_neighbours <- neighbors(graph_large, g_most_connected, mode = "all")

# Define colors for the most connected node and its neighbors
vertex_colors <- rep("#cccccc", vcount(graph_large))  # Default color for all vertices
vertex_colors[g_most_connected] <- "#2b2ba2"  # Color for the most connected node
vertex_colors[g_most_connected_neighbours] <- "#7777ff"  # Color for the neighbors

# Plot netork, highlighting most connected node and its neigbhbours
fig_network_most_connected <- plot(
     graph_large,
     vertex.label = NA,
     vertex.size = 5,
     vertex.color = vertex_colors,
     edge.color = "#dadada",
     edge.width = 1,
     main = "Most Connected Node"
)

# Export plots to "/output" folder
ggsave("output/original_network.pdf", plot = fig_network)
