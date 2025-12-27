#!/bin/bash
#=================================================
# OpenWrt 21.02 自定义配置脚本 Part 2
#=================================================

echo "================================"
echo "开始执行自定义配置 Part 2"
echo "================================"

# 修改默认IP为 192.168.10.1
echo "修改默认IP地址..."
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改主机名为 THDN-PrintServer
echo "修改主机名..."
sed -i 's/OpenWrt/THDN-PrintServer/g' package/base-files/files/bin/config_generate

# 修改时区为中国上海
echo "修改时区..."
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

# 修改默认WiFi SSID为 THDN-dayin
echo "修改WiFi SSID..."
sed -i 's/OpenWrt/THDN-dayin/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 设置root密码为 thdn12345678（密码hash）
echo "设置root密码..."
# 密码hash: thdn12345678
sed -i 's/root::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:/g' package/base-files/files/etc/shadow

# 允许root用户SSH登录
echo "配置SSH..."
sed -i '/PermitRootLogin/d' package/network/services/dropbear/files/dropbear.config
sed -i '/RootPasswordAuth/d' package/network/services/dropbear/files/dropbear.config

# 修改banner
echo "修改系统Banner..."
cat > package/base-files/files/etc/banner <<EOF
  _____   _   _   ____    _   _           ____    ____   ___ 
 |_   _| | | | | |  _ \  | \ | |         |  _ \  / ___| |__ \\
   | |   | |_| | | | | | |  \| |  _____  | |_) | \___ \   / /
   | |   |  _  | | |_| | | |\  | |_____| |  __/   ___) | |_| 
   |_|   |_| |_| |____/  |_| \_|         |_|     |____/  (_) 
                                                              
 -----------------------------------------------------
 TP842N v3 打印服务器固件 - OpenWrt 21.02
 CUPS 2.4.2 中文打印服务
 HP LaserJet 驱动预装
 -----------------------------------------------------
 默认IP: 192.168.10.1
 用户名: admin
 密码: thdn12345678
 WiFi: THDN-dayin / thdn12345678
 -----------------------------------------------------
EOF

echo "================================"
echo "Part 2 配置完成！"
echo "================================"

# 列出将要编译的目标
echo ""
echo "编译目标信息："
echo "- 芯片架构: ath79/generic"
echo "- 设备型号: TP-Link TL-WR842N v3"
echo "- OpenWrt版本: 21.02"
echo "- 打印服务: CUPS 2.4.2"
echo "- HP驱动: 1020/1020plus/1007/1008/1108"
echo ""
