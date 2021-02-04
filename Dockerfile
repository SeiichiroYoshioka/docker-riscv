FROM ubuntu:20.04

RUN apt update \
    && apt upgrade -y \
    && apt install -y autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev \
    && git clone --recursive https://github.com/riscv/riscv-gnu-toolchain \
    && cd /riscv-gnu-toolchain \
    && mkbir riscv \
    && ./configure --prefix=/opt/riscv --with-arch=rv32gc --with-abi=ilp32d\
    && make

ENV PATH=$PATH:/opt/riscv/bin/ \
    C_INCLUDE_PATH=/opt/riscv/riscv64-unknown-elf/include/ \
    LD_LIBRARY_PATH=/opt/riscv/riscv64-unknown-elf/lib/ \
    CC=/opt/riscv/bin/riscv64-unknown-elf-gcc \
    CXX=/opt/riscv/bin/riscv64-unknown-elf-g++ 

ENTRYPOINT [ "/bin/bash" ]