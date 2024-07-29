FROM nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04

ENV TORCH_HOME=/root/.cache/torch

# Install Python and necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget build-essential python3.10 python3-pip python3.10-dev python3-setuptools
RUN apt install -y proxychains4 git curl telnet wget zip unzip
RUN pip install --upgrade pip setuptools wheel

# update pip and setuptools
RUN python3.10 -m pip install --upgrade pip setuptools wheel

RUN pip install "unsloth[colab-new] @ git+https://github.com/unslothai/unsloth.git"
RUN pip install --no-deps "xformers<0.0.27" "trl<0.9.0" peft accelerate bitsandbytes

RUN git clone --depth 1 https://github.com/hiyouga/LLaMA-Factory.git
RUN cd LLaMA-Factory && pip install git+https://github.com/EuDs63/ffmpy.git
RUN cd LLaMA-Factory && pip install -e ".[metrics,bitsandbytes]" 
RUN cd LLaMA-Factory &&  pip install --no-deps -e ".[metrics,bitsandbytes]" 
COPY proxychains.conf /etc/proxychains.conf
