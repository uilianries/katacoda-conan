When working with a  single configuration, your conanfile will be quite simple as shown in the examples and tutorials we have used so far in this user guide.

For example, in "Getting started", we showed how you can run the `conan install ..` command inside the *build* folder resulting in the *conaninfo.txt* and *conanbuildinfo.cmake* files being generated there too. Note that the build folder is temporary, so you should exclude it from version control to exclude these temporary files.

**Out-of-source builds** are also supported. Let's look at a simple example:

`conan install poco_md5 --install-folder=poco_build`{{execute}}

This will result in the following layout:

```
poco_build
    conaninfo.txt
    conanbuildinfo.txt
    conanbuildinfo.cmake
poco_md5
    CMakeLists.txt
    README.md
    conanfile.txt
    md5.cpp
```

We have created a separate build configuration of the project without affecting the original
source directory in any way. The benefit is that we can clear the build folder and build another.

#### Instructions

1. Enter in `poco_build/`
2. Run CMake to configure our project `cmake ../poco_md5`{{execute}}
3. Build the project `cmake --build .`{{execute}}
4. Run the example `bin/md5`{{execute}}
