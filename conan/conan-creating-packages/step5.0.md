The previous `create` approach using *test_package* subfolder, is not strictly necessary, though
**very strongly recommended**. If we didn't want to use the *test_package* functionality, we could
just write our recipe ourselves or use the `conan new` command without the `-t` command line argument.

`rm -rf src/ test_package/ && conan new Hello/0.1`{{execute}}

This will create just the `conanfile.py`{{open}} recipe file. Now we can create our package:

`conan create . demo/testing`{{execute}}

This is equivalent to:

`conan export . demo/testing`{{execute}}
`conan install Hello/0.1@demo/testing --build=Hello`{{execute}}

Once the package is created, it can be consumed like any other package, by adding
``Hello/0.1@demo/testing`` to a project *conanfile.txt* or *conanfile.py* requirements and running:

`conan install .`

#### Instructions

1. Create new *conanfile* using `conan new` with name/channel `katacoda/0.1.0`
2. Create a new Conan package using the reference `katacoda/0.1.0@demo/testing`
