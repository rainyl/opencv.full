project(opencv-mobile-test)
cmake_minimum_required(VERSION 3.5)

if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    add_compile_options(/MT)
endif()

# opencv4 requires c++11
set(CMAKE_CXX_STANDARD 11)

if(LINUX OR APPLE)
    find_package(Iconv REQUIRED)
endif()

find_package(OpenCV REQUIRED)
find_package(FFMPEG REQUIRED)

add_executable(opencv-mobile-test main.cpp)
target_include_directories(opencv-mobile-test PRIVATE ${OpenCV_INCLUDE_DIRS} ${FFMPEG_INCLUDE_DIRS})

target_link_libraries(opencv-mobile-test opencv_highgui opencv_core opencv_imgproc ${FFMPEG_LIBRARIES})
