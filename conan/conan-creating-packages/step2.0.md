
In the previous section, we fetched the sources of our library from an external repository.
It is a typical workflow for packaging third party libraries.

There are two different ways to fetch the sources from an external repository:

1. Using the ``source()`` method as we displayed in the previous section:

    from conans import ConanFile, CMake, tools

    class HelloConan(ConanFile):
        ...

        def source(self):
            self.run("git clone https://github.com/conan-io/hello.git")
            ...

You can also use the `tools.Git` class:

    from conans import ConanFile, CMake, tools

    class HelloConan(ConanFile):
        ...

        def source(self):
            git = tools.Git(folder="hello")
            git.clone("https://github.com/conan-io/hello.git", "master")
            ...

2. Using the `scm attribute` of the ConanFile:

    from conans import ConanFile, CMake, tools

    class HelloConan(ConanFile):
         scm = {
            "type": "git",
            "subfolder": "hello",
            "url": "https://github.com/conan-io/hello.git",
            "revision": "master"
         }
        ...

Conan will clone the ``scm url`` and will checkout the ``scm revision``.

The ``source()`` method will be called after the checkout process, so you can still use it to patch something or retrieve more sources, but it is not necessary in most cases.
