#!/bin/bash

grep GOT_RECIPE_FROM_LOCAL_CACHE /tmp/conan_trace.log && grep fmt/5.3.0@bincrafters/stable /tmp/conan_trace.log  && echo "done"