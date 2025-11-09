#!/bin/bash

# StreamRecorder 一键编译脚本
# 该脚本使用 Conan 管理依赖项并自动构建项目

set -e  # 遇到错误时停止执行

echo "========================================"
echo "   StreamRecorder 一键编译脚本"
echo "========================================"

echo "创建 cmake 目录..."
# 创建cmake目录用于存放.cmake文件（如果不存在）
mkdir -p cmake

# 移动所有.cmake文件到cmake目录
echo "整理 CMake 配置文件..."
mv *.cmake cmake/ 2>/dev/null || true

# 检查是否安装了 conan
if ! command -v conan &> /dev/null
then
    # 如果在 ~/.local/bin 中找到了 conan，则添加到 PATH
    if [ -f "$HOME/.local/bin/conan" ]; then
        export PATH="$HOME/.local/bin:$PATH"
        echo "已将 ~/.local/bin 添加到 PATH"
    else
        echo "错误: 未找到 conan 命令，请确保已安装 Conan 包管理器"
        exit 1
    fi
fi

echo "检查依赖项完成"

echo "创建构建目录..."
# 清理旧的构建目录
rm -rf build

# 创建构建目录
mkdir build

# 安装依赖项
echo "安装依赖项..."
conan install . --build=missing -c tools.system.package_manager:mode=install

# 再次整理新生成的.cmake文件
echo "再次整理新生成的 CMake 配置文件..."
mv *.cmake cmake/ 2>/dev/null || true

# 进入构建目录
cd build

# 配置项目
echo "配置项目..."
cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake/conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release

# 编译项目
echo "构建项目..."
cmake --build .

echo "========================================"
echo "编译完成!"
echo "可执行文件位置: build/bin/stream_recorder"
echo "插件位置: build/lib/rtsp_source_plugin.so"
echo "========================================"