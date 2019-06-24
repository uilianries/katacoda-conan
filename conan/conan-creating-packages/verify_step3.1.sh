#!/bin/bash

conan search Hello/0.1@foobar/testing | grep Package_ID && echo "done"