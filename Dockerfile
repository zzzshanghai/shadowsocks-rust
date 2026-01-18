# syntax=docker/dockerfile:1.3-labs

ARG ALPINE_VERSION=3.23.2

FROM alpine:${ALPINE_VERSION}

RUN <<EOF
set -eux
apk update
apk --no-cache add shadowsocks-rust-ssserver
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
touch /root/config.json
echo "{"server": "0.0.0.0", "server_port": 8388, "password": "^ghj%$bcDP8l4#HH", "method": "aes-256-gcm", "timeout": 60, "mode": "tcp_only"}" >> /root/config.json
EOF

EXPOSE 8388/tcp

CMD ["ssserver", "-c", "/root/config.json"]
