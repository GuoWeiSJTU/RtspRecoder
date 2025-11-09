# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(libsvtav1_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(libsvtav1_FRAMEWORKS_FOUND_RELEASE "${libsvtav1_FRAMEWORKS_RELEASE}" "${libsvtav1_FRAMEWORK_DIRS_RELEASE}")

set(libsvtav1_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET libsvtav1_DEPS_TARGET)
    add_library(libsvtav1_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET libsvtav1_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${libsvtav1_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${libsvtav1_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:cpuinfo::cpuinfo>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### libsvtav1_DEPS_TARGET to all of them
conan_package_library_targets("${libsvtav1_LIBS_RELEASE}"    # libraries
                              "${libsvtav1_LIB_DIRS_RELEASE}" # package_libdir
                              "${libsvtav1_BIN_DIRS_RELEASE}" # package_bindir
                              "${libsvtav1_LIBRARY_TYPE_RELEASE}"
                              "${libsvtav1_IS_HOST_WINDOWS_RELEASE}"
                              libsvtav1_DEPS_TARGET
                              libsvtav1_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "libsvtav1"    # package_name
                              "${libsvtav1_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${libsvtav1_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Release ########################################

    ########## COMPONENT libsvtav1::decoder #############

        set(libsvtav1_libsvtav1_decoder_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(libsvtav1_libsvtav1_decoder_FRAMEWORKS_FOUND_RELEASE "${libsvtav1_libsvtav1_decoder_FRAMEWORKS_RELEASE}" "${libsvtav1_libsvtav1_decoder_FRAMEWORK_DIRS_RELEASE}")

        set(libsvtav1_libsvtav1_decoder_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET libsvtav1_libsvtav1_decoder_DEPS_TARGET)
            add_library(libsvtav1_libsvtav1_decoder_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET libsvtav1_libsvtav1_decoder_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_decoder_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_decoder_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_decoder_DEPENDENCIES_RELEASE}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'libsvtav1_libsvtav1_decoder_DEPS_TARGET' to all of them
        conan_package_library_targets("${libsvtav1_libsvtav1_decoder_LIBS_RELEASE}"
                              "${libsvtav1_libsvtav1_decoder_LIB_DIRS_RELEASE}"
                              "${libsvtav1_libsvtav1_decoder_BIN_DIRS_RELEASE}" # package_bindir
                              "${libsvtav1_libsvtav1_decoder_LIBRARY_TYPE_RELEASE}"
                              "${libsvtav1_libsvtav1_decoder_IS_HOST_WINDOWS_RELEASE}"
                              libsvtav1_libsvtav1_decoder_DEPS_TARGET
                              libsvtav1_libsvtav1_decoder_LIBRARIES_TARGETS
                              "_RELEASE"
                              "libsvtav1_libsvtav1_decoder"
                              "${libsvtav1_libsvtav1_decoder_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET libsvtav1::decoder
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_decoder_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_decoder_LIBRARIES_TARGETS}>
                     )

        if("${libsvtav1_libsvtav1_decoder_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET libsvtav1::decoder
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         libsvtav1_libsvtav1_decoder_DEPS_TARGET)
        endif()

        set_property(TARGET libsvtav1::decoder APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_decoder_LINKER_FLAGS_RELEASE}>)
        set_property(TARGET libsvtav1::decoder APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_decoder_INCLUDE_DIRS_RELEASE}>)
        set_property(TARGET libsvtav1::decoder APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_decoder_LIB_DIRS_RELEASE}>)
        set_property(TARGET libsvtav1::decoder APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_decoder_COMPILE_DEFINITIONS_RELEASE}>)
        set_property(TARGET libsvtav1::decoder APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_decoder_COMPILE_OPTIONS_RELEASE}>)


    ########## COMPONENT libsvtav1::encoder #############

        set(libsvtav1_libsvtav1_encoder_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(libsvtav1_libsvtav1_encoder_FRAMEWORKS_FOUND_RELEASE "${libsvtav1_libsvtav1_encoder_FRAMEWORKS_RELEASE}" "${libsvtav1_libsvtav1_encoder_FRAMEWORK_DIRS_RELEASE}")

        set(libsvtav1_libsvtav1_encoder_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET libsvtav1_libsvtav1_encoder_DEPS_TARGET)
            add_library(libsvtav1_libsvtav1_encoder_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET libsvtav1_libsvtav1_encoder_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_encoder_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_encoder_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_encoder_DEPENDENCIES_RELEASE}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'libsvtav1_libsvtav1_encoder_DEPS_TARGET' to all of them
        conan_package_library_targets("${libsvtav1_libsvtav1_encoder_LIBS_RELEASE}"
                              "${libsvtav1_libsvtav1_encoder_LIB_DIRS_RELEASE}"
                              "${libsvtav1_libsvtav1_encoder_BIN_DIRS_RELEASE}" # package_bindir
                              "${libsvtav1_libsvtav1_encoder_LIBRARY_TYPE_RELEASE}"
                              "${libsvtav1_libsvtav1_encoder_IS_HOST_WINDOWS_RELEASE}"
                              libsvtav1_libsvtav1_encoder_DEPS_TARGET
                              libsvtav1_libsvtav1_encoder_LIBRARIES_TARGETS
                              "_RELEASE"
                              "libsvtav1_libsvtav1_encoder"
                              "${libsvtav1_libsvtav1_encoder_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET libsvtav1::encoder
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_encoder_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_encoder_LIBRARIES_TARGETS}>
                     )

        if("${libsvtav1_libsvtav1_encoder_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET libsvtav1::encoder
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         libsvtav1_libsvtav1_encoder_DEPS_TARGET)
        endif()

        set_property(TARGET libsvtav1::encoder APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_encoder_LINKER_FLAGS_RELEASE}>)
        set_property(TARGET libsvtav1::encoder APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_encoder_INCLUDE_DIRS_RELEASE}>)
        set_property(TARGET libsvtav1::encoder APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_encoder_LIB_DIRS_RELEASE}>)
        set_property(TARGET libsvtav1::encoder APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_encoder_COMPILE_DEFINITIONS_RELEASE}>)
        set_property(TARGET libsvtav1::encoder APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${libsvtav1_libsvtav1_encoder_COMPILE_OPTIONS_RELEASE}>)


    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET libsvtav1::libsvtav1 APPEND PROPERTY INTERFACE_LINK_LIBRARIES libsvtav1::decoder)
    set_property(TARGET libsvtav1::libsvtav1 APPEND PROPERTY INTERFACE_LINK_LIBRARIES libsvtav1::encoder)

########## For the modules (FindXXX)
set(libsvtav1_LIBRARIES_RELEASE libsvtav1::libsvtav1)
