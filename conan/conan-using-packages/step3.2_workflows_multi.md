You can also manage different configurations, whether in-source or out of source, and switch between
them without having to re-issue the `conan install` command (Note however, that even if you did have to run `conan install` again, since subsequent runs use the same parameters, they would be very fast since packages would already have been installed in the local cache rather than in the project)

`cd /root && conan install poco_md5 -s build_type=Debug -if poco_build/debug`{{execute}}
`cd /root && conan install poco_md5 -s build_type=Release -if poco_build/release`{{execute}}

`cd /root/poco_build/debug && cmake ../../poco_md5 && cmake --build . && bin/md5 && cd ../..`{{execute}}
`cd /root/poco_build/release && cmake ../../poco_md5 && cmake --build . && bin/md5 && cd ../..`{{execute}}

You can either use the ``--install-folder`` or ``-if`` flags to specify where to generate the output files, or manually create the output directory and navigate to it before executing the `conan install` command.

So the layout will be:

```
poco_build
    debug
        conaninfo.txt
        conanbuildinfo.txt
        conanbuildinfo.cmake
        CMakeCache.txt
    release
        conaninfo.txt
        conanbuildinfo.txt
        conanbuildinfo.cmake
        CMakeCache.txt
poco_md5
    CMakeLists.txt
    conanfile.txt
    timer.cpp
```

When running Visual Studio you can switch between your build configurations in exactly the same way you do for CMake or other build systems, by moving to the folder in which the build configuration is located, because the Conan configuration files for that build configuration will also be there.

`cd /root/poco_build/debug && cmake --build . --config Debug`
`cd /root/poco_build/release && cmake --build . --config Release`

Note that the CMake ``include()`` of your project must be prefixed with the current cmake binary
directory, otherwise it will not find the necessary file:

```
# CMakeLists.txt

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()
```

There are two generators, ``cmake_multi`` and ``visual_studio_multi`` that could help to avoid the
context switch and using Debug and Release configurations simultaneously. Read more about them in
`cmakemulti_generator` and `visual_studio_multi`
