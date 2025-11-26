README
------

    $ cd jobs
    $ cp -r /shared/eresearch/pbs_job_examples/gpu_using_python/ .

    $ cd gpu_using_python

Login to a node that has a GPU.

    gpu_node$ source source_me.sh 

You can now run nvitop if you have installed it.

    (pytorch) hpcnode11 gpu_using_python/$

Otherwise run nvidia-smi

