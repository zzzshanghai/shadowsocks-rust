# syntax=docker/dockerfile:1.3-labs

ARG ALPINE_VERSION=3.23.2

FROM alpine:${ALPINE_VERSION}

RUN <<EOF
set -eux
apk update
apk --no-cache add shadowsocks-rust-ssserver
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
EOF

RUN cat > /root/config.json <<ZZZ
{
    "server": "0.0.0.0",
    "server_port": 8388,
    "password": "${SHADOWSOCKS_PASSWORD}",
    "method": "aes-256-gcm",
    "timeout": 60,
    "mode": "tcp_only"
}
ZZZ

EXPOSE 8388/tcp

CMD ["ssserver", "-c", "/root/config.json"]
