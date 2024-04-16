# Run all code for the project

# Get raw network data and clean it
source("./code/get_data.r")

# Make network plots
source("./code/make_plots.r")

# Make summary statistics table
source("./code/make_table.r")

# Run unit tests
library(testdat)
testthat::local_edition(3)
testthat::test_dir("tests")
