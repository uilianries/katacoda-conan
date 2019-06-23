#!/bin/bash

grep -v 'def source' conanfile.py && grep 'scm' conanfile.py && conan search Hello/0.1@conan/stable | grep Package_ID && echo "done"