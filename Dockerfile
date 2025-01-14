ARG CUDA_VERSION=10.2
ARG CUDNN_VERSION=7
ARG IMGTYPE=runtime
ARG OS=ubuntu18.04
FROM nvidia/cuda:${CUDA_VERSION}-cudnn${CUDNN_VERSION}-${IMGTYPE}-${OS}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git gcc python3 python3-pip python3.7 libpython3.7-dev python-opencv zlib1g-dev libjpeg62-dev curl ca-certificates tree && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*
RUN cd $(dirname $(which python3.7)) && rm python3 && ln -s python3.7 python3

COPY requirements.txt /requirements.txt
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python3 && \
    pip --no-cache-dir install -r ./requirements.txt
# Use Agg backend for matplotlib
ENV DISPLAY 0
