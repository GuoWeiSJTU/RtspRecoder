# Conan automatically generated toolchain file
# DO NOT EDIT MANUALLY, it will be overwritten

# Avoid including toolchain file several times (bad if appending to variables like
#   CMAKE_CXX_FLAGS. See https://github.com/android/ndk/issues/323
include_guard()
message(STATUS "Using Conan toolchain: ${CMAKE_CURRENT_LIST_FILE}")
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeToolchain' generator only works with CMake >= 3.15")
endif()

########## 'user_toolchain' block #############
# Include one or more CMake user toolchain from tools.cmake.cmaketoolchain:user_toolchain



########## 'generic_system' block #############
# Definition of system, platform and toolset





########## 'compilers' block #############



########## 'arch_flags' block #############
# Define C++ flags, C flags and linker flags from 'settings.arch'
message(STATUS "Conan toolchain: Defining architecture flag: -m64")
string(APPEND CONAN_CXX_FLAGS " -m64")
string(APPEND CONAN_C_FLAGS " -m64")
string(APPEND CONAN_SHARED_LINKER_FLAGS " -m64")
string(APPEND CONAN_EXE_LINKER_FLAGS " -m64")


########## 'libcxx' block #############
# Definition of libcxx from 'compiler.libcxx' setting, defining the
# right CXX_FLAGS for that libcxx



########## 'cppstd' block #############
# Define the C++ and C standards from 'compiler.cppstd' and 'compiler.cstd'

function(conan_modify_std_watch variable access value current_list_file stack)
    set(conan_watched_std_variable "17")
    if (${variable} STREQUAL "CMAKE_C_STANDARD")
        set(conan_watched_std_variable "")
    endif()
    if ("${access}" STREQUAL "MODIFIED_ACCESS" AND NOT "${value}" STREQUAL "${conan_watched_std_variable}")
        message(STATUS "Warning: Standard ${variable} value defined in conan_toolchain.cmake to ${conan_watched_std_variable} has been modified to ${value} by ${current_list_file}")
    endif()
    unset(conan_watched_std_variable)
endfunction()

message(STATUS "Conan toolchain: C++ Standard 17 with extensions ON")
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
variable_watch(CMAKE_CXX_STANDARD conan_modify_std_watch)


########## 'extra_flags' block #############
# Include extra C++, C and linker flags from configuration tools.build:<type>flags
# and from CMakeToolchain.extra_<type>_flags

# Conan conf flags start: 
# Conan conf flags end


########## 'cmake_flags_init' block #############
# Define CMAKE_<XXX>_FLAGS from CONAN_<XXX>_FLAGS

foreach(config IN LISTS CMAKE_CONFIGURATION_TYPES)
    string(TOUPPER ${config} config)
    if(DEFINED CONAN_CXX_FLAGS_${config})
      string(APPEND CMAKE_CXX_FLAGS_${config}_INIT " ${CONAN_CXX_FLAGS_${config}}")
    endif()
    if(DEFINED CONAN_C_FLAGS_${config})
      string(APPEND CMAKE_C_FLAGS_${config}_INIT " ${CONAN_C_FLAGS_${config}}")
    endif()
    if(DEFINED CONAN_SHARED_LINKER_FLAGS_${config})
      string(APPEND CMAKE_SHARED_LINKER_FLAGS_${config}_INIT " ${CONAN_SHARED_LINKER_FLAGS_${config}}")
    endif()
    if(DEFINED CONAN_EXE_LINKER_FLAGS_${config})
      string(APPEND CMAKE_EXE_LINKER_FLAGS_${config}_INIT " ${CONAN_EXE_LINKER_FLAGS_${config}}")
    endif()
endforeach()

if(DEFINED CONAN_CXX_FLAGS)
  string(APPEND CMAKE_CXX_FLAGS_INIT " ${CONAN_CXX_FLAGS}")
endif()
if(DEFINED CONAN_C_FLAGS)
  string(APPEND CMAKE_C_FLAGS_INIT " ${CONAN_C_FLAGS}")
endif()
if(DEFINED CONAN_SHARED_LINKER_FLAGS)
  string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT " ${CONAN_SHARED_LINKER_FLAGS}")
endif()
if(DEFINED CONAN_EXE_LINKER_FLAGS)
  string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " ${CONAN_EXE_LINKER_FLAGS}")
endif()
if(DEFINED CONAN_OBJCXX_FLAGS)
  string(APPEND CMAKE_OBJCXX_FLAGS_INIT " ${CONAN_OBJCXX_FLAGS}")
endif()
if(DEFINED CONAN_OBJC_FLAGS)
  string(APPEND CMAKE_OBJC_FLAGS_INIT " ${CONAN_OBJC_FLAGS}")
endif()


########## 'extra_variables' block #############
# Definition of extra CMake variables from tools.cmake.cmaketoolchain:extra_variables



########## 'try_compile' block #############
# Blocks after this one will not be added when running CMake try/checks
get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if(_CMAKE_IN_TRY_COMPILE)
    message(STATUS "Running toolchain IN_TRY_COMPILE")
    return()
endif()


########## 'find_paths' block #############
# Define paths to find packages, programs, libraries, etc.
if(EXISTS "${CMAKE_CURRENT_LIST_DIR}/conan_cmakedeps_paths.cmake")
  message(STATUS "Conan toolchain: Including CMakeDeps generated conan_cmakedeps_paths.cmake")
  include("${CMAKE_CURRENT_LIST_DIR}/conan_cmakedeps_paths.cmake")
else()

set(CMAKE_FIND_PACKAGE_PREFER_CONFIG ON)

# Definition of CMAKE_MODULE_PATH
list(PREPEND CMAKE_MODULE_PATH "/home/guo/.conan2/p/openj05fe213c4811c/p/lib/cmake" "/home/guo/.conan2/p/opens02e83d05658f2/p/lib/cmake")
# the generators folder (where conan generates files, like this toolchain)
list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})

# Definition of CMAKE_PREFIX_PATH, CMAKE_XXXXX_PATH
# The explicitly defined "builddirs" of "host" context dependencies must be in PREFIX_PATH
list(PREPEND CMAKE_PREFIX_PATH "/home/guo/.conan2/p/openj05fe213c4811c/p/lib/cmake" "/home/guo/.conan2/p/opens02e83d05658f2/p/lib/cmake")
# The Conan local "generators" folder, where this toolchain is saved.
list(PREPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_LIST_DIR} )
list(PREPEND CMAKE_LIBRARY_PATH "/home/guo/.conan2/p/b/ffmpe404910eea822f/p/lib" "/home/guo/.conan2/p/xz_ut2ae601f9ba306/p/lib" "/home/guo/.conan2/p/libicb495c962491c9/p/lib" "/home/guo/.conan2/p/freet8d4dbdbce7e87/p/lib" "/home/guo/.conan2/p/libpn7fe84e26a9a66/p/lib" "/home/guo/.conan2/p/bzip2fd1f92426ca0d/p/lib" "/home/guo/.conan2/p/brotlc71ee6fd63ef5/p/lib" "/home/guo/.conan2/p/openj05fe213c4811c/p/lib" "/home/guo/.conan2/p/openh500b6e0612535/p/lib" "/home/guo/.conan2/p/vorbi11a214e37eb91/p/lib" "/home/guo/.conan2/p/ogg6f2552d00aba9/p/lib" "/home/guo/.conan2/p/opusb7c394c9e37d6/p/lib" "/home/guo/.conan2/p/libx222f08f1c8ac5d/p/lib" "/home/guo/.conan2/p/libx2aa2157a095d93/p/lib" "/home/guo/.conan2/p/libvpf3e8e38e769d9/p/lib" "/home/guo/.conan2/p/libmp2f875eaa31ebd/p/lib" "/home/guo/.conan2/p/libfda45727e00efc6/p/lib" "/home/guo/.conan2/p/libwecd574512ed429/p/lib" "/home/guo/.conan2/p/opens02e83d05658f2/p/lib" "/home/guo/.conan2/p/zlib9780dc2008618/p/lib" "/home/guo/.conan2/p/libal0d970897e8a02/p/lib" "/home/guo/.conan2/p/libsvee9fcaa37689b/p/lib" "/home/guo/.conan2/p/cpuin9c4ab80d6e1fe/p/lib" "/home/guo/.conan2/p/libaoa01ed4c31f2ed/p/lib" "/home/guo/.conan2/p/dav1d5deaf7c3874fe/p/lib" "/home/guo/.conan2/p/yaml-8917f9ac57775/p/lib" "/home/guo/.conan2/p/fmt0c92ad97b75de/p/lib")
list(PREPEND CMAKE_INCLUDE_PATH "/home/guo/.conan2/p/asioe46abfff5a44a/p/include" "/home/guo/.conan2/p/b/ffmpe404910eea822f/p/include" "/home/guo/.conan2/p/xz_ut2ae601f9ba306/p/include" "/home/guo/.conan2/p/libicb495c962491c9/p/include" "/home/guo/.conan2/p/freet8d4dbdbce7e87/p/include" "/home/guo/.conan2/p/freet8d4dbdbce7e87/p/include/freetype2" "/home/guo/.conan2/p/libpn7fe84e26a9a66/p/include" "/home/guo/.conan2/p/bzip2fd1f92426ca0d/p/include" "/home/guo/.conan2/p/brotlc71ee6fd63ef5/p/include" "/home/guo/.conan2/p/openj05fe213c4811c/p/include" "/home/guo/.conan2/p/openj05fe213c4811c/p/include/openjpeg-2.5" "/home/guo/.conan2/p/openh500b6e0612535/p/include" "/home/guo/.conan2/p/vorbi11a214e37eb91/p/include" "/home/guo/.conan2/p/ogg6f2552d00aba9/p/include" "/home/guo/.conan2/p/opusb7c394c9e37d6/p/include" "/home/guo/.conan2/p/opusb7c394c9e37d6/p/include/opus" "/home/guo/.conan2/p/libx222f08f1c8ac5d/p/include" "/home/guo/.conan2/p/libx2aa2157a095d93/p/include" "/home/guo/.conan2/p/libvpf3e8e38e769d9/p/include" "/home/guo/.conan2/p/libmp2f875eaa31ebd/p/include" "/home/guo/.conan2/p/libfda45727e00efc6/p/include" "/home/guo/.conan2/p/libwecd574512ed429/p/include" "/home/guo/.conan2/p/opens02e83d05658f2/p/include" "/home/guo/.conan2/p/zlib9780dc2008618/p/include" "/home/guo/.conan2/p/libal0d970897e8a02/p/include" "/home/guo/.conan2/p/libsvee9fcaa37689b/p/include/svt-av1" "/home/guo/.conan2/p/cpuin9c4ab80d6e1fe/p/include" "/home/guo/.conan2/p/libaoa01ed4c31f2ed/p/include" "/home/guo/.conan2/p/dav1d5deaf7c3874fe/p/include" "/home/guo/.conan2/p/yaml-8917f9ac57775/p/include" "/home/guo/.conan2/p/fmt0c92ad97b75de/p/include")
set(CONAN_RUNTIME_LIB_DIRS "/home/guo/.conan2/p/b/ffmpe404910eea822f/p/lib" "/home/guo/.conan2/p/xz_ut2ae601f9ba306/p/lib" "/home/guo/.conan2/p/libicb495c962491c9/p/lib" "/home/guo/.conan2/p/freet8d4dbdbce7e87/p/lib" "/home/guo/.conan2/p/libpn7fe84e26a9a66/p/lib" "/home/guo/.conan2/p/bzip2fd1f92426ca0d/p/lib" "/home/guo/.conan2/p/brotlc71ee6fd63ef5/p/lib" "/home/guo/.conan2/p/openj05fe213c4811c/p/lib" "/home/guo/.conan2/p/openh500b6e0612535/p/lib" "/home/guo/.conan2/p/vorbi11a214e37eb91/p/lib" "/home/guo/.conan2/p/ogg6f2552d00aba9/p/lib" "/home/guo/.conan2/p/opusb7c394c9e37d6/p/lib" "/home/guo/.conan2/p/libx222f08f1c8ac5d/p/lib" "/home/guo/.conan2/p/libx2aa2157a095d93/p/lib" "/home/guo/.conan2/p/libvpf3e8e38e769d9/p/lib" "/home/guo/.conan2/p/libmp2f875eaa31ebd/p/lib" "/home/guo/.conan2/p/libfda45727e00efc6/p/lib" "/home/guo/.conan2/p/libwecd574512ed429/p/lib" "/home/guo/.conan2/p/opens02e83d05658f2/p/lib" "/home/guo/.conan2/p/zlib9780dc2008618/p/lib" "/home/guo/.conan2/p/libal0d970897e8a02/p/lib" "/home/guo/.conan2/p/libsvee9fcaa37689b/p/lib" "/home/guo/.conan2/p/cpuin9c4ab80d6e1fe/p/lib" "/home/guo/.conan2/p/libaoa01ed4c31f2ed/p/lib" "/home/guo/.conan2/p/dav1d5deaf7c3874fe/p/lib" "/home/guo/.conan2/p/yaml-8917f9ac57775/p/lib" "/home/guo/.conan2/p/fmt0c92ad97b75de/p/lib" )

endif()


########## 'pkg_config' block #############
# Define pkg-config from 'tools.gnu:pkg_config' executable and paths

if (DEFINED ENV{PKG_CONFIG_PATH})
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:$ENV{PKG_CONFIG_PATH}")
else()
set(ENV{PKG_CONFIG_PATH} "${CMAKE_CURRENT_LIST_DIR}:")
endif()


########## 'rpath' block #############
# Defining CMAKE_SKIP_RPATH



########## 'output_dirs' block #############
# Definition of CMAKE_INSTALL_XXX folders

set(CMAKE_INSTALL_BINDIR "bin")
set(CMAKE_INSTALL_SBINDIR "bin")
set(CMAKE_INSTALL_LIBEXECDIR "bin")
set(CMAKE_INSTALL_LIBDIR "lib")
set(CMAKE_INSTALL_INCLUDEDIR "include")
set(CMAKE_INSTALL_OLDINCLUDEDIR "include")


########## 'variables' block #############
# Definition of CMake variables from CMakeToolchain.variables values

# Variables
# Variables  per configuration



########## 'preprocessor' block #############
# Preprocessor definitions from CMakeToolchain.preprocessor_definitions values

# Preprocessor definitions per configuration



if(CMAKE_POLICY_DEFAULT_CMP0091)  # Avoid unused and not-initialized warnings
endif()
