#!/bin/bash
set -ex

# CentOS Linux release 7.1.1503 (Core)，docker有镜像，但yum的软件已经不全，使用了比较高版本的C7
yum install -y devtoolset-8-toolchain devtoolset-8-perftools
#scl enable devtoolset-10 bash

yum install -y deltarpm openssh-server openssh-clients 

# cmdline
yum install -y wget which xz lz4 chrpath valgrind which zlib libtool rpm-build gzip tar

# dev tools
yum install -y gcc gcc-c++ cmake3 gdb gperftools git make
#yum install -y cmake3 gdb gperftools git make llvm-toolset-7-clang

# dev lib
# centos7 mariadb-devel include libmysqlclient.so
yum install -y mysql-devel gperftools-devel libstdc++-devel snappy snappy-devel bzip2 bzip2-devel lz4 lz4-devel  mariadb-devel

# ut lib
yum install -y sqlite-devel sqlite devtoolset-10-libasan-devel gtest gtest-devel

# benchmark lib
yum install -y google-benchmark-devel google-benchmark libstdc++-docs libstdc++

# prometheus-c-sdk
yum install -y libmicrohttpd-devel

