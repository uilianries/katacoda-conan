#!/bin/bash

apt-get update
apt-get -y install cmake
pip install conan
conan config set log.trace_file=/tmp/conan_trace.log

echo "done" >> /katacoda-background-finished