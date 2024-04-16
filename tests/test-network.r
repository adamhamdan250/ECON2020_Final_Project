test_that("Test # nodes in graph_large <= # nodes in graph", {
  expect_true(g_original_num_nodes >= g_num_nodes)
})

test_that("Test that all nodes in graph_connected have 1 or more connections", {
  g_degree_connected <- degree(graph_connected)
  g_degree_connected_min <- min(g_degree_connected)
  expect_true(g_degree_connected_min >= 1)
})
