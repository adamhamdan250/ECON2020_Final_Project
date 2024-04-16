test_that("Test # nodes in graph_large <= # nodes in graph", {
  expect_true(g_original_num_nodes >= g_num_nodes)
})