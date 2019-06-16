#!/bin/bash

grep 'https://conan.bintray.com/v1/conans/search?q=Poco' /tmp/conan_trace.log && echo "done"