Each package recipe can generate *N* binary packages from it, depending on these three items:
``settings``, ``options`` and ``requires``.

When any of the `settings_property` of a package recipe changes, it will reference a
different binary:

    class MyLibConanPackage(ConanFile):
        name = "MyLib"
        version = "1.0"
        settings = "os", "arch", "compiler", "build_type"

When this package is installed by a *conanfile.txt*, another package *conanfile.py*, or directly:

    $ conan install MyLib/1.0@user/channel -s arch=x86_64 -s ...

The process is:

1. Conan gets the user input settings and options. Those settings and options can come from the command line, profiles or from the values
   cached in the latest :command:`conan install` execution.
2. Conan retrieves the ``MyLib/1.0@user/channel`` recipe, reads the ``settings`` attribute, and assigns the necessary values.
3. With the current package values for ``settings`` (also ``options`` and ``requires``), it will compute a SHA1 hash that will serve as the binary
   package ID, e.g., ``c6d75a933080ca17eb7f076813e7fb21aaa740f2``.
4. Conan will try to find the ``c6d75...`` binary package. If it exists, it will be retrieved. If it cannot be found, it will fail and indicate that it
   can be built from sources using `conan install --build`.

If the package is installed again using different settings, for example, on a 32-bit architecture:

    $ conan install MyLib/1.0@user/channel -s arch=x86 -s ...

The process will be repeated with a different generated package ID, because the ``arch``
setting will have a different value. The same applies to different compilers, compiler versions, build types. When generating multiple
binaries - a separate ID is generated for each configuration.

When developers using the package use the same settings as one of those uploaded binaries, the computed package ID will be
identical causing the binary to be retrieved and reused without the need of rebuilding it from the sources.

The ``options`` behavior is very similar. The main difference is that ``options`` can be more easily defined at the package level and they can
be defaulted. Check the :ref:`conanfile_options` reference.

Note this simple scenario of a **header-only** library. The package does not need to be built, and it will not have any ABI issues at all.
The recipe for such a package will be to generate a single binary package, no more. This is easily achieved by not declaring
``settings`` nor ``options`` in the recipe as follows:

    class MyLibConanPackage(ConanFile):
        name = "MyLib"
        version = "1.0"
        # no settings defined!

No matter the settings are defined by the users, including the compiler or version, the package settings and options will always be the same
(left empty) and they will hash to the same binary package ID. That package will typically contain just the header files.

What happens if we have a library that we can be built with GCC 4.8 and will preserve the ABI compatibility with GCC 4.9?
(This kind of compatibility is easier to achieve for example for pure C libraries).

Although it could be argued that it is worth rebuilding with 4.9 too -to get fixes and performance improvements-. Let's suppose
that we don't want to create 2 different binaries, but just a single built with GCC 4.8 which also needs to be compatible for GCC 4.9 installations.
