The default ``package_id()`` uses the ``settings`` and ``options`` directly as defined, and assumes the
[semantic versioning](<https://semver.org/>) for dependencies is defined in ``requires``.

This ``package_id()`` method can be overridden to control the package ID generation. Within the ``package_id()``, we have access to the
``self.info`` object, which is hashed to compute the binary ID and contains:

- **self.info.settings**: Contains all the declared settings, always as string values. We can access/modify the settings, e.g.,
  ``self.info.settings.compiler.version``.

- **self.info.options**: Contains all the declared options, always as string values too, e.g., ``self.info.options.shared``.

Initially this ``info`` object contains the original settings and options, but they can be changed without constraints to any other
string value.

For example, if you are sure your package ABI compatibility is fine for all GCC versions, you could do the following:

Let's create a new Conan recipe: `conan new package/6.1`{{execute}}

Now we introduce the method `package_id` in our `conanfile.py`{{open}}

```
    from conans import ConanFile, CMake, tools
    from conans.model.version import Version

    class PkgConan(ConanFile):
        name = "package"
        version = "6.1"
        settings = "compiler", "build_type", "os", "arch"

        def package_id(self):
            if self.settings.compiler == "gcc":
                self.info.settings.compiler.version = "ANY"
```

We have set the ``self.info.settings.compiler.version`` with an arbitrary string, the value of which is not important (could be any string). The
only important thing is that it is the same for any GCC version. For all those versions, the compiler version will always be hashed to the same ID.

Let's try and check that it works properly when installing.

`conan create . package/6.1@conan/testing -s compiler=gcc`{{execute}}

We can see that the computed package ID is ``af04...46ad`` (not real). What happens if we specify another GCC version?

It will result in the same package ID, even compiling other compiler version.

The same way we have adjusted the ``self.info.settings``, we could set the ``self.info.options`` values if needed.

#### Instructions

Let's change the versioning schema from our recipe:

1. In your `conanfile.py`{{open}}, add `package_id` method as demonstrated above
2. Configure to use the same compiler version when is building with GCC.
3. Build your package using the reference `package/6.1@conan/testing`