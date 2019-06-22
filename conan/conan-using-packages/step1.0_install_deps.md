In *Getting started* we used the `conan install` command to download the
**Poco** library and build an example.

If you inspect the `conanbuildinfo.cmake` file that was created when running `conan install`,
you can see there that there are many CMake variables declared. For example
`CONAN_INCLUDE_DIRS_ZLIB`, that defines the include path to the zlib headers, and
`CONAN_INCLUDE_DIRS` that defines include paths for all dependencies headers.

![cmake-cache](https://docs.conan.io/en/latest/_images/local_cache_cmake.png)

If you check the full path that each of these variables defines, you will see that it points to a folder under your `<userhome>` folder.
Together, these folders are the **local cache**. This is where package recipes and binary
packages are stored and cached, so they don't have to be retrieved again. You can inspect the
**local cache** with `conan search`, and remove packages from it with `conan remove` command.

If you navigate to the folders referenced in ``conanbuildinfo.cmake`` you will find the
headers and libraries for each package.

If you execute a `conan install Poco/1.9.0@pocoproject/stable`{{execute}} command in your shell, Conan will
download the Poco package and its dependencies (*OpenSSL/1.0.2l@conan/stable* and
*zlib/1.2.11@conan/stable*) to your local cache and print information about the folder where
they are installed. While you can handle them manually, the recommended approach is to
use a ``conanfile.txt``.

#### Instructions

1. Install Conan package *Poco/1.9.0@pocoproject/stable*