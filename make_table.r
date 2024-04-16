# SUMMARY STATISTICS

# Install all necessary libraries
library(R.matlab)
library(igraph)
library(gt)
library(foreign)

# Import igraph objects from "/data" folder
graph <- read_graph("data/graph.graphml", format = "graphml")
graph_large <- read_graph("data/graph_large.graphml", format = "graphml")

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
    subtitle = md("Data is sourced from Alatas et al. (2016), Network index is 001. 
    \nAll values are computed for the largest connected component of the network.")
  ) %>%
  fmt_number(
    columns = vars(Value),
    decimals = 1
)

# Export the table to a PDF file
gtsave(summary_gt, file = "output/summary_statistics.pdf")
