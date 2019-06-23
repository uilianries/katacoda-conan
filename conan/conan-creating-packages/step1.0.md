First, let's create a folder for our package recipe, and use the `conan new` helper command that
will create a working package recipe for us:

`conan new Hello/0.1 -t`{{execute}}

This will generate the following files:

* `conanfile.py`{{open}}
* `test_package/CMakeLists.txt`{{open}}
* `test_package/conanfile.py`{{open}}
* `test_package/example.cpp`{{open}}

On the root level, there is a *conanfile.py* which is the main recipe file, responsible for
defining our package. Also, there is a *test_package* folder, which contains a simple example
consuming project that will require and link with the created package. It is useful to make sure
that our package is correctly created.

Let's have a look at the root package recipe `conanfile.py`{{open}}

This is a complete package recipe. Without going into detail, these are the basics:

The `settings` field defines the configuration of the different binary packages. In
this example, we defined that any change to the OS, compiler, architecture or build type will
generate a different binary package. Please note that Conan generates different binary packages for
different introduced configuration (in this case settings) for the same recipe.

Note that the platform on which the recipe is running and the package being built differ from
the final platform where the code will be running (``self.settings.os`` and ``self.settings.arch``) if
the package is being cross-built.

So if you want to apply a different build depending on the current build machine, you need to check it:

```
def build(self):
    if platform.system() == "Windows":
        cmake = CMake(self)
        cmake.configure(source_folder="hello")
        cmake.build()
    else:
        env_build = AutoToolsBuildEnvironment(self)
        env_build.configure()
        env_build.make()
```

This package recipe is also able to create different binary packages for static and shared
libraries with the ``shared`` option, which is set by default to ``False`` (i.e. by default it will use
static linkage).

The ``source()`` method executes a `git clone` to retrieve the sources from Github. Other
origins, such as downloading a zip file are also available. As you can see, any manipulation of the
code can be done, such as checking out any branch or tag, or patching the source code. In this example,
we are adding two lines to the existing CMake code, to ensure binary compatibility. Don't worry
about it now, we'll deal with it later

The ``build()`` configures the project, and then proceeds to build it using standard CMake commands. The
``CMake`` object just assists to translate the Conan settings to CMake command line
arguments. Please note that **CMake is not strictly required**. You can build packages directly
by invoking **make**, **MSBuild**, **SCons** or any other build system.

The ``package()`` method copies artifacts (headers, libs) from the build folder to the final
package folder.

Finally, the ``package_info()`` method defines that the consumer must link with the "hello" library
when using this package. Other information as include or lib paths can be defined as well. This
information is used for files created by generators to be used by consumers, as
*conanbuildinfo.cmake*.

#### Instructions

1. Run `conan new Hello/0.1 -t`{{execute}} to create a new Conan project