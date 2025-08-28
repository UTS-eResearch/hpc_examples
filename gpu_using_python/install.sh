#!/bin/bash

dest='/shared/eresearch/pbs_job_examples/gpu_using_python/'
mkdir -p $dest

# Copy the files.
cp clean.sh $dest
cp work_gpu.py $dest
cp submit_work.sh $dest
cp source_me.sh $dest

