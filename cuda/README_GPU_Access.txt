How to Access GPU Nodes and Run CUDA Code
=========================================

On our cluster we have AMD nodes named hpcnode1 to hpcnode6
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
---------------

First edit gpu_access.sh and set a walltime sufficient for you to do 
your task, compiling, launching a qsub job or whatever. For instance 
if you set walltime=00:01:00 you will have 1 hour.

Now run a PBS interactive job to get onto a GPU node:

hpcnode1 $ qsub -I gpu_access.sh                <-- starting on head node 
qsub: waiting for job 109267.hpcnode1 to start
qsub: job 109267.hpcnode1 ready
inode1 $                                        <--- Note it now says inode1

You will now have a shell on inode1.
Launch your real job normally.

inode1 $ qsub fft_job.sh 
109275.hpcnode1          <-- It will show your job normally.
inode1 $                     

You can exit the GPU node. Just type exit.
You will drop back to the hpcnode1.




