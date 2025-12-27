#!/bin/bash
#=================================================
# 自定义配置
#=================================================

# 修改默认IP
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 修改主机名
sed -i 's/OpenWrt/THDN-PrintServer/g' package/base-files/files/bin/config_generate

# 修改时区
sed -i "s/'UTC'/'CST-8'\n        set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

# 修改默认WiFi名称
sed -i 's/OpenWrt/THDN-dayin/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 设置密码为 thdn12345678
sed -i 's/root::0:0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/g' package/base-files/files/etc/shadow

# 删除默认密码
# sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/lean/default-settings/files/zzz-default-settings

# 添加自定义软件包
cat >> .config <<EOF
# 基础系统
CONFIG_TARGET_ar71xx=y
CONFIG_TARGET_ar71xx_generic=y
CONFIG_TARGET_ar71xx_generic_DEVICE_tl-wr842n-v3=y

# LUCI界面
CONFIG_PACKAGE_luci=y
CONFIG_PACKAGE_luci-ssl=y
CONFIG_LUCI_LANG_zh_Hans=y
CONFIG_PACKAGE_luci-theme-bootstrap=y

# USB支持
CONFIG_PACKAGE_kmod-usb-core=y
CONFIG_PACKAGE_kmod-usb-ohci=y
CONFIG_PACKAGE_kmod-usb-uhci=y
CONFIG_PACKAGE_kmod-usb2=y
CONFIG_PACKAGE_kmod-usb-printer=y

# 打印服务
CONFIG_PACKAGE_cups=y
CONFIG_PACKAGE_cups-client=y
CONFIG_PACKAGE_cups-bjnp=y
CONFIG_PACKAGE_luci-app-cups=y

# HP打印机驱动
CONFIG_PACKAGE_ghostscript=y
CONFIG_PACKAGE_ghostscript-fonts-std=y
CONFIG_PACKAGE_hplip-common=y
CONFIG_PACKAGE_hplip-full=y

# 网络打印协议
CONFIG_PACKAGE_p910nd=y
CONFIG_PACKAGE_luci-app-p910nd=y

# Samba共享（可选）
CONFIG_PACKAGE_samba4-server=y
CONFIG_PACKAGE_luci-app-samba4=y

# 定时任务
CONFIG_PACKAGE_luci-app-autoreboot=y

# 无线驱动
CONFIG_PACKAGE_kmod-ath=y
CONFIG_PACKAGE_kmod-ath9k=y
CONFIG_PACKAGE_kmod-ath9k-common=y
CONFIG_PACKAGE_ATH_USER_REGD=y

# 工具软件
CONFIG_PACKAGE_wget=y
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_iperf3=y

# 中文字体支持
CONFIG_PACKAGE_fonts-chinese=y

# 移除不需要的包
# CONFIG_PACKAGE_luci-app-adbyby-plus is not set
# CONFIG_PACKAGE_luci-app-ssr-plus is not set
# CONFIG_PACKAGE_luci-app-vsftpd is not set
# CONFIG_PACKAGE_luci-app-vlmcsd is not set
# CONFIG_PACKAGE_luci-app-wol is not set

EOF

echo "配置完成！"
