cmake_minimum_required(VERSION 3.16)
project(MyCppApp LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(greeting src/greeting.cpp)
target_include_directories(greeting PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)

add_executable(my_app src/main.cpp)
target_link_libraries(my_app PRIVATE greeting)

option(BUILD_TESTS "Build unit tests" OFF)

if(BUILD_TESTS)
  find_package(GTest REQUIRED)
  include(GoogleTest)

  add_executable(my_test tests/test.cpp)
  target_link_libraries(my_test PRIVATE greeting GTest::gtest_main)

  enable_testing()
  gtest_discover_tests(my_test)
endif()

