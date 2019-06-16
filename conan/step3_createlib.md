Consuming packages with your application is easy, but let's be honest: Most of what we're doing happens within libraries. So let's check out how Conan is helping us with that.

One major thing gets introduced now: Instead of a `conanfile.txt` we'll be working with a `conanfile.py`. This is the main way you'll be working with when using Conan, for libraries as well as for applications.

Using a `conanfile.py` unleashes the full power of Conan. This file contains not only the dependencies and their options, but also allows you to 
* ...acquire additional source files
* ...automate your build
* ...perform tests
* ...package everything up for others to reuse
* and that's just the tip of the iceberg here!

Let's have a look how our lib looks like:
* The header contains a simple class. The only method returns our previous _Hello World_: `hellolib/source/hello.h`{{open}}
* The implementation contains no surprises: `hellolib/source/hello.cpp`{{open}}
* Within our `CMakeLists.txt` there's nothing new. We create a library and use Conan to build: `hellolib/source/CMakeLists.txt`{{open}}
* And here's the big change: Within the `conanfile.py` we define how our lib is being built and packaged: `hellolib/source/conanfile.py`{{open}}
  * Note the attributes and how they define what our library looks like: Name, Description, Author, ...
  * There's a `build()` method that uses CMake to build the library
  * With `package()` we define where our libs are. This is necessary for consumers of our library.
* Ignore the layout file for now. It'll come in handy later on.

Building the lib is straight-forward. Note how we can use conan to build:
* `mkdir -p ~/hellolib/build && cd ~/hellolib/build`{{execute}}
* `conan install ../source`{{execute}}
* `conan build ../source`{{execute}}

Here's the kicker: With `conan create` we can package our lib and push it into our local Conan cache:
* `conan create ../source katacoda/testing`{{execute}}
Our library is now available for consumers by including the package `hellolib/1.0.0@katacoda/testing`.

As of now, the library is only available on our local machine. By creating an account on [conan-center](https://bintray.com/conan/conan-center) and using `conan upload ...` you could even upload that library to the official Conan server. This is not part of this tutorial though.