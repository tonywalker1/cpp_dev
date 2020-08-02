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

echo "*** Building libfmt ***"

# create build envirnoment
SCRATCH_DIR=/tmp/build_scratch
rm -rf $SCRATCH_DIR
mkdir -p $SCRATCH_DIR
pushd $SCRATCH_DIR

# # download and unpack
curl \
    --output fmt.tar.gz \
    -L https://github.com/fmtlib/fmt/archive/7.0.1.tar.gz
tar --strip-components=1 -zxf fmt.tar.gz

# # build and install
mkdir build \
    && cd build \
    && cmake \
        -DBUILD_SHARED_LIBS=TRUE \
        -DCMAKE_BUILD_TYPE=Release \
        .. \
    && make -j \
    && make install

# # clean-up
popd
rm -rf $SCRATCH_DIR
