The `conan install` command downloads the binary package required for your configuration (detected the first time you ran the
command), __together with other (transitively required by Poco) libraries, like OpenSSL and Zlib__. It will also create the
*conanbuildinfo.cmake* file in the current directory, in which you can see the CMake variables, and a *conaninfo.txt* in which the settings,
requirements and optional information is saved.

Conan generates a __default profile__ with your detected settings (OS, compiler, architecture...) and that
configuration is printed at the top of every `conan install` command.
However, it is strongly recommended reviewing it and adjust the settings to accurately describe your system.

It is very important to understand the installation process. When the `conan install` command runs, settings specified on the
command line or taken from the defaults in *<userhome>/.conan/profiles/default* file are applied.

![conan-install-flow](https://docs.conan.io/en/latest/_images/install_flow.png)

For example, the command `conan install . --settings os="Linux" --settings compiler="gcc"`{{execute}}, performs these steps:

- Checks if the package recipe (for `Poco/1.9.0@pocoproject/stable` package) exists in the local cache. If we are just starting, the
  cache is empty.
- Looks for the package recipe in the defined remotes. Conan comes with `conan-center` Bintray remote as the default, but can be changed.
- If the recipe exists, the Conan client fetches and stores it in your local cache.
- With the package recipe and the input settings (Linux, GCC), Conan looks for the corresponding binary in the local cache.
- Then Conan searches the corresponding binary package in the remote and fetches it.
- Finally, it generates an appropriate file for the build system specified in the `[generators]` section.

There are binaries for several mainstream compilers and versions available in Conan Center repository in Bintray, such as Visual Studio 14,
15, Linux GCC 4.9 and Apple Clang 3.5... Conan will throw an error if the binary package required for specific settings doesn't exist. You
can build the binary package from sources using `conan install --build=missing`, it will succeed if your configuration is
supported by the recipe.

#### Instructions

Use your terminal to execute all tasks:

1. Install the package `Catch2/2.9.0@catchorg/stable` using Conan
1. Install the package `fmt/5.3.0@bincrafters/stable` using Conan
