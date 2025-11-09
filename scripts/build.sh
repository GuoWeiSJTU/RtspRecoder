#!/bin/bash

# StreamRecorder 一键编译脚本
# 该脚本使用 Conan 管理依赖项并自动构建项目

# 默认参数
BUILD_TYPE=${BUILD_TYPE:-Release}
CLEAN_BUILD=${CLEAN_BUILD:-false}
PARALLEL_JOBS=${PARALLEL_JOBS:-$(nproc)}

# 解析命令行参数
while [[ $# -gt 0 ]]; do
    case $1 in
        --clean|-c)
            CLEAN_BUILD=true
            shift
            ;;
        --debug|-d)
            BUILD_TYPE=Debug
            shift
            ;;
        --release|-r)
            BUILD_TYPE=Release
            shift
            ;;
        --jobs|-j)
            PARALLEL_JOBS="$2"
            shift 2
            ;;
        --help|-h)
            echo "用法: $0 [选项]"
            echo "选项:"
            echo "  -c, --clean     清理构建目录后重新构建"
            echo "  -d, --debug     构建Debug版本"
            echo "  -r, --release   构建Release版本 (默认)"
            echo "  -j, --jobs N    并行构建的任务数 (默认: CPU核心数)"
            echo "  -h, --help      显示帮助信息"
            exit 0
            ;;
        *)
            echo "未知选项: $1"
            echo "使用 $0 --help 查看可用选项"
            exit 1
            ;;
    esac
done

set -e  # 遇到错误时停止执行

echo "========================================"
echo "   StreamRecorder 一键编译脚本"
echo "========================================"
echo "构建类型: $BUILD_TYPE"
echo "并行任务数: $PARALLEL_JOBS"
echo "清理构建: $CLEAN_BUILD"

# 如果需要清理，则删除旧的构建目录
if [[ "$CLEAN_BUILD" == true ]]; then
    echo "清理旧的构建目录..."
    rm -rf build
fi

# 创建cmake目录用于存放.cmake文件（如果不存在）
echo "创建 cmake 目录..."
mkdir -p cmake

# 整理已有的CMake配置文件
echo "整理已有的 CMake 配置文件..."
# 使用find命令查找所有.cmake文件并移动到cmake目录（除了conan_toolchain.cmake）
find . -maxdepth 1 -name "*.cmake" -not -name "conan_toolchain.cmake" -exec mv {} cmake/ \; 2>/dev/null || true

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

# 创建构建目录
echo "创建构建目录..."
mkdir -p build

# 安装依赖项 (Conan v2 语法)
echo "安装依赖项..."
conan install . --build=missing \
    -c tools.system.package_manager:mode=install \
    -c tools.system.package_manager:sudo=True \
    -s build_type=$BUILD_TYPE

# 再次整理新生成的CMake配置文件
echo "整理新生成的 CMake 配置文件..."
find . -maxdepth 1 -name "*.cmake" -not -name "conan_toolchain.cmake" -exec mv {} cmake/ \; 2>/dev/null || true

# 进入构建目录
cd build

# 配置项目
echo "配置项目..."
cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=$BUILD_TYPE

# 编译项目
echo "构建项目..."
cmake --build . --parallel $PARALLEL_JOBS

# 构建完成后再次整理（以防万一）
echo "最后整理 CMake 配置文件..."
cd ..
find . -maxdepth 1 -name "*.cmake" -not -name "conan_toolchain.cmake" -exec mv {} cmake/ \; 2>/dev/null || true

echo "========================================"
echo "编译完成!"
echo "构建类型: $BUILD_TYPE"
echo "可执行文件位置: build/stream_recorder"
echo "插件位置: build/librtsp_source.so"
echo "========================================"