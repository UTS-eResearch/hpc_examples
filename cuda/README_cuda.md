---
type: Infrastructure

traffic-light: green

target-close-date: 

actual-close-date: 

affected-group: eResearch

deliverables: 

---

How to Compile and Run an FFT Example using CUDA Code on a GPU
==============================================================

Author: Mike Lake
Version: 2015.01.22


Introduction
------------

This example shows how to compile and run a simple program that calculates 
a few FFTs (Fast Fourier Transforms) on one of the cluster nodes that 
have a GPU installed. 

The simple CUDA FFT example here comes from the Nvidia supplied example which
can be found here: /usr/local/cuda/samples/7_CUDALibraries/simpleCUFFT 
Other Nvidia examples can be found under /usr/local/cuda/samples/

I have modified some files in this example to remove code for architectures
that we do not have so have appended _UTS to the directory name.
Hence, you will find the code in this directory under simpleCUFFT_UTS/

Note: these examples can only be compiled on a GPU node.



Description of Files and Directories 
------------------------------------

README.txt          This file
gpu_access.sh       A script like this is required to gain access to a GPU node. 
                    Once on a GPU node you need to submit your program via qsub 
                    using a job submission script as normal. 
set_cuda_env.sh     This script must be "sourced" to setup CUDA environment.
                    You will need to run it before you try to compile or run 
                    most CUDA programs. 
simpleCUFFT_job.sh  A normal job submission script to submit your FFT program to qsub. 
simpleCUFFT_UTS/    Directory containing modified FFT example. 

How to use these files is described below. 

Other Files and Directories: 
"common" is just a copy of the /usr/local/cuda/samples/common/ directory.
But note: this directory is only found if you are logged into a GPU node!


1. Login to a GPU Node 
----------------------

On our cluster we have AMD nodes named hpcnode1 to hpcnode6. 
There are also Intel nodes named inode1 to inode4 - these have the 
Nvidia GPUs installed. 

Normally to run a job on the cluster you login to the head node "hpcnode1" 
and run "qsub myscript.sh" which will allocate your job most appropriate 
node for your requirements. You can't login to nodes other than the head node. 
But in the case of GPUs to even compile your CUDA job you need to be able to
login to a GPU node. You do this by submitting a interactive PBS job on the 
head node that logs you into a GPU node. From there you can submit a normal 
PBS job of your progam. When you logout of your interactive job your other 
job will continue. 

Example Session

First edit gpu_access.sh and set a walltime sufficient for you to do 
your task i.e. compiling, launching a qsub job or whatever. For instance 
if you set walltime=00:01:00 you will have 1 hour.

Now run a PBS interactive job to get onto a GPU node:

    hpcnode1 $ qsub -I gpu_access.sh                <-- starting on head node 
    qsub: waiting for job 109267.hpcnode1 to start
    qsub: job 109267.hpcnode1 ready
    inode1 $                                        <--- Note it now says inode1

You will now have a shell on inode1.


2. Compile and Build your CUDA Code
-----------------------------------

    $ source set_cuda_env.sh
    $ cd simpleCUFFT_UTS
    $ make clean
    $ make
    /usr/local/cuda-5.5/bin/nvcc -ccbin g++ -I/usr/local/cuda/samples/common/inc -m64 -gencode arch=compute_20,code=sm_20 -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35,code=\"sm_35,compute_35\" -o simpleCUFFT.o -c simpleCUFFT.cu
    /usr/local/cuda-5.5/bin/nvcc -ccbin g++ -m64 -o simpleCUFFT simpleCUFFT.o -lcufft
    inode2 simpleCUFFT_UTS/$ 
    $ 

This will have created an executable program "simpleCUFFT". Don't run this yet.
We have to run it via a normal job submission script. 


3. Submit your Job to qsub 
--------------------------

There is an example qsub submission script in this directory called
"simpleCUFFT_job.sh". Edit this to be suitable for yourself. 
Then submit your job.

    inode1 $ qsub simpleCUFFT_job.sh
    109275.hpcnode1                  <-- It will show your job normally.
    inode1 $                     

    $ qstat -fx 114674.hpcnode1

You can exit the GPU node. Just type exit.
You will drop back to the hpcnode1.

