MACRO(setup_boost major_version minor_version modules)

  SET(BOOST_DIR ${CMAKE_SOURCE_DIR}/../boost_${major_version}_${minor_version}_0 )

  # MacOSX Setup
  IF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    SET(Boost_INCLUDE_DIR ${BOOST_DIR}  )  
    SET(Boost_LIBRARY_DIR ${BOOST_DIR}/stage/lib) 
  ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin") 

  # Linux Setup
  IF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    SET(Boost_INCLUDE_DIR ${BOOST_DIR}  ) 
    SET(Boost_LIBRARY_DIR ${BOOST_DIR}/stage/lib)  
  ENDIF(${CMAKE_SYSTEM_NAME} MATCHES "Linux")

  set(Boost_USE_STATIC_LIBS ON)
  find_package(Boost ${major_version}.${minor_version} COMPONENTS ${modules} REQUIRED)

  # Add Boost Include and Link directories
  IF (Boost_FOUND)
    include_directories(${Boost_INCLUDE_DIR})
    link_directories(${Boost_LIBRARY_DIR})
    ADD_DEFINITIONS( "-DHAS_BOOST" )
    # Qt Fix on Ubuntu 12.04 / osx works fine with it as well
    ADD_DEFINITIONS( "-DBOOST_TT_HAS_OPERATOR_HPP_INCLUDED")
    ADD_DEFINITIONS( "-DBOOST_PP_VARIADICS " ) 
  ENDIF()
ENDMACRO(setup_boost major_version minor_version)


