We are going to install the required dependencies and generate the information for the build system.

To do that, we need creating a build folder first, avoiding any CMake cache in our current folder.
Besides, we need to install Poco using Conan command `conan install ..`

Conan will install our Poco dependency but also the transitive dependencies for it:
OpenSSL and zlib. It has also generated a conanbuildinfo.cmake file for our build system.

#### Instructions

1. Create a new folder named `build`
2. Move to the new folder `build`
3. Install Poco package using Conan install command
