cmake_minimum_required(VERSION 3.15)
project(RtspRecorder VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 设置默认构建类型为 Release
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# 根据构建类型设置编译器选项
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0 -Wall -Wextra")
    message(STATUS "构建类型: Debug")
else()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -DNDEBUG")
    message(STATUS "构建类型: Release")
endif()

message(STATUS "C++ 编译器标志: ${CMAKE_CXX_FLAGS}")

# Include Conan generated files (更好的方式是从构建目录包含)
include(${CMAKE_BINARY_DIR}/conan_toolchain.cmake OPTIONAL RESULT_VARIABLE conan_toolchain_loaded)
if(conan_toolchain_loaded)
    message(STATUS "Conan toolchain loaded successfully")
else()
    message(WARNING "Conan toolchain not found")
endif()

# Find required packages
find_package(asio REQUIRED)
find_package(ffmpeg REQUIRED)
find_package(yaml-cpp REQUIRED)
find_package(fmt REQUIRED)

# Include directories
include_directories(include)

# Source files
set(SOURCES
    src/core/main.cpp
    src/core/config_manager.cpp
    src/core/recorder_controller.cpp
    src/storage/local_storage.cpp
)

# Main executable
add_executable(${PROJECT_NAME} ${SOURCES})

# 设置输出名称
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "stream_recorder")

# Link libraries using modern CMake targets
target_link_libraries(${PROJECT_NAME} PRIVATE 
    asio::asio
    ffmpeg::ffmpeg
    yaml-cpp::yaml-cpp
    fmt::fmt
)

# Plugin targets
add_library(rtsp_source MODULE plugins/rtsp/rtsp_source.cpp)
target_link_libraries(rtsp_source PRIVATE 
    asio::asio
    ffmpeg::ffmpeg
)

# 设置插件属性
set_target_properties(rtsp_source PROPERTIES 
    PREFIX ""
    OUTPUT_NAME "rtsp_source"
)

# Additional plugins can be added here
# add_library(rtmp_source MODULE plugins/rtmp/rtmp_source.cpp)
# target_link_libraries(rtmp_source PRIVATE 
#     asio::asio
#     ffmpeg::ffmpeg
# )

# Install targets
install(TARGETS ${PROJECT_NAME} rtsp_source
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)

# Install headers
install(DIRECTORY include/ DESTINATION include/${PROJECT_NAME})

# Install config
install(DIRECTORY config/ DESTINATION config)

# Install docs
install(DIRECTORY docs/ DESTINATION share/doc/${PROJECT_NAME})