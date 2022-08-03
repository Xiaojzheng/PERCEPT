# PERCEPT: a new online change-point detection method using topological data analysis

This repository provides well-documented code that duplicates Figure 8b from the paper along with the output and the documentation. These files will be uploaded as “Supplementary Files” for the revision. 

Here, we consider the case of noise changes, where the pre- and post-change data are generated from the same unit 2-D ellipse, but with different noise levels. The detection statistics using PERCEPT, the Hotelling T, the MMD and the Wasserstein distance are computed and plotted. 

This folder includes three main files: opt_weights_tda.m, weights_paper.ipynb and simulation_paper.ipynb. 

1. opt_weights_tda.m solves the optimization problem (8) in the paper, and it is calling the other .m files in the repository.

2. weights_paper.ipynb finds the optimal weights and the optimal number of bins if using the persistence histogram approach. 

3. simulation_paper.ipynb computes the detection statistics using PERCEPT, the Hotelling T, the MMD and the Wasserstein distance and generates Figure 8b in the paper. 

## Here are some package installation guidelines for weights_paper.ipynb.

### Step 1: Install MATLAB Engine API for Python

The table (https://www.mathworks.com/content/dam/mathworks/mathworks-dot-com/support/sysreq/files/python-compatibility.pdf) gives the Python versions which are compatible with the MATLAB Engine for Python, so please make sure you have the compatible versions before installing MATLAB Engine API for Python. (Note that For MATLAB R2019b and earlier, Python Client Library for MATLAB Production Server is only compatible with Python
2.7.)

We highly recommend that you create a conda environment with the correct version of Python for what your version of MATLAB supports. 

You could follow the instructions listed here (https://www.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html), and we have listed the instructions briefly below: 

1. Find the Matlab root folder. You can use the matlabroot command within Matlab to find it.
2. Go to the Matlab root folder in the command line.
3. cd "matlabroot\extern\engines\python" (In Windows) or cd "matlabroot/extern/engines/python" (In Mac)
4. python setup.py install

For example, in Mac system, matlabroot usually is "/Applications/MATLAB_R2021a.app" (take MATLAB2021a as an example) and you should type the following in the command line: cd "/Applications/MATLAB_R2021a.app/extern/engines/python"

### Step 2: Install CVX and Mosek

You could follow the instructions listed here (http://cvxr.com/cvx/doc/mosek.html), and we have listed the instructions briefly below:

1. Download CVX (http://cvxr.com/cvx/download/) and MOSEK (https://docs.mosek.com/latest/toolbox/install-interface.html)
2. Apply a valid license for CVX (http://cvxr.com/cvx/academic/) and MOSEK (https://www.mosek.com/products/academic-licenses/). The preferred option is to place the license file mosek.lic in the directory mosek in the user’s home directory, and the license file cvx_license.dat to a convenient location. **Make sure to add the directories of both licenses into your Matlab path.** 
3. Run cvx_setup (you may need to add the cvx folder to your matlab path) so that the MOSEK and CVX licenses can be detected.
4. In the weights_paper.ipynb, in the command line eng.addpath(r'w64',nargout=0), you need to change the folder into your own "cvx/mosek/w64" (for Windows) or "cvx/mosek/maci64" (for Mac) folder. For example, in Mac system, it will usually be eng.addpath('/Users/yourusername/cvx/mosek/maci64',nargout=0).

We recommend the users to do the following checks after installations:
1. Run cvx_setup in Matlab, and make sure the license is valid, and the default solver is mosek.
2. Run mosekdiag in Matlab and check if mosekopt works OK.

See https://docs.mosek.com/latest/toolbox/install-interface.html for more troubleshooting.

### Step 3: Install all other required packages (gudhi and pot) for simulation_paper.ipynb

1. gudhi: The easiest way to install the Python version of GUDHI is using pre-built packages via the command line: conda install -c conda-forge gudhi (more details in https://gudhi.inria.fr/python/latest/installation.html#)
2. pot: using the command line: conda install -c conda-forge pot (more details in https://pypi.org/project/POT/)
