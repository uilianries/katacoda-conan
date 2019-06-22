There are some differences between shared libraries on Linux (\*.so), Windows (\*.dll) and MacOS
(\*.dylib). The shared libraries must be located in a folder where they can be found, either by
the linker, or by the OS runtime.

You can add the libraries' folders to the path (dynamic linker `LD_LIBRARY_PATH` path
in Linux, `DYLD_LIBRARY_PATH` in OSX, or system `PATH` in Windows), or copy those shared libraries to
some system folder where they can be found by the OS. But these operations are typical operations deployments or final installation of apps; they are not desired during development, and Conan is intended for developers, so it avoids manipulations on the OS.

In Windows and OSX, the simplest approach is to copy the shared libraries to the executable
folder, so they are found by the executable, without having to modify the path.

This is done using the **[imports]** section in ``conanfile.txt``.

To demonstrate this, edit the ``conanfile.txt`` file and paste the following **[imports]** section:

```
[requires]
Poco/1.9.0@pocoproject/stable

[generators]
cmake

[options]
Poco:shared=True
OpenSSL:shared=True

[imports]
bin, *.dll -> ./bin # Copies all dll files from packages bin folder to my "bin" folder
lib, *.dylib* -> ./bin # Copies all dylib files from packages lib folder to my "bin" folder

```

You can explore the package folder in your local cache (~/.conan/data) and see where the shared
libraries are. It is common that **\*.dll** are copied to **/bin**. The rest of the libraries
should be found in the **/lib** folder, however, this is just a convention, and different layouts are
possible.

As you can see, the **[imports]** section is a very generic way to import files from your
requirements to your project.

This method can be used for packaging applications and copying the resulting executable to your bin
folder, or for copying assets, images, sounds, test static files, etc. Conan is a generic solution
for package management, not only (but focused in) for C/C++ or libraries.

#### Instructions

1. Open `poco_requires/conanfile.txt`{{open}}
2. Add `[imports]` section in *conanfile.txt*
3. Add `lib, *.so* -> ./bin` in imports section
4. Using your *poco_requires/conanfile.txt*, install all packages
5. Check what's in *bin* folder
