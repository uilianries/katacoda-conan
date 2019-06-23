We have used settings such as ``os``, ``arch`` and ``compiler``. Note the above package recipe also contains a ``shared`` option (defined as ``options = {"shared": [True, False]}``). What is the difference between settings and options?

**Settings** are a project-wide configuration, something that typically affects the whole project that
is being built. For example, the operating system or the architecture would be naturally the same for all packages in a dependency graph, linking a Linux library for a Windows app, or
mixing architectures is impossible.

Settings cannot be defaulted in a package recipe. A recipe for a given library cannot say that its default is ``os=Windows``. The ``os`` will be given by the environment in which that recipe is processed. It is a mandatory input.

Settings are configurable. You can edit, add, remove settings or subsettings in your *settings.yml* file.

On the other hand, **options** are a package-specific configuration. Static or shared library are not
settings that apply to all packages. Some can be header only libraries while others packages can be just data, or package executable. Packages can contain a mixture of different artifacts. ``shared`` is a common option, but packages can define and use any options they want.

Options are defined in the package recipe, including their supported values, while other can be defaulted by the package recipe itself. A package for a library can well define that by default it will be a static library (a typical default). If not specified other, the package will be static.

There are some exceptions to the above. For example, settings can be defined per-package using the command line:

`conan install . -s MyPkg:compiler=gcc -s compiler=clang ..`

This will use ``gcc`` for MyPkg and ``clang`` for the rest of the dependencies (extremely rare case).

There are situations whereby many packages use the same option, thereby allowing you to set its value once using patterns, like:

`conan install . -o *:shared=True`{{execute}}

#### Instructions

1. Build `Hello/0.1@demo/testing` as shared library.