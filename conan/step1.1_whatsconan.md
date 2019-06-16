Conan is a package manager mainly targeted for C++ development. It is available as Open Source software [on Github](https://github.com/conan-io/conan).

Conan works decentralized, it is possible to upload packages to different servers.
![Conan Package Options](https://docs.conan.io/en/latest/_images/systems.png)

* The **Conan client** is  the command line application you are using on your computer as a user. It is used to create and consume packages, search remotes or calculate dependency trees.
* The **Conan server** is the typical package server you'll be running on your own hardware. It works well for smaller dev teams and scales up to thousands of packages.
* **JFrog Artifactory** is an enterprise grade artifact storage system providing support for storing Conan packages as well. It is the right choice for larger dev teams and has features like a Web UI, extended security systems, high availability etc. JFrog also offers cloud solutions so you do not have to host it on your own infrastructure.
* **JFrog Bintray** provides public and free hosting for Open Source Conan packages. It is configured to be the default package server in Conan.

The basic information of a Conan package is the following:
* **Name**: A Conan package has a name. It is recommended to use lowercase as a naming convention.
* **Version**: This is the version of the package. Conan supports [SemVer 2.0](https://semver.org/).
* **User**: The creator of the package. This typically is the username you are using on the Conan server.
* **Channel**: It is possible to release packages in different channels, allowing to identify the maturity or type of package. Typical channels are e.g. `release` or `testing`.

When wrapping this info together the result is the Conan reference: `Package/1.0.0@user/channel`.

Besides having a reference, a Conan package contains
* a recipe that contains information on how to build the package
* prebuilt binaries for typical build environments

![Package contents](https://docs.conan.io/en/latest/_images/binary_mgmt.png)

When downloading packages Conan will cache them in a local directory. This is called the local Conan cache and contains the latest versions of what a user has installed. Having a local cache provides some advantages:
* It is not necessary to always have a server connection
* Local workflows can be very fast
* It acts as a staging area for testing purposes before uploading anything to the server

Conan works with every build system and is written in portable Python. Right now Windows, Linux, OSX, FreeBSD and SunOS are actively supported. It mainly supports CMake as build system, but there are generators for many other systems as well.