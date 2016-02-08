
MACRO(set_version_string dir)
  SET(version_script "${dir}/generate-version.sh")
  IF(EXISTS "${version_script}")
    execute_process(COMMAND $ENV{SHELL} ${version_script}
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
        OUTPUT_VARIABLE BUILD_VERSION)
    STRING(STRIP "${BUILD_VERSION}" BUILD_VERSION)
    ADD_DEFINITIONS(-D__GITVERSIONSTRING__="${BUILD_VERSION}")
    MESSAGE(STATUS "Build version is ${BUILD_VERSION}")
  ENDIF(EXISTS "${version_script}")
ENDMACRO(set_version_string dir)

MACRO(common_cxx_flags)
  IF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
  # Set clang as standard compiler
  ADD_DEFINITIONS(-fPIC -fsigned-char -Wall -std=c++11 -Wno-missing-braces)

  ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")

  IF(${CMAKE_BUILD_TYPE} MATCHES "Debug")
    ADD_DEFINITIONS("-g -DDEBUG -O1")
  ENDIF(${CMAKE_BUILD_TYPE} MATCHES "Debug")

  IF(${CMAKE_BUILD_TYPE} MATCHES "Release")
    ADD_DEFINITIONS("-g -O3")
    IF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
        set(CMAKE_EXE_LINKER_FLAGS "-s")  ## Strip binary
    ENDIF()
  ENDIF(${CMAKE_BUILD_TYPE} MATCHES "Release")

  IF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    #ADD_DEFINITIONS(-g -Os -fsigned-char -Wall -fPIC)
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x -stdlib=libc++ -mmacosx-version-min=10.8 -arch x86_64 -Wno-unused-variable")
    SET(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -std=c++0x -stdlib=libc++ -mmacosx-version-min=10.8 -arch x86_64")
    SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wno-unused-variable -std=c++0x -stdlib=libc++ -mmacosx-version-min=10.8 -arch x86_64")
  ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")

  IF (${CMAKE_CXX_COMPILER_ID} MATCHES "Clang")
    ADD_DEFINITIONS(-ferror-limit=5 -fcolor-diagnostics -fdiagnostics-show-template-tree  -Wno-deprecated )
  ENDIF()
ENDMACRO(common_cxx_flags)
