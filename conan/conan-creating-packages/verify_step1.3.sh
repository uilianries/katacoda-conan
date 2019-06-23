#!/bin/bash

conan search Hello/0.1@demo/testing | grep 'shared: True' && echo "done"