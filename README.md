# PERCEPT: a new online change-point detection method using topological data analysis

This repository provides well-documented code that duplicates Figure 8b from the paper along with the output and the documentation. These files will be uploaded as “Supplementary Files” for the revision. 

Here, we consider the case of noise changes, where the pre- and post-change data are generated from the same unit 2-D ellipse, but with different noise levels. The detection statistics using PERCEPT, the Hotelling T, the MMD and the Wasserstein distance are computed and plotted. 

This folder includes three main files: opt_weights_tda.m, weights_paper.ipynb and simulation_paper.ipynb. 

1. opt_weights_tda.m solves the optimization problem (8) in the paper, and it is calling the other .m files in the repository.

2. weights_paper.ipynb finds the optimal weights and the optimal number of bins if using the persistence histogram approach. 

3. simulation_paper.ipynb computes the detection statistics using PERCEPT, the Hotelling T, the MMD and the Wasserstein distance and generates Figure 8b in the paper. 


