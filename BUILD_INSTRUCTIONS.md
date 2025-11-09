# StreamRecorder 构建说明

本文档详细说明了如何构建和编译 StreamRecorder 项目。

## 环境要求

- Ubuntu 22.04 或更高版本
- Conan 包管理器
- CMake 3.15 或更高版本
- GCC 9 或更高版本

## 环境配置

### 1. 添加 Conan 到 PATH

如果遇到 "WARNING: The script conan is installed in '/home/guo/.local/bin' which is not on PATH" 警告，需要将该目录添加到 PATH：

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

或者运行项目提供的环境配置脚本：

```bash
source ./scripts/setup_env.sh
```

### 2. 配置 Conan

首次构建项目前，需要配置 Conan：

```bash
conan profile detect
```

## 构建项目

### 方法一：使用一键构建脚本（推荐）

项目提供了一个一键构建脚本，可以自动完成依赖安装和项目构建：

```bash
./scripts/build.sh
```

构建完成后，可执行文件和插件将位于：
- 可执行文件: `build/bin/stream_recorder`
- 插件: `build/lib/librtsp_source_plugin.so`

### 方法二：手动构建

1. 安装依赖项：
```bash
conan install . --build=missing -c tools.system.package_manager:mode=install
```

2. 配置项目：
```bash
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake/conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
```

3. 编译项目：
```bash
cmake --build .
```

## 运行项目

构建完成后，可以运行录制程序：

```bash
./build/bin/stream_recorder
```

## 目录结构说明

- `src/` - 主程序源代码
- `include/` - 头文件
- `plugins/` - 插件源代码
- `build/` - 构建输出目录
- `cmake/` - CMake 配置文件
- `scripts/` - 构建和配置脚本
- `config/` - 配置文件
- `tests/` - 测试代码