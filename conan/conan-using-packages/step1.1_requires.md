The required dependencies should be specified in the **[requires]** section of *conanfile.txt*.
Here is an example:

```
[requires]
Poco/1.9.0@pocoproject/stable

```

Where:

  - ``Poco`` is the name of the package which is usually the same as the project/library.
  - ``1.9.0`` is the version which usually matches that of the packaged project/library. This can be any
    string; it does not have to be a number, so, for example, it could indicate if this is a "develop" or "master" version.
    Packages can be overwritten, so it is also OK to have packages like "nightly" or "weekly", that
    are regenerated periodically.
  - ``pocoproject`` is the owner of this package. It is basically a namespace that allows different users to have their own packages for
    the same library with the same name.
  - ``stable`` is the channel. Channels provide another way to have different variants of packages for the same library
    and use them interchangeably. They usually denote the maturity of the package as an arbitrary
    string such as "stable" or "testing", but they can be used for any purpose such as package revisions (e.g., the
    library version has not changed, but the package recipe has evolved).