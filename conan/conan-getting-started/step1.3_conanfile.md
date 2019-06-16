Ok, it looks like this dependency could work with our Encrypter app.
We should indicate which are the requirements and the generator for
our build system.

Let's understand the *conanfile.txt* inside our project's folder:

```
[requires]
Poco/1.9.0@pocoproject/stable

[generators]
cmake
```

In this example we are using CMake to build the project, which is why the `cmake` generator is specified.

This generator creates a *conanbuildinfo.cmake* file that defines CMake variables including paths
and library names that can be used in our build.
