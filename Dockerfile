FROM ubuntu:focal
ENTRYPOINT ["/bin/bash", "-l", "-c"]
WORKDIR /root

RUN sed -i -- 's/#deb-src/deb-src/g' /etc/apt/sources.list && sed -i -- 's/# deb-src/deb-src/g' /etc/apt/sources.list
RUN \
    export DEBIAN_FRONTEND="noninteractive" && \
    apt-get -y update && \
    apt-get -y install fakeroot build-essential kexec-tools \
    kernel-wedge gcc-arm-linux-gnueabihf libncurses5 libncurses5-dev libelf-dev asciidoc binutils-dev && \
    apt-get -y build-dep linux && \
    dpkg --add-architecture armhf
RUN \
    apt-get -y autoremove && \
    apt-get -y autoclean && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*
