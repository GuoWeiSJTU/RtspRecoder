# StreamRecorder 项目结构说明

本文档描述了 StreamRecorder 项目的目录结构和文件组织方式。

## 目录结构

```
.
├── BUILD_INSTRUCTIONS.md          # 构建说明文档
├── CMakeLists.txt                 # CMake 构建配置文件
├── PROJECT_STRUCTURE.md           # 项目结构说明
├── conanfile.txt                  # Conan 依赖配置文件
├── config/                        # 配置文件目录
│   └── config.yaml                # 示例配置文件
├── cmake/                         # CMake 配置文件目录
├── docs/                          # 项目文档目录
│   ├── 开发周计划.md               # 开发计划文档
│   ├── 设计需求.md                 # 项目需求分析文档
│   └── 软件设计.md                 # 软件设计文档
├── include/                       # 头文件目录
│   ├── config_manager.h           # 配置管理器头文件
│   ├── media_source.h             # 媒体源接口定义
│   ├── plugin_manager.h           # 插件管理器接口定义
│   ├── recorder_controller.h      # 录制控制器接口定义
│   └── storage_manager.h          # 存储管理器接口定义
├── plugins/                       # 插件源码目录
│   ├── rtsp/                      # RTSP协议插件
│   │   └── rtsp_source.cpp        # RTSP协议插件实现
│   ├── rtmp/                      # RTMP协议插件（预留）
│   └── srt/                       # SRT协议插件（预留）
├── src/                           # 源代码目录
│   ├── core/                      # 核心模块
│   │   ├── main.cpp               # 主程序入口
│   │   ├── config_manager.cpp     # 配置管理器实现
│   │   └── recorder_controller.cpp # 录制控制器实现
│   ├── storage/                   # 存储模块
│   │   └── local_storage.cpp      # 本地存储后端实现
│   ├── media/                     # 媒体处理模块（预留）
│   ├── api/                       # 接口服务模块（预留）
│   └── utils/                     # 工具模块（预留）
├── scripts/                       # 脚本目录
├── tests/                         # 测试代码目录
└── build/                         # 构建输出目录
```

## 核心组件说明

### 主程序 (src/core/main.cpp)
程序入口点，负责初始化系统组件和启动录制任务。

### 插件系统 (plugins/)
支持动态加载的协议插件，当前包含RTSP协议插件。

### 核心模块 (src/core/)

#### 媒体源接口 (include/media_source.h)
定义了媒体源的通用接口，所有协议插件都需要实现该接口。

#### 插件管理器 (include/plugin_manager.h)
负责插件的加载、卸载和实例化。

#### 配置管理器 (include/config_manager.h, src/core/config_manager.cpp)
负责解析和管理YAML格式的配置文件，支持配置热更新。

#### 录制控制器 (include/recorder_controller.h, src/core/recorder_controller.cpp)
控制录制过程，包括开始、停止、暂停和恢复录制。

### 存储模块 (src/storage/)

#### 存储管理器 (include/storage_manager.h, src/storage/local_storage.cpp)
管理录制文件的存储，当前实现了本地文件系统存储后端。

## 构建输出

构建完成后，将在build目录下生成以下文件：
- RtspRecorder: 主程序可执行文件
- librtsp_source.so: RTSP协议插件（Linux）或 rtsp_source.dll（Windows）

## 构建相关文件

### 构建脚本
- `scripts/build.sh` - 一键编译脚本，自动处理依赖安装和项目构建

### 依赖配置
- `conanfile.txt` - Conan 包管理器依赖配置文件

### CMake 配置
- `CMakeLists.txt` - CMake 构建系统配置文件
- `cmake/` - Conan 生成的依赖配置文件目录

## 文档文件

- `BUILD_INSTRUCTIONS.md` - 详细的构建说明和环境配置指南
- `PROJECT_STRUCTURE.md` - 项目结构说明（当前文件）
- `docs/设计需求.md` - 项目需求分析文档
- `docs/软件设计.md` - 软件设计文档
- `docs/开发周计划.md` - 开发计划文档