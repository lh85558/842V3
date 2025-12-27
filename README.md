# TP842N v3 打印服务器固件

基于OpenWrt/LEDE的TP-Link TL-WR842N v3路由器打印服务器固件。

## 🎯 固件特性

- **芯片支持**: QCA9563 (TP-Link TL-WR842N v3)
- **固件大小**: < 16MB
- **打印服务**: CUPS 2.4.2 中文版
- **预装驱动**: HP LaserJet 1020/1020plus/1007/1008/1108
- **功能支持**:
  - ✅ USB打印机支持
  - ✅ 网络打印机支持
  - ✅ 远程IPP打印
  - ✅ 定时重启功能
  - ✅ AP无线模式
  - ✅ 中文管理界面

## 📋 默认配置

### 网络配置
- **LAN IP**: `192.168.10.1`
- **子网掩码**: `255.255.255.0`
- **DHCP**: 已启用

### 登录信息
- **Web地址**: http://192.168.10.1
- **用户名**: `admin`
- **密码**: `thdn12345678`

### WiFi配置
- **SSID**: `THDN-dayin`
- **密码**: `thdn12345678`
- **频道**: 6 (2.4GHz)
- **加密**: WPA2-PSK

### 系统信息
- **主机名**: `THDN-PrintServer`
- **时区**: Asia/Shanghai (UTC+8)
- **NTP服务器**: 阿里云、腾讯云

## 🚀 编译说明

### 方法一：GitHub Actions云编译（推荐）

1. Fork本项目到你的GitHub账号
2. 进入你的仓库，点击 `Actions` 标签
3. 选择 `编译TP842N-v3打印服务器固件` 工作流
4. 点击 `Run workflow` 按钮
5. 等待编译完成（约1-2小时）
6. 在 `Releases` 页面下载编译好的固件

### 方法二：本地编译

```bash
# 安装依赖（Ubuntu/Debian）
sudo apt-get update
sudo apt-get install -y build-essential gawk gcc-multilib flex git gettext libncurses5-dev libssl-dev \
python3-distutils zlib1g-dev

# 克隆LEDE源码
git clone https://github.com/coolsnowwolf/lede openwrt
cd openwrt

# 复制配置文件
cp /path/to/.config .config
cp /path/to/files ./files -r

# 更新feeds
./scripts/feeds update -a
./scripts/feeds install -a

# 下载依赖
make download -j8

# 开始编译
make -j$(nproc) || make -j1 V=s

# 固件位置
# openwrt/bin/targets/ar71xx/generic/
```

## 📦 安装固件

### 首次刷入

1. 下载编译好的固件文件（`openwrt-ar71xx-generic-tl-wr842n-v3-squashfs-sysupgrade.bin`）
2. 进入路由器原厂Web界面
3. 找到"固件升级"或"系统工具" -> "软件升级"
4. 选择下载的固件文件
5. 上传并等待刷机完成
6. 路由器自动重启

### 升级固件

1. 进入OpenWrt管理界面 http://192.168.10.1
2. 系统 -> 备份/升级
3. 上传新固件
4. 取消勾选"保留配置"（如需全新安装）
5. 刷写固件

## 🖨️ 打印机设置

### USB打印机设置

1. 将HP打印机通过USB连接到路由器
2. 系统会自动检测并配置打印机
3. 访问 http://192.168.10.1:631 进入CUPS管理界面
4. 验证打印机状态

### Windows客户端配置

1. 打开"控制面板" -> "设备和打印机"
2. 点击"添加打印机"
3. 选择"网络打印机"
4. 输入打印机URL: `http://192.168.10.1:631/printers/HP-LaserJet`
5. 选择对应的打印机驱动
6. 完成添加

### macOS客户端配置

1. 系统偏好设置 -> 打印机与扫描仪
2. 点击"+"添加打印机
3. 选择"IP"标签
4. 地址: `192.168.10.1`
5. 协议: IPP
6. 队列: `printers/HP-LaserJet`
7. 添加打印机

### Linux客户端配置

```bash
# 使用命令行添加
lpadmin -p HP-LaserJet -E -v ipp://192.168.10.1:631/printers/HP-LaserJet -m everywhere

# 或通过CUPS Web界面
firefox http://localhost:631
```

## ⚙️ 高级配置

### 定时重启

1. 进入 系统 -> 计划任务 -> 定时重启
2. 设置重启时间（默认每天凌晨4点）
3. 启用定时重启

### AP模式切换

固件默认运行在AP模式，WiFi已启用。如需禁用WiFi：

```bash
# SSH登录路由器
ssh root@192.168.10.1

# 禁用WiFi
uci set wireless.radio0.disabled='1'
uci commit wireless
wifi
```

### 修改密码

```bash
# SSH登录后执行
passwd
```

### 防火墙设置

CUPS端口631默认已开放，如需限制访问：

```bash
# 仅允许LAN访问
iptables -I INPUT -i br-lan -p tcp --dport 631 -j ACCEPT
iptables -I INPUT -p tcp --dport 631 -j DROP
```

## 🔧 故障排除

### 打印机无法识别

```bash
# 检查USB设备
lsusb

# 检查CUPS状态
/etc/init.d/cupsd status

# 重启CUPS服务
/etc/init.d/cupsd restart

# 查看打印机列表
lpstat -p -d
```

### 无法访问CUPS界面

```bash
# 检查CUPS进程
ps | grep cupsd

# 检查端口监听
netstat -tuln | grep 631

# 查看CUPS日志
cat /var/log/cups/error_log
```

### 打印作业卡住

```bash
# 取消所有打印任务
cancel -a

# 清除打印队列
lprm -
```

## 📚 技术支持

### 系统信息
- OpenWrt/LEDE 版本: 基于Lean源码
- 内核版本: Linux 4.14.x
- CUPS版本: 2.4.2
- 架构: mips_24kc

### 日志位置
- 系统日志: `/var/log/messages`
- CUPS日志: `/var/log/cups/`
- 内核日志: `dmesg`

### 相关链接
- [OpenWrt官网](https://openwrt.org/)
- [LEDE源码](https://github.com/coolsnowwolf/lede)
- [CUPS文档](https://www.cups.org/documentation.html)

## ⚠️ 注意事项

1. **备份设置**: 刷机前请备份重要配置
2. **断电保护**: 刷机过程中请勿断电
3. **固件选择**: 确认路由器型号为TL-WR842N v3
4. **容量限制**: 16MB Flash，请勿安装过多插件
5. **驱动兼容**: 目前支持HP LaserJet系列，其他品牌请自行添加驱动

## 📄 许可证

本项目基于 GPL-2.0 许可证开源。

## 🙏 致谢

- [Lean's LEDE](https://github.com/coolsnowwolf/lede)
- [OpenWrt Project](https://openwrt.org/)
- [CUPS Project](https://www.cups.org/)
- [HPLIP](https://developers.hp.com/hp-linux-imaging-and-printing)

---

**编译时间**: 自动生成  
**固件版本**: 基于最新LEDE源码
