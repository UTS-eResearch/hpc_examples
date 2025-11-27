#!/bin/bash

# This just runs a simple CUDA job using PyTorch on a GPU node.
# It was written for the HPC course in 2025.
#
# PyTorch needs to have been installed by you into your own Miniconda3
# Python setup, which you will need to have setup previously.

#PBS -N GPUTest
#PBS -l ngpus=1
#PBS -l mem=10GB
#PBS -l walltime=00:15:00
#PBS -q gpuq
#PBS -m abe
#PBS -M Your.Email@uts.edu.au

# Normally you do not specify a node.
##PBS -l host=hpcnode15

# Change to the directory where this job was submitted from.
cd $PBS_O_WORKDIR

echo -e "\n------ Testing PyTorch ------"
echo -n "Running on host: " 
hostname

# PyTorch needs the cuda module loaded.
# Note that the cuda-latest module is only available on the GPU nodes.
# This module is not on the login node.
module load cuda-latest
if [ $? -ne 0 ]; then
    echo "Error: Could not load the latest cuda module."
    echo "You are probably not on a GPU node"
    echo "Exiting."
    exit 0
fi

# After you source your Miniconda3 environment AND load pytorch
# your default python3 will be this one: 
# ~/miniconda3/envs/pytorch/bin/python3
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate pytorch

# Now run your CUDA test program. 
./work_gpu.py

# Unload the cuda module and exit.
module unload cuda-latest

