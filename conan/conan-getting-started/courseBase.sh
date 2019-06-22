#!/bin/bash

apt-get update
apt-get -y install cmake
pip install conan
conan config set log.trace_file=/tmp/conan_trace.log
conan profile new default --detect
conan profile update settings.compiler.libcxx=libstdc++11 default
cd /root/poco_md5

echo "done" >> /katacoda-background-finished