# 构建说明

本文档详细说明了如何构建和配置 StreamRecorder 项目。

## 目录结构

项目采用模块化结构组织，主要目录包括：

- `src/` - 主程序源代码
  - `core/` - 核心模块（主程序入口、配置管理、录制控制等）
  - `storage/` - 存储相关模块
  - `media/` - 媒体处理模块（预留）
  - `api/` - 接口服务模块（预留）
  - `utils/` - 工具模块（预留）
- `plugins/` - 协议插件源代码
  - `rtsp/` - RTSP协议插件
  - `rtmp/` - RTMP协议插件（预留）
  - `srt/` - SRT协议插件（预留）
- `include/` - 头文件
- `config/` - 配置文件
- `scripts/` - 构建和配置脚本
- `docs/` - 项目文档
- `tests/` - 测试代码
- `build/` - 构建输出目录

## 环境要求

- 操作系统: Linux (Ubuntu 18.04+/CentOS 7+) 或 macOS 10.15+
- 编译器: 支持 C++17 的编译器 (GCC 7+/Clang 5+)
- 构建工具: CMake 3.15+
- 依赖管理: Conan 包管理器

## 依赖安装

项目使用 Conan 进行依赖管理，依赖项包括：

- asio/1.28.1
- ffmpeg/6.1
- yaml-cpp/0.8.0
- fmt/10.1.1

### 安装 Conan

```bash
pip install conan
```

### 配置 Conan

```bash
conan profile detect --force
```

### 安装依赖

```bash
mkdir build && cd build
conan install .. --build=missing -c tools.system.package_manager:mode=install
```

注意：如果遇到权限问题，可能需要使用 sudo 运行：
```bash
sudo conan install .. --build=missing -c tools.system.package_manager:mode=install
```

## 构建项目

在项目根目录执行以下命令：

```bash
mkdir build && cd build
conan install .. --build=missing
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j$(nproc)
```

构建完成后，将在 `build/` 目录下生成以下文件：
- `RtspRecorder`: 主程序可执行文件
- `librtsp_source.so`: RTSP协议插件（Linux）

## 运行程序

构建完成后，可以运行程序：

```bash
./RtspRecorder
```

## 安装

安装程序和插件到系统目录：

```bash
make install
```

或者指定安装前缀：

```bash
make install DESTDIR=/usr/local
```

## 使用脚本构建

项目提供了一键构建脚本：

```bash
./scripts/build.sh
```

该脚本会自动处理依赖安装和项目构建。

## 配置文件

程序使用 YAML 格式的配置文件，位于 `config/config.yaml`。可以根据需要修改配置参数。

## 插件

项目支持动态加载协议插件。目前实现了 RTSP 协议插件，后续可以扩展支持 RTMP、HLS、SRT 等协议。

插件编译后会生成动态链接库文件（如 `librtsp_source.so`），程序运行时会自动加载这些插件。