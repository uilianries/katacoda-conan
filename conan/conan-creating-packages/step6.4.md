By default, Conan assumes `semver <https://semver.org/>`_ compatibility. For example, if a version changes from minor **2.0** to **2.1**, Conan will
assume that the API is compatible (headers not changing), and that it is not necessary to build a new binary for it. This also applies to
patches, whereby changing from **2.1.10** to **2.1.11** doesn't require a re-build.

If it is necessary to change the default behavior, the applied versioning schema can be customized within the ``package_id()`` method:

    from conans import ConanFile, CMake, tools
    from conans.model.version import Version

    class PkgConan(ConanFile):
        name = "package"
        version = "6.4"
        settings = "os", "compiler", "build_type", "arch"
        requires = "MyOtherLib/2.0@lasote/stable"

        def package_id(self):
            myotherlib = self.info.requires["MyOtherLib"]

            # Any change in the MyOtherLib version will change current Package ID
            myotherlib.version = myotherlib.full_version

            # Changes in major and minor versions will change the Package ID but
            # only a MyOtherLib patch won't. E.g., from 1.2.3 to 1.2.89 won't change.
            myotherlib.version = myotherlib.full_version.minor()

Besides ``version``, there are additional helpers that can be used to determine whether the **channel** and **user** of one dependency also
affects the binary package, or even the required package ID can change your own package ID.

You can determine if the following variables within any requirement change the ID of your binary package using the following modes:

```
+-------------------------+----------+-----------------------------------------+----------+-------------+----------------+
| **Modes / Variables**   | ``name`` | ``version``                             | ``user`` | ``channel`` | ``package_id`` |
+=========================+==========+=========================================+==========+=============+================+
| ``semver_direct_mode()``| Yes      | Yes, only > 1.0.0 (e.g., **1**.2.Z+b102)| No       | No          | No             |
+-------------------------+----------+-----------------------------------------+----------+-------------+----------------+
| ``semver_mode()``       | Yes      | Yes, only > 1.0.0 (e.g., **1**.2.Z+b102)| No       | No          | No             |
+-------------------------+----------+-----------------------------------------+----------+-------------+----------------+
| ``major_mode()``        | Yes      | Yes (e.g., **1**.2.Z+b102)              | No       | No          | No             |
+-------------------------+----------+-----------------------------------------+----------+-------------+----------------+
| ``minor_mode()``        | Yes      | Yes (e.g., **1.2**.Z+b102)              | No       | No          | No             |
+-------------------------+----------+-----------------------------------------+----------+-------------+----------------+
| ``patch_mode()``        | Yes      | Yes (e.g., **1.2.3**\+b102)             | No       | No          | No             |
+-------------------------+----------+-----------------------------------------+----------+-------------+----------------+
| ``base_mode()``         | Yes      | Yes (e.g., **1.7**\+b102)               | No       | No          | No             |
+-------------------------+----------+-----------------------------------------+----------+-------------+----------------+
| ``full_version_mode()`` | Yes      | Yes (e.g., **1.2.3+b102**)              | No       | No          | No             |
+-------------------------+----------+-----------------------------------------+----------+-------------+----------------+
| ``full_recipe_mode()``  | Yes      | Yes (e.g., **1.2.3+b102**)              | Yes      | Yes         | No             |
+-------------------------+----------+-----------------------------------------+----------+-------------+----------------+
| ``full_package_mode()`` | Yes      | Yes (e.g., **1.2.3+b102**)              | Yes      | Yes         | Yes            |
+-------------------------+----------+-----------------------------------------+----------+-------------+----------------+
| ``unrelated_mode()``    | No       | No                                      | No       | No          | No             |
+-------------------------+----------+-----------------------------------------+----------+-------------+----------------+
```

All the modes can be applied to all dependencies, or to individual ones:

```
      def package_id(self):
          # apply semver_mode for all the dependencies of the package
          self.info.requires.semver_mode()
          # use semver_mode just for MyOtherLib
          self.info.requires["MyOtherLib"].semver_mode()
```

- **semver_direct_mode()**: This is the default mode. It uses ``semver_mode()`` for direct dependencies (first
  level dependencies, directly declared by the package) and ``unrelated_mode()`` for indirect, transitive
  dependencies of the package. It assumes that the binary will be affected by the direct dependencies, which
  they will already encode how their transitive dependencies affect them. This might not always be true, as
  explained above, and that is the reason it is possible to customize it.

  In this mode, if the package depends on "MyLib", which transitively depends on "MyOtherLib", the mode means:

    MyLib/1.2.3@user/testing       => MyLib/1.Y.Z
    MyOtherLib/2.3.4@user/testing  =>

  So the direct dependencies are mapped to the major version only. Changing its channel, or using version
  ``MyLib/1.4.5`` will still produce ``MyLib/1.Y.Z`` and thus the same package-id.
  The indirect, transitive dependency doesn't affect the package-id at all.

- **semver_mode()**: In this mode, only a major release version (starting from **1.0.0**) changes the package ID.
  Every version change prior to 1.0.0 changes the package ID, but only major changes after 1.0.0 will be applied.

```
    def package_id(self):
      self.info.requires["MyOtherLib"].semver_mode()
```

  This results in:

    MyLib/1.2.3@user/testing       => MyLib/1.Y.Z
    MyOtherLib/2.3.4@user/testing  => MyOtherLib/2.Y.Z

  In this mode, versions starting with ``0`` are considered unstable and mapped to the full version:

    MyLib/0.2.3@user/testing       => MyLib/0.2.3
    MyOtherLib/0.3.4@user/testing  => MyOtherLib/0.3.4

- **major_mode()**: Any change in the major release version (starting from **0.0.0**) changes the package ID.

```
    def package_id(self):
      self.info.requires["MyOtherLib"].major_mode()
```

  This mode is basically the same as ``semver_mode``, but the only difference is that major versions ``0.Y.Z``,
  which are considered unstable by semver, are still mapped to only the major, dropping the minor and patch parts.

- **minor_mode()**: Any change in major or minor (not patch nor build) version of the required dependency changes the package ID.

```
      def package_id(self):
          self.info.requires["MyOtherLib"].minor_mode()
```

- **patch_mode()**: Any changes to major, minor or patch (not build) versions of the required dependency change the package ID.

```
      def package_id(self):
          self.info.requires["MyOtherLib"].patch_mode()
```

- **base_mode()**: Any changes to the base of the version (not build) of the required dependency changes the package ID. Note that in the
  case of semver notation this may produce the same result as ``patch_mode()``, but it is actually intended to dismiss the build part of the
  version even without strict semver.

```
      def package_id(self):
          self.info.requires["MyOtherLib"].base_mode()
```

- **full_version_mode()**: Any changes to the version of the required dependency changes the package ID.

```
    def package_id(self):
      self.info.requires["MyOtherLib"].full_version_mode()
```

    MyOtherLib/1.3.4-a4+b3@user/testing  => MyOtherLib/1.3.4-a4+b3

- **full_recipe_mode()**: Any change in the reference of the requirement (user & channel too) changes the package ID.

```
    def package_id(self):
      self.info.requires["MyOtherLib"].full_recipe_mode()
```

  This keeps the whole dependency reference, except the package-id of the dependency.

    MyOtherLib/1.3.4-a4+b3@user/testing  => MyOtherLib/1.3.4-a4+b3@user/testing

- **full_package_mode()**: Any change in the required version, user, channel or package ID changes the package ID.

```
    def package_id(self):
      self.info.requires["MyOtherLib"].full_package_mode()
```

  This is the stricter mode. Any change to the dependency, including its binary package-id, will in turn
  produce a new package-id for the consumer package.

    MyOtherLib/1.3.4-a4+b3@user/testing:73b..fa56  => MyOtherLib/1.3.4-a4+b3@user/testing:73b..fa56

- ``unrelated_mode()``: Requirements do not change the package ID.

```
      def package_id(self):
          self.info.requires["MyOtherLib"].unrelated_mode()
```

You can also adjust the individual properties manually:

```
    def package_id(self):
        myotherlib = self.info.requires["MyOtherLib"]

        # Same as myotherlib.semver_mode()
        myotherlib.name = myotherlib.full_name
        myotherlib.version = myotherlib.full_version.stable()  # major(), minor(), patch(), base, build
        myotherlib.user = myotherlib.channel = myotherlib.package_id = None

        # Only the channel (and the name) matters
        myotherlib.name = myotherlib.full_name
        myotherlib.user = myotherlib.package_id = myotherlib.version = None
        myotherlib.channel = myotherlib.full_channel
```

The result of the ``package_id()`` is the package ID hash, but the details can be checked in the
generated *conaninfo.txt* file. The ``[requires]``, ``[options]`` and ``[settings]`` are taken
into account when generating the SHA1 hash for the package ID, while the ``[full_xxxx]`` fields show the
complete reference information.

The default behavior produces a *conaninfo.txt* that looks like:

```
    [requires]
    MyOtherLib/2.Y.Z

    [full_requires]
    MyOtherLib/2.2@demo/testing:73bce3fd7eb82b2eabc19fe11317d37da81afa56
```

#### Instructions

Let's change the versioning schema from our recipe:

1. In your `conanfile.py`{{open}}, add `package_id` method as demonstrated above
2. Configure to all requirements use `full_versions_mode` as versioning mode.
3. Build your package using the reference `package/6.4@conan/testing`
