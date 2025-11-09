# Load the debug and release variables
file(GLOB DATA_FILES "${CMAKE_CURRENT_LIST_DIR}/libsvtav1-*-data.cmake")

foreach(f ${DATA_FILES})
    include(${f})
endforeach()

# Create the targets for all the components
foreach(_COMPONENT ${libsvtav1_COMPONENT_NAMES} )
    if(NOT TARGET ${_COMPONENT})
        add_library(${_COMPONENT} INTERFACE IMPORTED)
        message(${libsvtav1_MESSAGE_MODE} "Conan: Component target declared '${_COMPONENT}'")
    endif()
endforeach()

if(NOT TARGET libsvtav1::libsvtav1)
    add_library(libsvtav1::libsvtav1 INTERFACE IMPORTED)
    message(${libsvtav1_MESSAGE_MODE} "Conan: Target declared 'libsvtav1::libsvtav1'")
endif()
# Load the debug and release library finders
file(GLOB CONFIG_FILES "${CMAKE_CURRENT_LIST_DIR}/libsvtav1-Target-*.cmake")

foreach(f ${CONFIG_FILES})
    include(${f})
endforeach()