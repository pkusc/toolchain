#!/usr/bin/bash

export UCX_VERSION=1.15.0

wget https://github.com/openucx/ucx/releases/download/v$UCX_VERSION/ucx-$UCX_VERSION.tar.gz
tar xf ucx-$UCX_VERSION.tar.gz
cd ucx-$UCX_VERSION

echo "Requirements: cuda, knem, gdrcopy, mlnx_ofed"

./contrib/configure-release-mt --prefix=/opt/toolchain/ucx-$UCX_VERSION \
    --disable-logging --disable-debug --disable-assertions --disable-params-check \
    --without-go --disable-doxygen-doc --enable-numa --disable-assertions --enable-compiler-opt=3 \
    --without-java --enable-shared --enable-static --disable-logging --enable-mt --with-openmp \
    --enable-optimizations --disable-params-check --disable-gtest --with-pic \
    --with-cuda=/usr/local/cuda/ --enable-cma --with-dc --with-dm \
    --with-gdrcopy --with-ib-hw-tm --with-knem=/opt/toolchain/knem \
    --with-mlx5-dv --with-rc --with-ud --without-xpmem \
    --without-fuse3 --without-bfd --with-avx --without-rocm

make -j $(nproc) && make check -j $(nproc)
make install
