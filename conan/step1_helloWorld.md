Before we're diving into Conan let's make ourselves familiar with the environment we're working in.

On the right side you see an editor window and a terminal. This is a normal Ubuntu-based system, you can freely navigate through the system and edit files. As you are root-user it's even possible for you to install additional software or reconfigure the system.

All links to files are clickable, so are the terminal commands below.

To get started we've set up a very simple application for you.
Within the directory `helloworld/source` is a very simple `hello.cpp` that gets built with a standard `CMakeLists.txt`. To open those files click onto the following links:
* `helloworld/source/hello.cpp`{{open}}
* `helloworld/source/CMakeLists.txt`{{open}}

We want to build the application within the `helloworld/build` directory by using CMake. Building the app is straight-forward:
* `mkdir -p ~/helloworld/build && cd ~/helloworld/build`{{execute}}
* `cmake ../source`{{execute}}
* `cmake --build .`{{execute}}
* `./hello`{{execute}}

As you can see there is no magic going on...
