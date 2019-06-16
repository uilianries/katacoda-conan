Conan is a decentralized package manager with a client-server architecture. This means that clients
can fetch packages from, as well as upload packages to, different servers "remotes", similar to
the "git" push-pull model to/from git remotes.

On a high level, the servers are just package storage. They do not build nor create the packages.
The packages are created by the client, and if binaries are built from sources, that compilation is
also done by the client application.

![conan-systems](https://docs.conan.io/en/latest/_images/systems.png)

The different applications in the image above are:

- The **Conan client**: this is a console/terminal command line application, containing the heavy
  logic for package creation and consumption. Conan client has a local cache for package storage,
  and so it allows you to fully create and test packages offline. You can also **work offline** so
  long as no new packages are needed from remote servers.
- The **Conan server**: this is a TCP server that can be easily run as your **own server
  on-premises** to host your private packages. It is also a service application that can be run as a
  daemon or service, behind a web server (apache, nginx), or easily as stand-alone application. Both
  the Conan client and the conan_server are OSS, MIT license, so you can use them for free in your
  company, customize them, or redistribute them without any legal issue.
- **JFrog** [Artifactory](https://jfrog.com/artifactory) offers Conan repositories; so it can
  also be used as an on-premises server. It is a more powerful solution, featuring a WebUI, multiple
  auth protocols, High Availability, etc. It also has cloud offerings that will allow you to have
  private packages without having any on-premises infrastructure.
- **JFrog** [Bintray](https://bintray.com) provides a public and free hosting service for OSS
  Conan packages. Users can create their own repositories under their accounts and organizations,
  and freely upload Conan packages there, without moderation. You should, however, take into account
  that those packages will be public, and so they must conform to the respective licenses,
  especially if the packages contain third party code. Just reading or retrieving Conan packages
  from Bintray, doesn't require an account, an account is only needed to upload packages. Besides
  that, Bintray provides a central repository called [conan-center](https://bintray.com/conan/conan-center)
  which is moderated, and packages are reviewed before
  being accepted to ensure quality.
