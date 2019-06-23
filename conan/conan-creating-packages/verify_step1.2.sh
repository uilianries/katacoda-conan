#!/bin/bash

conan search Hello/0.1@demo/testing | grep Package_ID && echo "done"