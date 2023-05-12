Mikes README for a Simple CUDA FFT
----------------------------------

Example of using CUFFT. In this example, CUFFT is used to compute the
1D-convolution of some signal with some filter by transforming both into
frequency domain, multiplying them together, and transforming the signal back
to time domain.

The files here came from: NVIDIA_CUDA-5.5_Samples/7_CUDALibraries/simpleCUFFT
and were modified by Mike Lake.

Compiling the Code
------------------

$ ./compile.sh

Running the Program
-------------------

Change back into the directory above and submit a PBS job as normal 
i.e. run "qsub simpleCUFFT_job.sh"

Details
-------

Here is the output of the make split up into parts

$ make

First it creates the object file simpleCUFFT.o 
/usr/local/cuda-5.5/bin/nvcc 
    -ccbin g++ 
    -I/home/mlake/src/cuda/NVIDIA_CUDA-5.5_Samples/common/inc 
    -m64 
    -gencode arch=compute_20,code=sm_20 
    -gencode arch=compute_30,code=sm_30 
    -gencode arch=compute_35,code=\"sm_35,compute_35\" 
    -o simpleCUFFT.o -c simpleCUFFT.cu

Then it links that with libs to create the executable. 
/usr/local/cuda-5.5/bin/nvcc -ccbin g++ -m64 -o simpleCUFFT simpleCUFFT.o -lcufft

Problems you may Encounter
--------------------------

Problem: Module nvidia not found

  ./simpleCUFFT is starting...
  FATAL: Module nvidia not found.
  CUDA error at ../common/inc/helper_cuda.h:898 code=38(cudaErrorNoDevice)
  "cudaGetDeviceCount(&device_count)" 

Solution: Use a different node and report the problem to the sys admins.

 
Problem: libcufft.so.5.5 cannot be found

  $ ./simpleCUFFT 
  ./simpleCUFFT: error while loading shared libraries: libcufft.so.5.5: cannot
  open shared object file: No such file or directory
  $

  You may have forgoten to load the PATH & LD_LIBRARY_PATH

Solution: Load env from ../set_cuda_env.sh
  $ source ../set_cuda_env.sh

  $ ./simpleCUFFT 
  simpleCUFFT is starting...
  GPU Device 0: "Tesla M2090" with compute capability 2.0

  Transforming signal cufftExecC2C
  Transforming signal back cufftExecC2C
  $ 


Problem: can't find nvcc

  hpcnode1 simpleCUFFT_UTS/$ make
  ... lots of make output then ...
  nvcc -ccbin g++ -I/usr/local/cuda/samples/common/inc ...etc... -o simpleCUFFT.o -c simpleCUFFT.cu
  make: /usr/local/cuda-5.5/bin/nvcc: Command not found
  make: *** [simpleCUFFT.o] Error 127
  $ 

Solution: 
  You are not on a GPU node. In the example above it showed the node as 
  'hpcnode1' and not 'hpcinode1', that little "i" means an Intel node and only 
  the Intel nodes have the GPUs installed. 


