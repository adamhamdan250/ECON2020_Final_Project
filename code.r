# Install all necessary libraries
library(R.matlab)
library(igraph)
library(knitr)
library(gt)

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
    graph_large <- induced.subgraph(graph1, which(components$membership == i))
  }
}

# PLOT 1: Original network
fig_network <- plot(graph,
     vertex.label=NA,
     vertex.size = 5,
     vertex.color = "#7777ff",
     edge.color = "#dadada",
     edge.width = 1,
     main = "Network 001"
)

# PLOT 2: Connected components
fig_network_connected <- plot(graph_connected, 
     vertex.label=NA,
     vertex.size = 5,
     vertex.color = "#7777ff",
     edge.color = "#dadada",
     edge.width = 1,
     main = "Network 001 - Connected Components"
)

# PLOT 3: Largest connected component
fig_network_largest <- plot(graph_large,
     vertex.label=NA,
     vertex.size = 5,
     vertex.color = "#7777ff",
     edge.color = "#dadada",
     edge.width = 1,
     main = "Network 001 - Largest Connected Component"
)

# SUMMARY STATISTICS

# Find number of nodes in orginal graph, and largest component
g_original_num_nodes <- vcount(graph)
g_num_nodes          <- vcount(graph_large)

# Find degree (# of connections) of each node (household)
g_degree     <- degree(graph_large)
g_degree_avg <- mean(g_degree)
g_degree_min <- min(g_degree)
g_degree_max <- max(g_degree)

# Find density of graph (# edges / # maximal possible edges)
g_density <- edge_density(graph_large)

# Find sizes of maximal cliques
g_max_clq          <- max_cliques(graph_large)
g_max_clq_sizes    <- sapply(g_max_clq, length)
g_max_clq_avg_size <- mean(g_max_clq_sizes)
g_max_clq_min_size <- min(g_max_clq_sizes)
g_max_clq_max_size <- max(g_max_clq_sizes)

# Summary Statistics Table
summary_table <- data.frame(
  Metric = c("Number of Nodes (Original Graph)", 
             "Number of Nodes (Largest Connected Component)",
             "Average Degree", "Minimum Degree", "Maximum Degree", 
             "Density", "Average Maximal Clique Size", 
             "Minimum Maximal Clique Size", 
             "Maximum Maximal Clique Size"),
  Value = c(g_original_num_nodes, g_num_nodes,
            g_degree_avg, g_degree_min, g_degree_max,
            g_density, g_max_clq_avg_size, 
            g_max_clq_min_size, g_max_clq_max_size)
)

# Round all values in the summary table to 1 decimal point
summary_table$Value <- round(summary_table$Value, 2)

# Create a gt table
summary_gt <- summary_table %>%
  gt() %>%
  tab_header(
    title = "Summary Statistics of Indonesian Hamlet Network",
    subtitle = "Data is sourced from Alatas et al. (2016), Network index is 001 \n
    NOTE: All values are computed for the largest connected component of the network."
  ) %>%
  fmt_number(
    columns = vars(Value),
    decimals = 1
)

# Export the table to a PDF file
gtsave(summary_gt, file = "output/summary_statistics.pdf")

# PLOT 4: Most connected node

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
     main = "Network 001 - Most Connected Node"
)