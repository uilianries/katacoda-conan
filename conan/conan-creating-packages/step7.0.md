You can inspect the uploaded packages and also the packages in the local cache by running the `conan get`{{execute}} command.

Let's see some usual examples:

- List Conan get help:

`conan get --help`{{execute}}

- List the files of a local recipe folder:

`conan get zlib/1.2.8@conan/stable .`{{execute}}

- Print the *conaninfo.txt* file of a binary package:

`conan get zlib/1.2.11@conan/stable -p 2144f833c251030c3cfd61c4354ae0e38607a909`{{execute}}

- Print the *conanfile.py* from a remote package:

`conan get zlib/1.2.8@conan/stable -r conan-center`{{execute}}


#### Instructions

1. Using **conan get** command, inspect the *conanfile.py* from *OpenSSL/1.0.2s@conan/stable*
