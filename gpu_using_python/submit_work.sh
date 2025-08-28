#!/bin/bash

#PBS -N GPUTest
#PBS -l ngpus=1
#PBS -l mem=50GB
#PBS -l walltime=00:30:00 
#PBS -q gpuq
#PBS -l host=hpcnode15
#PBS -m abe 
#PBS -M mike.lake@uts.edu.au

# Change to the directory where this job was submitted from.
cd $PBS_O_WORKDIR

# Test PyTorch. This needs the cuda module loaded.
echo -e "\n------ Testing PyTorch ------"
echo -n "Running on host: " 
hostname

# We need to load the cuda module.
module load cuda-latest
source /shared/homes/mlake/miniconda3/etc/profile.d/conda.sh
conda activate pytorch
./work_gpu.py

module unload cuda-latest

