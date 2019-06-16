Enough theory, let's install Conan!

Conan provides different ways to get installed, but the recommended way is to use Python pip. This Ubuntu system already has Python3 and Pip preinstalled, so the following command will perform the install automatically:
* `yes | pip install conan`{{execute}}

Let's try it out:
* Which version did we install: `conan --version`{{execute}}
* Standard help: `conan`{{execute}}

Conan detects the build environment it runs in and creates a **profile**. Run the following command do create a profile called `default`:
* `conan profile new default --detect`{{execute}}.

You can list the available profiles by executing `conan profile list`{{execute}} and show the content of a profile by using `conan profile show default`{{execute}}. It is possible to define your own profiles and build for different environments without much hassle. So if you have a project running that for some reason needs a specific version of the Clang compiler you can just provide a profile and have it built correctly.

One specialty for the Ubuntu environment we're running in: As we're using GCC 5.4 we need to explicitly tell Conan to build with C++11:
* `conan profile update settings.compiler.libcxx=libstdc++11 default`{{execute}}

As you already learned Conan can have multiple package servers configured. The servers are called remotes. You can get a list of preconfigured remotes with `conan remote list`{{execute}}. Note that it gives your the [conan-center](https://bintray.com/conan/conan-center), a BinTray server that is used by the Conan project to provide packages for Open Source software for free.

Let's search for a package on `conan-center` and see what info we can get. Search for anything starting with `boost`:
* `conan search boost* --remote conan-center`{{execute}}
This gives us a list of Boost packages. Search for a particular reference to get some more info on it:
* `conan search boost/1.70.0@conan/stable --remote conan-center`{{execute}}.
Note that there are precompiled artifacts for a large number of different profiles and options.
