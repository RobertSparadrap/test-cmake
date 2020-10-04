cmake_minimum_required(VERSION 3.2.0)

project(benchmarking)
set(CMAKE_CXX_STANDARD 14)

find_package(benchmark REQUIRED)
if (NOT benchmark_FOUND)
    include(ExternalProject)
    ExternalProject_Add(
	benchmark 
  	URL "${CMAKE_SOURCE_DIR}/third_party/benchmark.zip"
  	PREFIX "${CMAKE_CURRENT_BINARY_DIR}/benchmark"
  	CMAKE_CACHE_ARGS
    		-DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}
    		-DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
  	INSTALL_COMMAND "" # Disable install step
  	# Ugly but necessary, in future versions one can use ${binary_dir}
  	# in BUILD_BYPRODUCTS
  	#BUILD_BYPRODUCTS "${binary_dir}/libgtest.a"
  	BUILD_BYPRODUCTS "${CMAKE_BINARY_DIR}/gtest/src/gtest-build/libgtest.a"
    )

    add_library(libbenchmark IMPORTED STATIC GLOBAL)
    add_dependencies(libbenchmark benchmark)
    find_package(benchmark REQUIRED)
endif()

set(SOURCES src/main.cc)

add_executable(benchmarking 
                ${SOURCES}
                )
#add_dependencies(benchmarking benchmark)

target_link_libraries(benchmarking benchmark::benchmark)
