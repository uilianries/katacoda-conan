Conan reads the **[generators]** section from *conanfile.txt* and creates files for each generator with all the information needed to link your program with the specified requirements. The generated files are usually temporary, created in build folders and not committed to version control, as they have paths to local folders that will not exist in another machine. Moreover, it is very important to highlight that generated files match the given configuration (Debug/Release, x86/x86_64, etc) specified when running conan install. If the configuration changes, the files will change accordingly.

Conan provides a big number of generators:
* CMake
* QMake
* Visual Studio
* XCode
* pkg_config
* ...

#### Instructions

1. Open `poco_requires/conanfile.txt`{{open}}
2. Add `[generators]` section in *conanfile.txt*
3. Add `cmake` in generators list
4. Using your *poco_requires/conanfile.txt*, install all packages
5. Check the generated file `conanbuildinfo.cmake`{{open}}