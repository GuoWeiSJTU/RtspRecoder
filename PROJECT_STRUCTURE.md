# 项目结构说明

## 目录结构

```
.
├── BUILD_INSTRUCTIONS.md          # 构建说明文档
├── CMakeLists.txt                 # CMake 构建配置文件
├── PROJECT_STRUCTURE.md           # 项目结构说明（当前文件）
├── README.md                      # 项目介绍文档
├── conanfile.txt                  # Conan 依赖配置文件
├── config/                        # 配置文件目录
├── cmake/                         # CMake 配置文件目录
├── docs/                          # 项目文档目录
│   ├── 开发周计划.md               # 开发计划文档
│   ├── 设计需求.md                 # 项目需求分析文档
│   └── 软件设计.md                 # 软件设计文档
├── include/                       # 头文件目录
├── plugins/                       # 插件源码目录
├── src/                           # 主程序源码目录
├── scripts/                       # 脚本目录
├── tests/                         # 测试代码目录
└── build/                         # 构建输出目录
```

## 详细目录说明

### docs/ - 项目文档目录
包含项目相关的设计文档和计划文档：
- `开发周计划.md` - 开发计划文档
- `设计需求.md` - 项目需求分析文档
- `软件设计.md` - 软件设计文档

### include/ - 头文件目录
包含项目公共头文件：
- `media_source.h` - 媒体源接口定义
- `plugin_manager.h` - 插件管理器
- `recorder_controller.h` - 录制控制器
- `storage_manager.h` - 存储管理器

### src/ - 主程序源码目录
包含主程序源代码：
- `main.cpp` - 程序入口点

### plugins/ - 插件源码目录
包含插件实现：
- `rtsp_source.cpp` - RTSP 源插件实现

### cmake/ - CMake 配置文件目录
包含由 Conan 生成的所有 CMake 配置文件，用于依赖管理和构建配置：
- `*-config.cmake` - 各个依赖库的配置文件
- `*-targets.cmake` - 各个依赖库的目标定义文件
- `*-release-x86_64-data.cmake` - 架构相关数据文件

### scripts/ - 脚本目录
包含项目相关的脚本文件：
- `build.sh` - 一键编译脚本
- `setup_env.sh` - 环境配置脚本
- `tree.sh` - 项目结构可视化脚本

### config/ - 配置文件目录
用于存放配置文件，目前为空，将在后续开发中使用。

### tests/ - 测试代码目录
用于存放测试代码，目前为空，将在后续开发中使用。

### build/ - 构建输出目录
编译后生成的文件存放在此目录中：
- `stream_recorder` - 主程序可执行文件
- `librtsp_source.so` - RTSP协议插件（Linux）或 rtsp_source.dll（Windows）

## 构建相关文件

### 构建脚本
- `scripts/build.sh` - 一键编译脚本，自动处理依赖安装和项目构建

### 依赖配置
- `conanfile.txt` - Conan 包管理器依赖配置文件

### CMake 配置
- `CMakeLists.txt` - CMake 构建配置文件
- `cmake/` - Conan 生成的 CMake 配置文件目录