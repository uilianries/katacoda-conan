We have already seen that there are some **settings** that can be specified during installation. For
example, `conan install . -s build_type=Debug`. These settings are typically a project-wide
configuration defined by the client machine, so they cannot have a default value in the recipe. For
example, it doesn't make sense for a package recipe to declare "Visual Studio" as a default compiler
because that is something defined by the end consumer, and unlikely to make sense if they are
working in Linux.

On the other hand, **options** are intended for package specific configuration that can be set to a
default value in the recipe. For example, one package can define that its default linkage is static,
and this is the linkage that should be used if consumers don't specify otherwise.

Also, You can see the available options for a package by inspecting the recipe with `conan get <reference>` command:

`conan get Poco/1.9.0@pocoproject/stable`{{execute}}

To see only specific fields of the recipe you can use the `conan inspect` command instead:

`conan inspect Poco/1.9.0@pocoproject/stable -a=options`{{execute}}
`conan inspect Poco/1.9.0@pocoproject/stable -a=default_options`{{execute}}

For example, we can modify the previous example to use dynamic linkage instead of the default one, which was static, by editing the *conanfile.txt*:

```
[requires]
Poco/1.9.0@pocoproject/stable

[generators]
cmake

[options]
Poco:shared=True # PACKAGE:OPTION=VALUE
OpenSSL:shared=True

```

Install the requirements and compile from the build folder (change the CMake generator if not in Windows):

```
$ conan install ..
$ cmake .. -G "Visual Studio 14 Win64"
$ cmake --build . --config Release
```

As an alternative to defining options in the ``conanfile.txt`` file, you can specify them directly in the command line:

`conan install poco_requires/ -o Poco:shared=True -o OpenSSL:shared=True`{{execute}}

Or even with wildcards, to apply to many packages

`conan install .. -o *:shared=True`{{execute}}

Conan will install the binaries of the shared library packages, and the example will link with them. You can again inspect the different binaries installed.

#### Instructions

1. Open `poco_requires/conanfile.txt`{{open}}
2. Add `[options]` section in *conanfile.txt*
3. Add the wildcard `*:shared=True` in options section
4. Using your *poco_requires/conanfile.txt*, install all packages
