So far, we have used the default settings stored in ``~/.conan/profiles/default`` and defined as command line arguments.

However, in large projects, configurations can get complex, settings can be very different, and we need an easy way to switch between different configurations with different settings, options etc,.
An easy way to switch between configurations is by using profiles.

A profile file contains a predefined set of ``settings``, ``options``, ``environment variables``, and ``build_requires`` specified in the following structure:


    [settings]
    setting=value

    [options]
    MyLib:shared=True

    [env]
    env_var=value

    [build_requires]
    Tool1/0.1@user/channel
    Tool2/0.1@user/channel, Tool3/0.1@user/channel
    *: Tool4/0.1@user/channel

Options allow the use of wildcards letting you apply the same option value to many packages. For example:


    [options]
    *:shared=True

Here is an example of a configuration that a profile file may contain:

    [settings]
    os=Macos
    arch=x86_64
    compiler=clang
    compiler.version=3.5
    compiler.libcxx=libstdc++11
    build_type=Release

    [env]
    CC=/usr/bin/clang
    CXX=/usr/bin/clang++

A profile file can be stored in the default profile folder, or anywhere else in your project file structure. To use the configuration specified in a profile file, pass in the file as a command line argument as shown in the example below:

    $ conan create . demo/testing -pr=clang_3.5

Continuing with the example of Poco, instead of passing in a long list of command line arguments, we can define a handy profile that defines them all and pass that to the command line when installing the different project dependencies.

A profile to install dependencies as **shared** and in **debug** mode would look like this:

    include(default)

    [settings]
    build_type=Debug

    [options]
    Poco:shared=True
    Poco:enable_apacheconnector=False
    OpenSSL:shared=True

To install dependencies using the profile file, we would use:

    $ conan install . -pr=debug_shared

We could also create a new profile to use a different compiler version and store that in our project directory. For example:

    include(clang_3.5)

    [options]
    Poco:shared=True
    Poco:enable_apacheconnector=False
    OpenSSL:shared=True

To install dependencies using this new profile, we would use:

    $ conan install . -pr=./poco_clang_3.5

You can specify multiple profiles in the command line. The applied configuration will be the composition
of all the profiles applied in the order they are specified:

    $ conan install . -pr=./poco_clang_3.5 -pr=my_build_tool1 -pr=my_build_tool2

#### Instructions

1. Show your current profile running `conan profile show default`{{execute}}