This could be an appropriate approach if we want the package recipe to live in the same repository
as the source code it is packaging.

First, let's get the initial source code and create the basic package recipe:

`conan new Hello/0.1 -t -s`{{execute}}

A *src* folder will be created with the same "hello" source code as in the previous example. You
can have a look at it and see that the code is straightforward.

Now let's have a look at `conanfile.py`{{open}}

There are two important changes:

- Added the ``exports_sources`` field, indicating to Conan to copy all the files from the local *src*
  folder into the package recipe.
- Removed the ``source()`` method, since it is no longer necessary to retrieve external sources.

Also, you can notice the two CMake lines:

```
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()
```

They are not added in the package recipe, as they can be directly added to the `src/CMakeLists.txt`{{open}}
file.

#### Instructions

1. Simply create the package for user and channel **foobar/testing** as described previously


#### Hints

- `conan create` can be used to create packages. You can run `conan create --help`{{execute}} to get more info about.
