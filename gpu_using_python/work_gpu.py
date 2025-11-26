#!/usr/bin/env python3

# Test PyTorch on a GPU node with PBS.
# Written for HPC course in 2025
# Author: Mike Lake
# Date: 28 Aug 2025

'''
This can be run from either the command line on a GPU node
or submitted to PBS with: qsub submit_work.sh
See that script for the items that need to be set before running this python program.
e.g.
    hpcnode10 $ source /shared/homes/mlake/miniconda3/etc/profile.d/conda.sh
    hpcnode10 $ conda activate pytorch
    (pytorch) $

The output of this program will be in a file like GPU_Test.o54742 and will contain:

  hpcnode11
  CUDA Available =  True
  Torch CUDA Version = 12.0
  Device count =  2
  Device number= 0
  Device name =  Tesla V100S-PCIE-32GB
'''

import sys, os, torch, datetime, time, re

def query_cuda_device():
    print("CUDA Device Information")
    # This should return 'Tesla V100S-PCIE-32GB'
    print("  Device name = ", torch.cuda.get_device_name(0))

    # This should return "True".
    print("  CUDA Available = ", torch.cuda.is_available())

    # This should return '12.0'
    print("  Torch CUDA Version = ", torch.version.cuda)

    # This should return "2" unless only one one CUDA device is set to be visible.
    print("  Device count = ", torch.cuda.device_count())

    # This should return "0"
    print("  Device number =", torch.cuda.current_device())

    # This should return something like:
    # torch.cuda.device object at 0x15163441f820>
    #dev = torch.cuda.device(0)

def create_matrices():
    # Create two random square matrices of the specified size.
    # The L40 supports 48 GB of mem.
    # Any bigger than 70,000 and we will run out of memory.
    # 50,000 is prob the max.
    size = 40000
    print('Start time, creating matrices', datetime.datetime.now().strftime('%M:%S'))
    print('  Loading matrix A')
    a = torch.randn(size,size).to('cuda')
    print('  Loading matrix B')
    b = torch.randn(size,size).to('cuda')
    print('End time, creating matrices', datetime.datetime.now().strftime('%M:%S'))
    return (a, b)

def multiply_matrices(a, b, job_num):

    fh = open('output_%s.log' % job_num, 'w')
    date_time = datetime.datetime.now().strftime('%Y-%m-%d at %I:%M:%S %p')
    fh.write('Job %s\n' % job_num)
    fh.write('Started multipying at %s\n' % date_time)
    fh.flush()
    # For this many iterations multiply these two matrices repeatedly.
    # This is just an easy way to use up GPU time.
    for n in range(0,301):
        # Do one tensor matrix multiply.
        torch.matmul(a, b, out=None)
        # For every 100th iteration print this n to the log file.
        # By tailing this logfile we can see how far we are into this loop.
        # We don't use stdout as we don't get this output until the end.
        if n % 50 == 0:
            print('%d  ' % n)
            fh.write('%d ' % n)
            fh.flush()
            # This delay here is only for Mike to be able to demo
            # how this programs runs on a GPU.
            time.sleep(2)

    # Finish up.
    date_time = datetime.datetime.now().strftime('%Y-%m-%d at %I:%M:%S %p')
    fh.write('\nEnded multiplying at %s\n' % date_time)
    fh.flush()
    fh.write('\n')
    fh.close()

def main():
    # Set CUDA_VISIBLE_DEVICES
    # This can be used to specify what CUDA device is seen.
    os.environ["CUDA_VISIBLE_DEVICES"]="1"
    device = os.environ.get("CUDA_VISIBLE_DEVICES")

    # Extract from the PBS full job ID just the number part, e.g
    # from 1055720.hpcnode0 the job_num would be just 1055720
    job_id = os.getenv('PBS_JOBID') or '0.hpcnode0'
    job_num = re.match('[0-9]+', job_id)[0]

    # Create a log filename like: output_1055707.log
    # It's contents at the end will be like:
    #   2024-09-09 at 12:16:29 PM
    #   100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400
    print('Writing output to output_%s.log' % job_num)

    query_cuda_device()
    print('Creating matrices ...')
    a,b = create_matrices()
    print('Multipying matrices ...')
    multiply_matrices(a, b, job_num)

if __name__ == '__main__':
    main()

