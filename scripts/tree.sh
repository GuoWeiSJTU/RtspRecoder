#!/bin/bash

# 项目目录结构可视化脚本

echo "StreamRecorder 项目结构"
echo "========================"
echo ""
echo "根目录:"
tree -I 'build*|*.cmake|*.md|scripts|conanfile*|*.json|*.txt' --dirsfirst -a -L 2 .
echo ""
echo "构建输出目录:"
tree build -L 2
echo ""
echo "源代码结构:"
echo "src/"
tree src -L 1
echo ""
echo "插件代码结构:"
echo "plugins/"
tree plugins -L 1
echo ""
echo "头文件结构:"
echo "include/"
tree include -L 1
echo ""
echo "脚本目录:"
echo "scripts/"
tree scripts -L 1