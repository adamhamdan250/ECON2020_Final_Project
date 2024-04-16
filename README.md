# ECON2020_Final_Project

- Author: Adam Hamdan
- Date: April 16th 2024
- Project Title: ECON 2020 Final Project - Network Data

### Original Data Source

- Data used is form Alatas et al. "Network Structure and the Aggregation of Information: Theory and Evidence from Indonesia" **AER**, (2016)
- To get data from Replication File in Dataverse, grab network 001 adjacency data following these steps:
  - --> 119802-V1
  - --> Network Data.zip
  - --> Network Data
  - --> villageWithGroupsAndLeaders001network.mat

### Overview

- Folder /code contains all scripts:
  - "get_data.r" transforms raw network data into igraph objects and exports them to /data folder
  - "make_plots.r" generates four network plots, and exports them to /output folder
  - "make_table.r" creates a summary statistic table for the largest connected subnetwork of the original network

- Folder /data contains all clean network data (adjacency matrices):
  - "graph.graphml" original network data, in Graphml format
  - "graph_connected.graphml" subset of original network data, removing all nodes that are completely unconnected, in Graphml format
  - "graph_largest.graphml" subset of original network data, keeping the largest connected subnetwork, in Graphml format

- Folder /tests contains unit test scripts:
  - "test-network" tests two things:
    - Test that # of nodes in original network is greater or equal to # of nodes in largest connected subnetwork
    - Test that all nodes in graph_connected have at least one connection (one edge)

- Folder /output contains all plots and tables

