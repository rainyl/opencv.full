project(opencv_full_test)
cmake_minimum_required(VERSION 3.5)

if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    add_compile_options(/MT)
endif()

# opencv4 requires c++11
set(CMAKE_CXX_STANDARD 11)

if(LINUX OR APPLE)
    find_package(Iconv REQUIRED)
endif()

if(APPLE OR IOS)
    # set OpenCV_DIR to where opencv2.framework resides
    find_library(OpenCV_LIBS NAMES opencv2 PATHS ${OpenCV_DIR})
else()
    # set OpenCV_DIR to where OpenCVConfig.cmake resides
    find_package(OpenCV REQUIRED)
endif()
find_package(FFMPEG REQUIRED)

message(STATUS "OpenCV found: ${OpenCV_VERSION}")
message(STATUS "OpenCV libs: ${OpenCV_LIBS}")

add_executable(opencv_full_test main.cpp)
target_include_directories(opencv_full_test PRIVATE ${OpenCV_INCLUDE_DIRS} ${FFMPEG_INCLUDE_DIRS})

target_link_libraries(opencv_full_test ${OpenCV_LIBS} ${FFMPEG_LIBRARIES})
