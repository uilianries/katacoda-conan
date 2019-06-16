#!/bin/bash

[-d build ] && conan search Poco/1.9.0@pocoproject/stable | grep Package_ID && echo "done"