# RtspRecorder

一个基于C++和FFmpeg的RTSP流录制工具，支持实时流媒体录制和存储管理。

## 项目简介

RtspRecorder是一个轻量级的流媒体录制工具，专注于从RTSP源捕获视频流并将其保存到本地存储。该项目采用模块化设计，支持插件化扩展，便于集成不同的媒体源和存储方案。

## 功能特点

- RTSP流媒体录制
- 插件化架构设计
- 支持多种视频格式
- 易于扩展的存储管理
- 跨平台构建支持

## 技术栈

- C++17
- FFmpeg (用于音视频处理)
- ASIO (用于异步网络操作)
- CMake (构建系统)
- Conan (依赖管理)

## 目录结构

```
.
├── BUILD_INSTRUCTIONS.md          # 构建说明文档
├── CMakeLists.txt                 # CMake 构建配置文件
├── PROJECT_STRUCTURE.md           # 项目结构说明
├── conanfile.txt                  # Conan 依赖配置文件
├── config/                        # 配置文件目录
├── cmake/                         # CMake 配置文件目录
├── include/                       # 头文件目录
├── plugins/                       # 插件源码目录
├── src/                           # 主程序源码目录
├── scripts/                       # 脚本目录
├── tests/                         # 测试代码目录
└── build/                         # 构建输出目录
```

## 构建说明

请参考 [BUILD_INSTRUCTIONS.md](BUILD_INSTRUCTIONS.md) 文件了解详细的构建步骤。

## 许可证

本项目采用 MIT 许可证，详情请见 [LICENSE](LICENSE) 文件。