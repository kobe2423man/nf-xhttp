FROM node:20-bookworm-slim
WORKDIR /app
RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip psmisc procps openssl ca-certificates \
    && rm -rf /var/lib/apt/lists/*
COPY package.json index.js start.sh ./
RUN chmod +x start.sh index.js
CMD ["sh", "start.sh"]
