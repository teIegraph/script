#!/bin/bash

# 目标目录
TARGET_DIR="/opt/nezha/agent2/"

# 下载链接
DOWNLOAD_URL="https://github.com/nezhahq/agent/releases/download/v0.16.5/nezha-agent_linux_amd64.zip"

# 临时下载文件的名称
TEMP_ZIP="nezha-agent.zip"

# 确保目标目录存在
mkdir -p "$TARGET_DIR"

# 进入目标目录
cd "$TARGET_DIR" || exit

# 检查并安装 unzip
if ! command -v unzip &> /dev/null; then
    echo "unzip 未安装，正在尝试安装..."
    sudo apt install unzip -y

    if [ $? -ne 0 ]; then
        echo "安装 unzip 失败，请手动安装后再运行此脚本。"
        exit 1
    fi
fi

# 下载文件
echo "正在下载文件..."
wget -O "$TEMP_ZIP" "$DOWNLOAD_URL"

# 检查文件是否下载成功
if [ ! -f "$TEMP_ZIP" ]; then
    echo "文件下载失败，请检查下载链接或网络连接。"
    exit 1
fi

# 解压文件
echo "正在解压文件..."
if ! unzip -o "$TEMP_ZIP"; then
    echo "解压失败，请确保 unzip 命令已安装。"
    exit 1
fi

# 删除临时zip文件
rm "$TEMP_ZIP"

# 给解压出来的所有文件赋予执行权限
chmod +x *

echo "操作完成。"
