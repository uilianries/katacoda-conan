You can create and test the package with our default settings simply by running:

`conan create . demo/testing`{{execute}}

If "Hello world!" is displayed, it worked.

The `conan create` command does the following:

- Copies ("export" in Conan terms) the `conanfile.py`{{open}} from the user folder into the **local cache**.
- Installs the package, forcing it to be built from the sources.
- Moves to the *test_package* folder and creates a temporary *build* folder.
- Executes the `conan install ..`, to install the requirements of the
  `test_package/conanfile.py`{{open}}. Note that it will build "Hello" from the sources.
- Builds and launches the *example* consuming application, calling the *test_package/conanfile.py*
  ``build()`` and ``test()`` methods respectively.

Using Conan commands, the `conan create` command would be equivalent to:

`conan export . demo/testing`{{execute}}
`conan install Hello/0.1@demo/testing --build=Hello`{{execute}}
`conan test test_package Hello/0.1@demo/testing`{{execute}}

The `conan create` command receives the same command line parameters as `conan install` so
you can pass to it the same settings, options, and command line switches. If you want to create and
test packages for different configurations, you could:

`conan create . demo/testing -s build_type=Debug`{{execute}}
`conan create . demo/testing -o Hello:shared=True -s arch=x86`{{execute}}
`conan create . demo/testing -pr my_gcc49_debug_profile`{{execute}}

#### Instructions

1. Build your package running `conan create . demo/testing`{{execute}}