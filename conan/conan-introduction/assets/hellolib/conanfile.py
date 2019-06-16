from conans import ConanFile, CMake, tools

class HelloConan(ConanFile):
    name = "hellolib"
    version = "1.0.0"
    license = "WTFPL"
    url = "https://www.katacoda.com/monsdar/scenarios/conan"
    description = "This is a simple library used within the Katacoda tutorial by monsdar"
    settings = "os", "compiler", "build_type", "arch"
    options = {"shared": [True, False]}
    default_options = {"shared": False}
    generators = "cmake"
    exports_sources="hello.h", "hello.cpp", "CMakeLists.txt"

    options = {"text": "ANY"}
    default_options = {"text": "blablabla"}
    
    def requirements(self):
        self.requires("Poco/1.9.0@pocoproject/stable")
    
    def build(self):
        cmake = CMake(self)
        cmake.configure(source_folder=".")
        cmake.build()

    def package(self):
        self.copy("*.h", dst="include")
        self.copy("*hello.lib", dst="lib", keep_path=False)
        self.copy("*.dll", dst="bin", keep_path=False)
        self.copy("*.so", dst="lib", keep_path=False)
        self.copy("*.dylib", dst="lib", keep_path=False)
        self.copy("*.a", dst="lib", keep_path=False)

    def package_info(self):
        self.cpp_info.libs = ["hellolib"]

    def deploy(self):
        f = open("d:/Github/katacoda/katacoda-scenarios/conan/assets/demofile.txt", "a")
        f.write(str(self.options.text))