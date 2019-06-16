
cmake_minimum_required(VERSION 2.8.12)
project (hellolib)

#This fills in the CMake variables with our dependencies. It also sets the right build flags for our compiler etc
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

#Building the actual application
add_library(hellolib hello.cpp)
target_include_directories(hellolib PRIVATE ${CMAKE_SOURCE_DIR} ${CONAN_INCLUDE_DIRS})
target_link_libraries(hellolib ${CONAN_LIBS})