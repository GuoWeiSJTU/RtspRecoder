cmake_minimum_required(VERSION 3.15)
project(StreamRecorder)

set(CMAKE_CXX_STANDARD 17)

# 设置 Conan 工具链路径
set(CONAN_TOOLCHAIN_FILE "${CMAKE_CURRENT_SOURCE_DIR}/cmake/conan_toolchain.cmake")
if(EXISTS ${CONAN_TOOLCHAIN_FILE})
    include(${CONAN_TOOLCHAIN_FILE})
endif()

find_package(asio REQUIRED)
find_package(fmt REQUIRED)
find_package(ffmpeg REQUIRED)

include_directories(include)

# 主程序
add_executable(stream_recorder src/main.cpp)
target_link_libraries(stream_recorder asio::asio fmt::fmt ffmpeg::ffmpeg)

# 插件
add_library(rtsp_source_plugin SHARED plugins/rtsp_source.cpp)
target_link_libraries(rtsp_source_plugin asio::asio ffmpeg::ffmpeg)
target_include_directories(rtsp_source_plugin PUBLIC include)

# 设置输出目录
set_target_properties(stream_recorder PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set_target_properties(rtsp_source_plugin PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# 创建必要的目录
file(MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/src)
file(MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include)
file(MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/plugins)
file(MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/config)
file(MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/tests)