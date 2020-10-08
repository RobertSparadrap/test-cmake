cmake_minimum_required(VERSION 3.2.0)


 option(benchmark "Build a Benchmark." OFF)
 option(biodynamo "Sart the demo cell_division." OFF)
 option(bench-bdm "Sart the benchmark of cell_division." OFF)

 if(benchmark)
	project(biodynamo-benchmark)
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
  			INSTALL_COMMAND ""
		)
		add_library(libbenchmark IMPORTED STATIC GLOBAL)
		add_dependencies(libbenchmark benchmark)
		find_package(benchmark REQUIRED)
	endif()

	set(SOURCES src/main.cc)

	add_executable(biodynamo-benchmark 
    	            ${SOURCES}
        	        )

	target_link_libraries(biodynamo-benchmark benchmark::benchmark)

	add_custom_target(run-benchmark COMMAND ${CMAKE_BINARY_DIR}/biodynamo-benchmark)
	add_dependencies(run-benchmark biodynamo-benchmark)
endif()

if(biodynamo)
	project(bdm)
	find_package(BioDynaMo REQUIRED)
	include(${BDM_USE_FILE})
	include_directories("src")

	target_link_libraries(benchmark::benchmark)

	file(GLOB_RECURSE HEADERS cell_division/src/*.h)
	file(GLOB_RECURSE SOURCES cell_division/src/*.cc)

	bdm_add_executable(bdm
    	               HEADERS ${HEADERS}
        	           SOURCES ${SOURCES}
            	       LIBRARIES ${BDM_REQUIRED_LIBRARIES} benchmark)
endif()

if(bench-bdm)
	project(cell_division)

	find_package(BioDynaMo REQUIRED)
	find_package(benchmark REQUIRED)
	include("${BDM_USE_FILE}")
	include_directories("src")

	target_link_libraries(benchmark::benchmark)

	file(GLOB_RECURSE HEADERS cell_division2/src/*.h)
	file(GLOB_RECURSE SOURCES src/bench-main.cc)

	bdm_add_executable(cell_division
    	               HEADERS "${HEADERS}"
        	           SOURCES "${SOURCES}"
            	       LIBRARIES ${BDM_REQUIRED_LIBRARIES} benchmark)
	add_custom_target(run-benchmark COMMAND ${CMAKE_BINARY_DIR}/cell_division)
	add_dependencies(run-benchmark cell_division)
endif()