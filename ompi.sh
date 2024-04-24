#!/usr/bin/bash

wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.6.tar.gz
tar xf openmpi-4.1.6.tar.gz
cd openmpi-4.1.6

echo "Requirements: ucx, knem, cuda"

./configure --prefix=/opt/toolchain/openmpi-intel \
            --enable-shared --disable-silent-rules --disable-sphinx --enable-static \
            --without-ofi --without-psm --without-verbs --without-mxm --with-cma \
            --with-ucx=/opt/toolchain/ucx --with-ucx-libdir=/opt/toolchain/ucx/lib \
            --with-knem=/opt/toolchain/knem --without-psm2 --without-fca --without-xpmem \
            --without-hcoll --without-cray-xpmem --without-tm --without-sge \
            --without-loadleveler --without-alps --without-slurm \
            --without-lsf --disable-memchecker --disable-java --disable-mpi-java \
            --with-gpfs=no --with-cuda=/usr/local/cuda \
            --disable-mpi-cxx --disable-cxx-exceptions \
            --enable-mpirun-prefix-by-default --enable-mca-no-build=btl-uct 

make -j 64 && make check -j 64
make install
