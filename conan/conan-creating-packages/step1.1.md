The **test_package** differs from the library unit or integration tests, which should be
more comprehensive. These tests are "package" tests, and validate that the package is properly
created, and that the package consumers will be able to link against it and reuse it.

If you look at the ``test_package`` folder, you will realize that the `test_package/example.cpp`{{open}} and the `test_package/CMakeLists.txt`{{open}} files don't have unique characteristics. The `test_package/conanfile.py`{{open}} file is just another recipe.

The `test_package/conanfile.py`{{open}} can described the following characteristics:

- It doesn't have a name and version, as we are not creating a package so they are not
  necessary.
- The ``package()`` and ``package_info()`` methods are not required since we are not creating a
  package.
- The ``test()`` method specifies which binaries need to run.
- The ``imports()`` method is set to copy the shared libraries to the ``bin`` folder. When
  dynamic linking is applied, and the ``test()`` method launches the ``example`` executable, they are
  found causing the ``example`` to run.

An important difference with respect to standard package recipes is that you don't have
to declare a ``requires`` attribute to depend on the tested ``Hello/0.1@demo/testing`` package
as the ``requires`` will automatically be injected by Conan during the run. However, if you choose to
declare it explicitly, it will work, but you will have to remember to bump the version,
and possibly also the user and channel if you decide to change them.
