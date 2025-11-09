#!/bin/bash

# StreamRecorder 环境设置脚本
# 该脚本将 ~/.local/bin 添加到 PATH 环境变量中

echo "========================================"
echo "   StreamRecorder 环境设置脚本"
echo "========================================"

# 检查 ~/.local/bin 是否存在
if [ -d "$HOME/.local/bin" ]; then
    # 检查 ~/.local/bin 是否已经在 PATH 中
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        # 将 ~/.local/bin 添加到 PATH 开头（更高优先级）
        export PATH="$HOME/.local/bin:$PATH"
        echo "已将 ~/.local/bin 添加到 PATH"
    else
        echo "~/.local/bin 已经在 PATH 中"
    fi
else
    echo "警告: ~/.local/bin 目录不存在"
fi

# 将配置添加到 ~/.bashrc 以便永久生效
if [ -f "$HOME/.bashrc" ]; then
    # 检查是否已经添加过
    if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        echo "已将路径添加到 ~/.bashrc"
    else
        echo "路径已存在于 ~/.bashrc 中"
    fi
else
    echo "警告: ~/.bashrc 文件不存在"
fi

# 可选：添加到 ~/.profile
if [ -f "$HOME/.profile" ]; then
    if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.profile"; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.profile"
        echo "已将路径添加到 ~/.profile"
    else
        echo "路径已存在于 ~/.profile 中"
    fi
fi

echo ""
echo "环境配置完成！"
echo ""
echo "请运行以下命令或重新打开终端以使更改生效:"
echo "  source ~/.bashrc"
echo ""
echo "或者注销并重新登录系统"