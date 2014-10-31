FROM debian:wheezy

MAINTAINER Ozzy Johnson <ozzy.johnson@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ENV CUDA_RELEASE 6_5
ENV CUDA_VERSION 6.5.14
ENV CUDA_DRIVER 340.29
ENV CUDA_SERIAL 18749181
ENV CUDA_INSTALL http://developer.download.nvidia.com/compute/cuda/${CUDA_RELEASE}/rel/installers/cuda_${CUDA_VERSION}_linux_64.run

# Update and install minimal.
RUN \
  apt-get update \
            --quiet \
  && apt-get install \
            --yes \
            --no-install-recommends \
            --no-install-suggests \
       build-essential \
       module-init-tools \
       wget \ 

# Clean up packages.
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install CUDA.
RUN wget \
      $CUDA_INSTALL \
        -P /tmp \
        --no-verbose \
      && chmod +x /tmp/cuda_${CUDA_VERSION}_linux_64.run \
      && /tmp/cuda_${CUDA_VERSION}_linux_64.run \
        -extract=/tmp \
      && /tmp/NVIDIA-Linux-x86_64-${CUDA_DRIVER}.run \
        -s \
        -N \
        --no-kernel-module \
      && rm -rf /tmp/*

# Default command.
ENTRYPOINT ["/bin/bash"]
