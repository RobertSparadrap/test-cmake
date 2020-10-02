cmake_minimum_required(VERSION 3.2.0)

project(benchmarking)


find_package(benchmark REQUIRED)
if (NOT benchmark_FOUND)
    message(FATAL_ERROR "benchmark not found.")
endif()

target_link_libraries(benchmark::benchmark)

set(SOURCES src/main.cc)

add_executable(benchmarking 
                ${SOURCES}
                )