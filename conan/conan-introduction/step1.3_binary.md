One of the most powerful features of Conan is that it can manage pre-compiled binaries for packages. To
define a package, referenced by its name, version, user and channel, a package recipe is needed.
Such a package recipe is a conanfile.py python script that defines how the package is built from
sources, what the final binary artifacts are, the package dependencies, etc.

![binary-management](https://docs.conan.io/en/latest/_images/binary_mgmt.png)

When a package recipe is used in the Conan client, and a "binary package" is built from sources, that
binary package will be compatible with specific settings, such as the OS it was created for, the
compiler and compiler version, or the computer architecture. If the package is built again from the
same sources but with different settings, (e.g. for a different architecture), a new, different
binary will be generated. By the way, "binary package" is in quotes because, strictly, it is not
necessarily a binary. A header-only library, for example, will contain just the headers in the
"binary package".

All the binary packages generated from a package recipe are managed and stored coherently. When they
are uploaded to a remote, they stay connected. Also, different clients building binaries from the
same package recipe (like CI build slaves in different operating systems), will upload their
binaries under the same package name to the remotes.

Package consumers (client application users that are installing existing packages to reuse in their
projects) will typically retrieve pre-compiled binaries for their systems in case such compatible
binaries exist. Otherwise those packages will be built from sources on the client machine to create
a binary package matching their settings.