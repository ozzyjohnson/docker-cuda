docker-cuda
===========

Minimal container with CUDA drivers as a base for GPU computing.

Installs only the driver without the enourmous toolkit. I use this as a base for Folding and BOINC images, but it could certainly be used elsewhere.

### Usage:

On a host with a CUDA device and drivers.

	docker run \
	  --device=/dev/nvidia0:/dev/nvidia0 \
	  --device=/dev/nvidiactl:/dev/nvidiactl \
	  --device=/dev/nvidia-uvm:/dev/nvidia-uvm \
	  -it \
	  --rm cuda

Or, as the base of another image.

	FROM ozzyjohnson/cuda

Validate that the container can see the GPU .

	nvidia-smi

Which produces.

	+------------------------------------------------------+                       
	| NVIDIA-SMI 340.46     Driver Version: 340.46         |                       
	|-------------------------------+----------------------+----------------------+
	| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
	| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
	|===============================+======================+======================|
	|   0  GRID K520           Off  | 0000:00:03.0     Off |                  N/A |
	| N/A   32C    P0     0W / 125W |     10MiB /  4095MiB |      0%      Default |
	+-------------------------------+----------------------+----------------------+
										       
	+-----------------------------------------------------------------------------+
	| Compute processes:                                               GPU Memory |
	|  GPU       PID  Process name                                     Usage      |
	|=============================================================================|
	|  No running compute processes found                                         |
	+-----------------------------------------------------------------------------+

A message like.

	Failed to initialize NVML: Unknown Error

Could be due to a mismatch between the host and container driver versions of missing host /dev entries.

### Next:

- An AMI or end to end to script to build and run this image.

### Thanks / Resources:

A few guides and posts that were invaluable in getting this working.

- [Mulitple answers on Stack Overflow](http://stackoverflow.com/questions/25185405/using-gpu-from-a-docker-container)
- [NVIDIA's Getting Started with CUDA on Linux](http://developer.download.nvidia.com/compute/cuda/6_5/rel/docs/CUDA_Getting_Started_Linux.pdf)
