#!/bin/bash

grep 'self.copy("*")' conanfile.py && conan search Hello/0.1@demo/bare | grep Package_ID && echo "done"