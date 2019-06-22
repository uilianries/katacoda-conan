Conan installed our Poco dependency but also the transitive dependencies for it: *OpenSSL* and *zlib*.
It has also generated a conanbuildinfo.cmake file for our build system.

Now let’s create our build file. Now we are ready to build and run our Encrypter app.

#### Instructions

1. Run CMake to configure our project `cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release`
2. Build the example `cmake --build .`{{execute}}
3. Run! `bin/md5`{{execute}}