Now let's use our newly generated library.

Take a look onto helloworld3. It is similar to the previous versions, but now uses our lib:
* Here's our implementation: `helloworld3/source/hello3.cpp`{{open}}
* Out `conanfile.txt` now contains the lib as a dependency: `helloworld3/source/conanfile.txt`{{open}}
* And our `CMakeLists.txt` hasn't changed at all: `helloworld3/source/CMakeLists.txt`{{open}}

Conan handles the indirect dependencies like Poco for us. Our CMakeLists can also stay clean and tidy, all dependencies are nicely handled via Conan.

Let's build and test:
* `mkdir -p ~/helloworld3/build && cd ~/helloworld3/build`{{execute}}
* `conan install ../source`{{execute}}
* `cmake ../source`{{execute}}
* `cmake --build .`{{execute}}
* `./bin/hello3`{{execute}}

As you can see our own lib is consumed now.