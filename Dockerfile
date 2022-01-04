# syntax=docker/dockerfile:1
FROM ubuntu:18.04

# Install apt dependencies
RUN apt-get update && \
    apt-get install python3 -y && \
    rm -rf /var/lib/apt/lists/*

# Install bsc
RUN mkdir -p /opt/tools/
COPY ./bsc.tar.gz /opt/tools/
RUN (cd /opt/tools/; tar -xvf bsc.tar.gz; mv bsc-* bsc)
RUN echo 'export PATH=/opt/tools/bsc/bin:$PATH' >> /root/.bashrc 

# Install BSVTools 

COPY BSVTools /root/.local
RUN echo 'export PATH=/root/.local/:$PATH' >> /root/.bashrc

CMD /bin/bash
