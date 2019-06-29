The default ``package_id()`` uses the ``settings`` and ``options`` directly as defined, and assumes the
`semantic versioning <https://semver.org/>`_ for dependencies is defined in ``requires``.

This ``package_id()`` method can be overridden to control the package ID generation. Within the ``package_id()``, we have access to the
``self.info`` object, which is hashed to compute the binary ID and contains:

- **self.info.settings**: Contains all the declared settings, always as string values. We can access/modify the settings, e.g.,
  ``self.info.settings.compiler.version``.

- **self.info.options**: Contains all the declared options, always as string values too, e.g., ``self.info.options.shared``.

Initially this ``info`` object contains the original settings and options, but they can be changed without constraints to any other
string value.

For example, if you are sure your package ABI compatibility is fine for GCC versions > 4.5 and < 5.0, you could do the following:

    from conans import ConanFile, CMake, tools
    from conans.model.version import Version

    class PkgConan(ConanFile):
        name = "Pkg"
        version = "1.0"
        settings = "compiler", "build_type"

        def package_id(self):
            v = Version(str(self.settings.compiler.version))
            if self.settings.compiler == "gcc" and (v >= "4.5" and v < "5.0"):
                self.info.settings.compiler.version = "GCC version between 4.5 and 5.0"

We have set the ``self.info.settings.compiler.version`` with an arbitrary string, the value of which is not important (could be any string). The
only important thing is that it is the same for any GCC version between 4.5 and 5.0. For all those versions, the compiler version will
always be hashed to the same ID.

Let's try and check that it works properly when installing the package for GCC 4.5:

    $ conan create . Pkg/1.0@myuser/mychannel -s compiler=gcc -s compiler.version=4.5 ...

    Requirements
        Pkg/1.0@myuser/mychannel from local
    Packages
        Pkg/1.0@myuser/mychannel:af044f9619574eceb8e1cca737a64bdad88246ad
    ...

We can see that the computed package ID is ``af04...46ad`` (not real). What happens if we specify GCC 4.6?

    $ conan install Pkg/1.0@myuser/mychannel -s compiler=gcc -s compiler.version=4.6 ...

    Requirements
        Pkg/1.0@myuser/mychannel from local
    Packages
        Pkg/1.0@myuser/mychannel:af044f9619574eceb8e1cca737a64bdad88246ad

The required package has the same result again ``af04...46ad``. Now we can try using GCC 4.4 (< 4.5):

    $ conan install Pkg/1.0@myuser/mychannel -s compiler=gcc -s compiler.version=4.4 ...

    Requirements
        Pkg/1.0@myuser/mychannel from local
    Packages
        Pkg/1.0@myuser/mychannel:7d02dc01581029782b59dcc8c9783a73ab3c22dd

The computed package ID is different which means that we need a different binary package for GCC 4.4.

The same way we have adjusted the ``self.info.settings``, we could set the ``self.info.options`` values if needed.

.. seealso::

    Check :ref:`method_package_id` to see the available helper methods and change its behavior for things like:

        - Recipes packaging **header only** libraries.
        - Adjusting **Visual Studio toolsets** compatibility.

#### Instructions

