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

- Folder /data contains all clean network data:
  - "

