#!/bin/bash

# We need to set a correct PATH and LD_LIBRARY_PATH for the compilation. 
# Note you must source the script, not run it. 
source ../set_cuda_env.sh

make clean
make

