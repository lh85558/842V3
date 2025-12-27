#!/bin/bash
#=================================================
# 添加额外的软件源和配置国内加速
#=================================================

# 使用国内镜像加速GitHub访问（可选）
# export GITHUB_PROXY="https://ghproxy.com/"

# 添加OpenClash的软件源（国内镜像）
# sed -i '$a src-git openclash https://gitee.com/vernesong/OpenClash.git' feeds.conf.default

# 添加CUPS打印服务支持
if ! grep -q "openwrt-cups" feeds.conf.default; then
    echo "src-git cups https://github.com/neheb/openwrt-cups.git" >> feeds.conf.default
fi

# 配置Git使用国内代理（如果需要）
# git config --global url."https://ghproxy.com/https://github.com".insteadOf "https://github.com"

# 更新feeds（添加超时和重试机制）
echo "开始更新feeds..."
./scripts/feeds update -a || {
    echo "feeds更新失败，尝试使用代理重试..."
    export GIT_HTTP_LOW_SPEED_LIMIT=1000
    export GIT_HTTP_LOW_SPEED_TIME=60
    ./scripts/feeds update -a
}

# 安装feeds
echo "开始安装feeds..."
./scripts/feeds install -a

echo "feeds配置完成！"
