#!/bin/bash

conan search Catch2/2.9.0@catchorg/stable | grep Package_ID && conan search fmt/5.3.0@bincrafters/stable | grep Package_ID && echo "done"