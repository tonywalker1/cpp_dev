# cpp_dev
My basic C++ development container.

## Summary
I started programming C++ around 25 years ago. At that time, I developed
on one system and tested on another. Of course, it didn't take long for a system
to become a complete mess of old compilers, libraries, etc. As a result,
system rebuilds we frequent. In the early 2000s, I started using virtual
machines for development. This was a huge improvement. At some point, I (like
many others) started thinking about virtual machines as appliances that could
be saved, shared, etc. Then, along came LXC and Docker.

This code builds my basic development environment:
* Debian Stable
* GCC
* CMake
* Boost
* Google Test
* Google Benchmark
* libfmt (accepted for C++20)
* Howard Hinnant's date and time library (accepted for C++20)
* and more ...

## Contributing
While I really created this repo for my friends and I, I would love suggestions,
fixes, and other contributions. If you use this code to derive your own
containers, great! I would like to hear about it.

## Quick Start

```bash
# install Docker...

# clone and build
cd <your project dir>
git clone git@github.com:tonywalker1/cpp_dev.git
cd cpp_dev
./build_cpp_dev.sh

# use the container
cd <your project dir>
./run_cpp_dev.sh

# you will land in /cpp
ll
# you will see two directories: build and src
ll src
# you will see all of your projects
ll build
# will be empty at first

# create a build for an existing project
cd build
mkdir <my project>
cd <my project>
cmake ../src/<my project>
make
# your project should build...

# exit the container
exit

# restart the container
./run_cpp_dev.sh
ll build
# your stuff is still there; the build script creates a separate volume for all
# of your builds.

# Have fun!
```
