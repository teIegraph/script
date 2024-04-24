#!/bin/bash

# 自动查找主要的网络接口（排除lo）
INTERFACE=$(ip -o link show | awk -F': ' '{print \$2}' | grep -v lo | head -n 1)

# 限制速度为23mbit
SPEED="23mbit"

# 清除现有的流量控制设置
tc qdisc del dev $INTERFACE root &> /dev/null

# 应用新的出站速度限制
tc qdisc add dev $INTERFACE root tbf rate $SPEED burst 32kbit latency 400ms

echo "速度限制已应用到接口 $INTERFACE: 出站限速 $SPEED."
