# syntax=docker/dockerfile:1

# Build BSC
FROM ubuntu:18.04 as build
ADD bsc/.github/workflows/install_dependencies_ubuntu.sh /build/
RUN DEBIAN_FRONTEND=noninteractive \
    /build/install_dependencies_ubuntu.sh
ADD bsc /build/
RUN make -C /build -j2 GHCJOBS=2 GHCRTSFLAGS='+RTS -M5G -A128m -RTS' install-src

# Install BSC and python3
FROM ubuntu:18.04
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
       apt-get install -y \
          build-essential \
          iverilog \
          python3 \
          tcl \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build /build/inst /opt/bluespec/
ENV PATH /opt/bluespec/bin:$PATH

# Install BSVTools 
COPY BSVTools /root/.local
RUN echo 'export PATH=/root/.local/:$PATH' >> /root/.bashrc

CMD /bin/bash
