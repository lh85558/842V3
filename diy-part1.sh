#!/bin/bash
#=================================================
# OpenWrt 21.02 自定义配置脚本 Part 1
#=================================================

echo "================================"
echo "开始执行自定义配置 Part 1"
echo "================================"

# 添加CUPS打印服务支持
if ! grep -q "openwrt-cups" feeds.conf.default; then
    echo "添加CUPS软件源..."
    echo "src-git cups https://github.com/neheb/openwrt-cups.git" >> feeds.conf.default
fi

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
