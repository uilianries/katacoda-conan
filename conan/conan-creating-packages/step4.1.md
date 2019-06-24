Running the ``build()`` method, when the files you want to package are local, results in no added value as the files
copied from the user folder cannot be reproduced. For this scenario, run `conan export-pkg` command directly.

A Conan recipe is still required, but is very simple and will only include the package meta information. A basic recipe can be created with the `conan new` command:

`conan new Hello/0.1 --bare`{{execute}}

This will create a new `conanfile.py`{{open}}.

The provided ``package_info()`` method scans the package files to provide end-users with
the name of the libraries to link to. This method can be further customized to provide additional build
flags (typically dependent on the settings). The default ``package_info()`` applies as follows: it
defines headers in the "include" folder, libraries in the "lib" folder, and binaries in the "bin" folder. A different
package layout can be defined in the ``package_info()`` method.

This package recipe can be also extended to provide support for more configurations (for example,
adding options: shared/static, or using different settings), adding dependencies (``requires``),
and more.

Based on the above, We can assume that our current directory contains a *lib* folder with a number binaries for this
"hello" library *libhello.a*, compatible for example with Windows MinGW (gcc) version 4.9:

`conan export-pkg . Hello/0.1@myuser/testing  -s os=Windows -s compiler=gcc -s compiler.version=4.9`

Having a *test_package* folder is still highly recommended for testing the package locally before
upload. As we don't want to build the package from the sources, the flow would be:

```
$ conan new Hello/0.1 --bare --test
$ cd my/path/to/binaries
$ conan export-pkg PATH/TO/conanfile.py Hello/0.1@myuser/testing  -s os=Windows -s compiler=gcc -s compiler.version=4.9 ...
$ conan test PATH/TO/test_package/conanfile.py Hello/0.1@myuser/testing -s os=Windows -s compiler=gcc -s ...
```

The last two steps can be repeated for any number of configurations.

#### Instructions

1. Create a new conanfile using `--bare`
2. Create a new Conan package following the reference `Hello/0.1@demo/bare`