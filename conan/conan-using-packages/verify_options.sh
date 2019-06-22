#!/bin/bash

conan search Poco/1.9.0@pocoproject/stable | grep 'shared: False' && echo "done"