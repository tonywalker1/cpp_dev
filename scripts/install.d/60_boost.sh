#!/bin/bash

# MIT License
#
# Copyright (c) 2019 Tony Walker
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# apt-get install -y --no-install-recommends \
#     libboost-all-dev

# create build envirnoment
SCRATCH_DIR=/tmp/build_scratch
rm -rf $SCRATCH_DIR
mkdir -p $SCRATCH_DIR
pushd $SCRATCH_DIR

# # install boost deps
apt-get update
apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    autotools-dev \
    curl \
    icu-devtools \
    libicu-dev \
    libbz2-dev \
    liblzma-dev \
    libopenmpi3 \
    libtool \
    m4 \
    mpi-default-dev \
    pkg-config \
    python3-dev \
    zlib1g-dev

# # download and unpack
curl \
    --output boost.tar.gz \
    -L https://dl.bintray.com/boostorg/release/1.71.0/source/boost_1_71_0.tar.gz
tar --strip-components=1 -zxf boost.tar.gz

# #build and install
./bootstrap.sh \
   --with-icu \
        --with-icu \
        --with-python=/usr/bin/python3
./b2
./b2 install

# # clean-up
popd
rm -rf $SCRATCH_DIR
