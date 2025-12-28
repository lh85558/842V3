#!/bin/bash
#=================================================
# OpenWrt 21.02 自定义配置脚本 Part 1
#=================================================

echo "================================"
echo "开始执行自定义配置 Part 1"
echo "================================"

# CUPS已包含在官方packages源中，无需额外添加
echo "使用官方packages源中的CUPS..."

# 添加LuCI中文语言包支持
echo "配置LuCI中文支持..."

# 更新feeds
echo "开始更新feeds..."
./scripts/feeds update -a

# 安装所有feeds
echo "开始安装feeds..."
./scripts/feeds install -a

# 安装中文语言包
echo "安装中文语言包..."
./scripts/feeds install -a -p luci

echo "================================"
echo "Part 1 配置完成！"
echo "================================"
