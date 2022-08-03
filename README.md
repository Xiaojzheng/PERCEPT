# PERCEPT: a new online change-point detection method using topological data analysis

This repository provides well-documented code that duplicates Figure 8b from the paper along with the output and the documentation. These files will be uploaded as “Supplementary Files” for the revision. 

Here, we consider the case of noise changes, where the pre- and post-change data are generated from the same unit 2-D ellipse, but with different noise levels. The detection statistics using PERCEPT, the Hotelling T, the MMD and the Wasserstein distance are computed and plotted. 

This folder includes three main files: opt_weights_tda.m, weights_paper.ipynb and simulation_paper.ipynb. 

1. opt_weights_tda.m solves the optimization problem (8) in the paper, and it is calling the other .m files in the repository.

2. weights_paper.ipynb finds the optimal weights and the optimal number of bins if using the persistence histogram approach. 

3. simulation_paper.ipynb computes the detection statistics using PERCEPT, the Hotelling T, the MMD and the Wasserstein distance and generates Figure 8b in the paper. 

## Here are some package installation guidelines for weights_paper.ipynb.

### Step 1: Install MATLAB Engine API for Python

The table (https://www.mathworks.com/content/dam/mathworks/mathworks-dot-com/support/sysreq/files/python-compatibility.pdf) gives the Python versions which are compatible with the MATLAB Engine for Python, so please make sure you have the compatible versions before installing MATLAB Engine API for Python. We highly recommend that you create a conda environment with the correct version of Python for what your version of MATLAB supports. 

You could follow the instructions listed here (https://www.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html), and we have listed the instructions briefly below: 

1. Find the Matlab root folder. You can use the matlabroot command within Matlab to find it.
2. Go to the Matlab root folder in the command line.
3. cd "matlabroot\extern\engines\python" (In Windows)
4. python setup.py install

### Step 2: Install CVX and Mosek

You could follow the instructions listed here (http://cvxr.com/cvx/doc/mosek.html), and we have listed the instructions briefly below:

1. Download CVX (http://cvxr.com/cvx/download/) and MOSEK (https://docs.mosek.com/latest/toolbox/install-interface.html)
2. Apply a valid license for CVX (http://cvxr.com/cvx/academic/) and MOSEK (https://www.mosek.com/products/academic-licenses/). The preferred option is to place the license file mosek.lic in the directory mosek in the user’s home directory, and the license file cvx_license.dat to a convenient location. Make sure to set up a path for both licenses. 
3. Run cvx_setup so that the MOSEK and CVX licenses can be detected.

