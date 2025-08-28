#!/bin/bash

# source this file, not run it.
# i.e. 
# source source_me.sh

# Load the latest CUDA module.
module load cuda-latest

if [ $? -eq 0 ]; then
    # We are on a GPU node.
    source /shared/homes/mlake/miniconda3/etc/profile.d/conda.sh
    conda activate pytorch
    echo "You can now run nvitop"
else
    echo "You are not on a GPU node. Exiting."
    hostname
fi

