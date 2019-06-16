Conan works and is being actively used on Windows, Linux (Ubuntu, Debian, RedHat, ArchLinux, Raspbian), OSX, FreeBSD, and SunOS, and, as it
is portable, it might work in any other platform that can run python. In the documentation, examples for a specific OS might be found, such
as `conan install . -s compiler="Visual Studio"`, which will be specific for Windows users. If on a different system, the reader should
adapt to their own platform and settings (for example `conan install . -s compiler=gcc`).

Also **Conan works with any build system**. In the documentation, CMake will be widely used, because
it is portable and well known. But Conan does not depend on CMake at all; it is not a requirement.
**Conan is totally orthogonal to the build system**. There are some utilities that improve the usage
of popular build systems such as CMake or Autotools, but they are just helpers. Furthermore, it is
not necessary that all the packages are built with the same build system. It is possible to depend
on packages created with other build system than the one you are using to build your project.
