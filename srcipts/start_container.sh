docker run --gpus all -itd --network=host \
    -v /home/lixiang/code:/root/code \
    nvcr.io/nvidia/cuda-dl-base:24.09-cuda12.6-devel-ubuntu22.04