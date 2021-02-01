# CMakeLists.txt
cmake_minimum_required(VERSION 3.0)
project(test)
include(/vcpkg/scripts/buildsystems/vcpkg.cmake)
find_package( Threads )
FIND_PACKAGE( Boost 1.75 COMPONENTS program_options REQUIRED )
INCLUDE_DIRECTORIES( ${Boost_INCLUDE_DIR} )

find_package(cppnetlib CONFIG REQUIRED)


add_executable(main main.cpp )

target_include_directories(main PRIVATE  cppnetlib-uri cppnetlib-server-parsers cppnetlib-client-connections)


TARGET_LINK_LIBRARIES( main LINK_PUBLIC   ${CMAKE_THREAD_LIBS_INIT} ${Boost_LIBRARIES} )


