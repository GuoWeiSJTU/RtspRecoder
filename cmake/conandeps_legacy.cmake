message(STATUS "Conan: Using CMakeDeps conandeps_legacy.cmake aggregator via include()")
message(STATUS "Conan: It is recommended to use explicit find_package() per dependency instead")

find_package(asio)
find_package(ffmpeg)
find_package(yaml-cpp)
find_package(fmt)

set(CONANDEPS_LEGACY  asio::asio  ffmpeg::ffmpeg  yaml-cpp::yaml-cpp  fmt::fmt )