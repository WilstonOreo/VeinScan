
MACRO(setup_opencv_module module_name)
    include_directories(${OPENCV_ROOT}/modules/${module_name}/include )
    set(OPENCV_${module_name}_LIB ${OPENCV_LIBRARY_PATH}/libopencv_${module_name}.dylib)

    if(${module_name} STREQUAL "hal")
        set(OPENCV_${module_name}_LIB ${OPENCV_LIBRARY_PATH}/libopencv_${module_name}.a)
    endif()
ENDMACRO()


MACRO(setup_opencv)
    IF(NOT DEFINED OPENCV_ROOT)
        SET(OPENCV_ROOT ${CMAKE_SOURCE_DIR}/../opencv-3.0.0)
    ENDIF()

    set(OPENCV_LIBRARY_PATH ${OPENCV_ROOT}/lib)
    set(OPENCV_INCLUDE_PATH ${OPENCV_ROOT}/include)
    link_directories(${OPENCV_LIBRARY_PATH})
    include_directories(${OPENCV_INCLUDE_PATH})

    setup_opencv_module(core)
    setup_opencv_module(hal)
    setup_opencv_module(imgcodecs)
    setup_opencv_module(imgproc)
    setup_opencv_module(photo)
ENDMACRO()
