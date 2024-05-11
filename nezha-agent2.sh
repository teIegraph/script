#!/bin/bash

# 定义要下载的文件的URL
FILE_URL="https://github.com/teIegraph/scripts/raw/main/nezha-agent2.service"

# 定义目标目录
DEST_DIR="/etc/systemd/system/"

# 使用wget下载文件到指定目录（需要安装wget，如果没有安装，可以使用apt install wget或yum install wget安装）
wget -P $DEST_DIR $FILE_URL

# 给下载的文件设置适当的权限
chmod 644 $DEST_DIR"nezha-agent2.service"

echo "文件已下载到 $DEST_DIR"
