#!/bin/bash

grep COMMAND /tmp/conan_trace.log && grep conan/OpenSSL/1.0.2s/stable /tmp/conan_trace.log  && echo "done"