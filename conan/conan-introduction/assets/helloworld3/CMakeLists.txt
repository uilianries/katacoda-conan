
cmake_minimum_required(VERSION 2.8.12)
project (hello3)

#This fills in the CMake variables with our dependencies. It also sets the right build flags for our compiler etc
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

#Building the actual application
add_executable(hello3 hello3.cpp)
target_link_libraries(hello3 ${CONAN_LIBS})