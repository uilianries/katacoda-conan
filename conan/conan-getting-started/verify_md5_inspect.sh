#!/bin/bash

grep 'https://api.bintray.com/conan/conan/conan-center/v1/files/pocoproject/Poco/1.9.0/stable/0/export/conanfile.py' /tmp/conan_trace.log && echo "done"