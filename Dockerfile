FROM debian:wheezy

MAINTAINER Ozzy Johnson <docker@ozzy.io>

ENV DEBIAN_FRONTEND noninteractive

ENV CUDA_DRIVER 340.58
ENV CUDA_INSTALL http://us.download.nvidia.com/XFree86/Linux-x86_64/${CUDA_DRIVER}/NVIDIA-Linux-x86_64-${CUDA_DRIVER}.run

# Update and install minimal.
RUN \
  apt-get update \
            --quiet \
  && apt-get install \
            --yes \
            --no-install-recommends \
            --no-install-suggests \
       build-essential=11.5 \
       module-init-tools=9-3 \
       wget=1.13.4-3+deb7u1 \ 

# Clean up packages.
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install CUDA.
RUN wget \
      $CUDA_INSTALL \
        -P /tmp \
        --no-verbose \
      && chmod +x /tmp/NVIDIA-Linux-x86_64-${CUDA_DRIVER}.run \
      && /tmp/NVIDIA-Linux-x86_64-${CUDA_DRIVER}.run \
        -s \
        -N \
        --no-kernel-module \
      && rm -rf /tmp/*

# Default command.
ENTRYPOINT ["/bin/bash"]
