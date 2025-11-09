########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

list(APPEND libsvtav1_COMPONENT_NAMES libsvtav1::encoder libsvtav1::decoder)
list(REMOVE_DUPLICATES libsvtav1_COMPONENT_NAMES)
if(DEFINED libsvtav1_FIND_DEPENDENCY_NAMES)
  list(APPEND libsvtav1_FIND_DEPENDENCY_NAMES cpuinfo)
  list(REMOVE_DUPLICATES libsvtav1_FIND_DEPENDENCY_NAMES)
else()
  set(libsvtav1_FIND_DEPENDENCY_NAMES cpuinfo)
endif()
set(cpuinfo_FIND_MODE "NO_MODULE")

########### VARIABLES #######################################################################
#############################################################################################
set(libsvtav1_PACKAGE_FOLDER_RELEASE "/home/guo/.conan2/p/libsvee9fcaa37689b/p")
set(libsvtav1_BUILD_MODULES_PATHS_RELEASE )


set(libsvtav1_INCLUDE_DIRS_RELEASE )
set(libsvtav1_RES_DIRS_RELEASE )
set(libsvtav1_DEFINITIONS_RELEASE )
set(libsvtav1_SHARED_LINK_FLAGS_RELEASE )
set(libsvtav1_EXE_LINK_FLAGS_RELEASE )
set(libsvtav1_OBJECTS_RELEASE )
set(libsvtav1_COMPILE_DEFINITIONS_RELEASE )
set(libsvtav1_COMPILE_OPTIONS_C_RELEASE )
set(libsvtav1_COMPILE_OPTIONS_CXX_RELEASE )
set(libsvtav1_LIB_DIRS_RELEASE "${libsvtav1_PACKAGE_FOLDER_RELEASE}/lib")
set(libsvtav1_BIN_DIRS_RELEASE )
set(libsvtav1_LIBRARY_TYPE_RELEASE STATIC)
set(libsvtav1_IS_HOST_WINDOWS_RELEASE 0)
set(libsvtav1_LIBS_RELEASE SvtAv1Dec SvtAv1Enc)
set(libsvtav1_SYSTEM_LIBS_RELEASE pthread dl m)
set(libsvtav1_FRAMEWORK_DIRS_RELEASE )
set(libsvtav1_FRAMEWORKS_RELEASE )
set(libsvtav1_BUILD_DIRS_RELEASE )
set(libsvtav1_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(libsvtav1_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${libsvtav1_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${libsvtav1_COMPILE_OPTIONS_C_RELEASE}>")
set(libsvtav1_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libsvtav1_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libsvtav1_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libsvtav1_EXE_LINK_FLAGS_RELEASE}>")


set(libsvtav1_COMPONENTS_RELEASE libsvtav1::encoder libsvtav1::decoder)
########### COMPONENT libsvtav1::decoder VARIABLES ############################################

set(libsvtav1_libsvtav1_decoder_INCLUDE_DIRS_RELEASE )
set(libsvtav1_libsvtav1_decoder_LIB_DIRS_RELEASE "${libsvtav1_PACKAGE_FOLDER_RELEASE}/lib")
set(libsvtav1_libsvtav1_decoder_BIN_DIRS_RELEASE )
set(libsvtav1_libsvtav1_decoder_LIBRARY_TYPE_RELEASE STATIC)
set(libsvtav1_libsvtav1_decoder_IS_HOST_WINDOWS_RELEASE 0)
set(libsvtav1_libsvtav1_decoder_RES_DIRS_RELEASE )
set(libsvtav1_libsvtav1_decoder_DEFINITIONS_RELEASE )
set(libsvtav1_libsvtav1_decoder_OBJECTS_RELEASE )
set(libsvtav1_libsvtav1_decoder_COMPILE_DEFINITIONS_RELEASE )
set(libsvtav1_libsvtav1_decoder_COMPILE_OPTIONS_C_RELEASE "")
set(libsvtav1_libsvtav1_decoder_COMPILE_OPTIONS_CXX_RELEASE "")
set(libsvtav1_libsvtav1_decoder_LIBS_RELEASE SvtAv1Dec)
set(libsvtav1_libsvtav1_decoder_SYSTEM_LIBS_RELEASE pthread dl m)
set(libsvtav1_libsvtav1_decoder_FRAMEWORK_DIRS_RELEASE )
set(libsvtav1_libsvtav1_decoder_FRAMEWORKS_RELEASE )
set(libsvtav1_libsvtav1_decoder_DEPENDENCIES_RELEASE cpuinfo::cpuinfo)
set(libsvtav1_libsvtav1_decoder_SHARED_LINK_FLAGS_RELEASE )
set(libsvtav1_libsvtav1_decoder_EXE_LINK_FLAGS_RELEASE )
set(libsvtav1_libsvtav1_decoder_NO_SONAME_MODE_RELEASE FALSE)

# COMPOUND VARIABLES
set(libsvtav1_libsvtav1_decoder_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libsvtav1_libsvtav1_decoder_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libsvtav1_libsvtav1_decoder_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libsvtav1_libsvtav1_decoder_EXE_LINK_FLAGS_RELEASE}>
)
set(libsvtav1_libsvtav1_decoder_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${libsvtav1_libsvtav1_decoder_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${libsvtav1_libsvtav1_decoder_COMPILE_OPTIONS_C_RELEASE}>")
########### COMPONENT libsvtav1::encoder VARIABLES ############################################

set(libsvtav1_libsvtav1_encoder_INCLUDE_DIRS_RELEASE )
set(libsvtav1_libsvtav1_encoder_LIB_DIRS_RELEASE "${libsvtav1_PACKAGE_FOLDER_RELEASE}/lib")
set(libsvtav1_libsvtav1_encoder_BIN_DIRS_RELEASE )
set(libsvtav1_libsvtav1_encoder_LIBRARY_TYPE_RELEASE STATIC)
set(libsvtav1_libsvtav1_encoder_IS_HOST_WINDOWS_RELEASE 0)
set(libsvtav1_libsvtav1_encoder_RES_DIRS_RELEASE )
set(libsvtav1_libsvtav1_encoder_DEFINITIONS_RELEASE )
set(libsvtav1_libsvtav1_encoder_OBJECTS_RELEASE )
set(libsvtav1_libsvtav1_encoder_COMPILE_DEFINITIONS_RELEASE )
set(libsvtav1_libsvtav1_encoder_COMPILE_OPTIONS_C_RELEASE "")
set(libsvtav1_libsvtav1_encoder_COMPILE_OPTIONS_CXX_RELEASE "")
set(libsvtav1_libsvtav1_encoder_LIBS_RELEASE SvtAv1Enc)
set(libsvtav1_libsvtav1_encoder_SYSTEM_LIBS_RELEASE pthread dl m)
set(libsvtav1_libsvtav1_encoder_FRAMEWORK_DIRS_RELEASE )
set(libsvtav1_libsvtav1_encoder_FRAMEWORKS_RELEASE )
set(libsvtav1_libsvtav1_encoder_DEPENDENCIES_RELEASE cpuinfo::cpuinfo)
set(libsvtav1_libsvtav1_encoder_SHARED_LINK_FLAGS_RELEASE )
set(libsvtav1_libsvtav1_encoder_EXE_LINK_FLAGS_RELEASE )
set(libsvtav1_libsvtav1_encoder_NO_SONAME_MODE_RELEASE FALSE)

# COMPOUND VARIABLES
set(libsvtav1_libsvtav1_encoder_LINKER_FLAGS_RELEASE
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${libsvtav1_libsvtav1_encoder_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${libsvtav1_libsvtav1_encoder_SHARED_LINK_FLAGS_RELEASE}>
        $<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${libsvtav1_libsvtav1_encoder_EXE_LINK_FLAGS_RELEASE}>
)
set(libsvtav1_libsvtav1_encoder_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${libsvtav1_libsvtav1_encoder_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${libsvtav1_libsvtav1_encoder_COMPILE_OPTIONS_C_RELEASE}>")