# ===== 构建阶段 =====
FROM mcr.microsoft.com/playwright:v1.41.1-jammy as builder

RUN npm config set registry https://registry.npmmirror.com

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

# ===== 运行阶段 =====
FROM node:18.16

RUN echo "deb https://mirrors.aliyun.com/debian/ bullseye main contrib non-free" > /etc/apt/sources.list \
  && apt-get update \
  && apt-get install -y libatk-bridge2.0-0 libgtk-3-0 libdrm2 libxcomposite1 libxdamage1 libxrandr2 \
     libgbm1 libasound2 libxss1 libnss3 libxshmfence1 libx11-xcb1 libxcb-dri3-0 libxcb1 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/package.json ./

COPY --from=builder /usr/src/app/playwright.config.* ./
# 如果有环境文件
COPY --from=builder /usr/src/app/.env* ./
# 如果有入口脚本
COPY --from=builder /usr/src/app/docker-entrypoint.sh ./

RUN chmod +x docker-entrypoint.sh

ARG PORT=8080
ENV PORT=$PORT
EXPOSE $PORT

ENTRYPOINT ["./docker-entrypoint.sh"]
