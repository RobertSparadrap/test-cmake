#set(GOOGLEBENCHMARK_PREFIX
#        "${benchmark_BINARY_DIR}/third_party/googlebenchmark")
#set(GOOGLEBENCHMARK_PATH "${CMAKE_CURRENT_SOURCE_DIR}/googlebenchmark" CACHE
#        PATH "")
#execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}"
#  -DGOOGLEBENCHMARK_PATH:PATH=${GOOGLEBENCHMARK_PATH} .
#  RESULT_VARIABLE result
#  WORKING_DIRECTORY ${GOOGLEBENCHMARK_PREFIX}
#)


ExternalProject_Add(
  benchmark
  URL "${CMAKE_SOURCE_DIR}/third_party/benchmark.zip"
  PREFIX "${CMAKE_CURRENT_BINARY_DIR}/benchmark"
  CMAKE_CACHE_ARGS
    -DCMAKE_CXX_COMPILER:FILEPATH=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_COMPILER:FILEPATH=${CMAKE_C_COMPILER}
  INSTALL_COMMAND "" # Disable install step
  BUILD_BYPRODUCTS "${CMAKE_BINARY_DIR}/benchmark/build/src/libbenchmark.a"
)