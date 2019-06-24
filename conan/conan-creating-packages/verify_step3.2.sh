#!/bin/bash

grep revision conanfile.py && conan search Hello/0.1@scm/testing | grep Package_ID && echo "done"