#!/bin/bash

[ -d /root/poco_md5/build ] && [ -f /root/poco_md5/build/conanbuildinfo.cmake ] && conan search Poco/1.9.0@pocoproject/stable | grep Package_ID && echo "done"