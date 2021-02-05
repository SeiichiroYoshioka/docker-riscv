FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo 

RUN apt update \
    && apt upgrade -y \
    && apt install -y autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev \
    && apt install -y tzdata git \
    && git clone --recursive https://github.com/riscv/riscv-gnu-toolchain \
    && cd /riscv-gnu-toolchain \
    && ./configure --prefix=/opt/riscv --with-arch=rv32gc --with-abi=ilp32 \
    && make \
    && cd ../ \
    && rm -rf riscv-gnu-toolchain

ENV PATH=$PATH:/opt/riscv/bin/ 

ENTRYPOINT [ "/bin/bash" ]
