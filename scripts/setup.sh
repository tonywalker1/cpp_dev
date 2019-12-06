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

# build the docker image
ROOT_DIR=/cpp
set -ex

apt-get update

# run all installers from install.d
# NOTE: remove execute to stop script from running
for FILE in $(find install.d -name "*.sh" -perm /u+x | sort)
do
    $FILE
    if [ $? -ne 0 ]
    then
        echo "ERROR: One or more dependencies failed to build or install."
        echo "       See above for details."
        exit -1
    fi
done

# clean-up
rm -rf /var/lib/apt/lists/*
rm -rf $ROOT_DIR/install.d
rm -f  $ROOT_DIR/setup.sh
