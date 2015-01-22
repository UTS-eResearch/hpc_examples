
# This is required for a CUDA program.
# Do not "run" this script, and no need to make this script executable. 
# You need to "source" this from your qsub job submission script. 
# i.e. $ source "this_script.sh"

export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"


