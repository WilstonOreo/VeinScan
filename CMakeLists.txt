# cmake requirements
CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

# project id
PROJECT(VeinScan)

include(./cmake-files/base.cmake)

import(
  compiler_flags
  OpenCV
)

INCLUDE_DIRECTORIES(./include )

common_cxx_flags()


setup_opencv()

add_executable(veinscan veinscan.cpp)
target_link_libraries(veinscan ${OPENCV_core_LIB}
    ${OPENCV_imgcodecs_LIB}
    ${OPENCV_hal_LIB} ${OPENCV_imgproc_LIB})
