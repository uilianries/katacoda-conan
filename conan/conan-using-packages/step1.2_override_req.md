You can specify multiple requirements and **override** transitive "require's
requirements". In our example, Conan installed the Poco package and all its requirements
transitively:

  * **OpenSSL/1.0.2o@conan/stable**
  * **zlib/1.2.11@conan/stable**

This is a good example of overriding requirements given the importance of keeping
the OpenSSL library updated.

Consider that a new release of the OpenSSL library has been released, and a new corresponding Conan package is available. In our example, we do not need to wait until `pocoproject` (the author) generates a new package of POCO that includes the new OpenSSL library.

We can simply enter the new version in **[requires]** section:

```
[requires]
Poco/1.9.0@pocoproject/stable
OpenSSL/1.0.2s@conan/stable

```

The second line will override the OpenSSL/1.0.2o required by POCO with the currently non-existent **OpenSSL/1.0.2s**.

Another example in which we may want to try some new zlib alpha features, we could replace the zlib
requirement with one from another user or channel.

```
[requires]
Poco/1.9.0@pocoproject/stable
OpenSSL/1.0.2o@conan/stable
zlib/1.2.11@otheruser/alpha

```

#### Instructions

1. Open the file `poco_requires/conanfile.txt`{{open}}
2. Add *OpenSSL/1.0.2s@conan/stable* in requires
3. Add *zlib/1.2.11@conan/stable* in requires
4. Using your *poco_requires/conanfile.txt*, install all packages