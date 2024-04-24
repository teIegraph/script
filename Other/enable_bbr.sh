#!/bin/bash

# 检查是否为 root 用户
if [ "$(id -u)" != "0" ]; then
   echo "该脚本必须以 root 权限运行" 1>&2
   exit 1
fi

# 更新系统
echo "正在更新系统..."
apt update && apt upgrade -y

# 安装 wget 和 curl
echo "正在安装 wget 和 curl..."
apt install wget curl -y

# 开启 BBR
echo "正在开启 BBR..."
echo 'net.core.default_qdisc=fq' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_congestion_control=bbr' >> /etc/sysctl.conf
sysctl -p

echo "BBR 开启成功。"

# 检查 BBR 状态
echo "检查 BBR 状态..."
sysctl net.ipv4.tcp_congestion_control

# 提醒用户可能需要重启
echo "为了使 BBR 更改生效，可能需要重启系统。"
