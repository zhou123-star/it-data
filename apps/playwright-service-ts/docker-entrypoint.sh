#!/bin/bash
set -e

# 启动服务（默认用 node 运行 dist 下的主文件）
exec node dist/index.js
