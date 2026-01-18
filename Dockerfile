# syntax=docker/dockerfile:1.3-labs

ARG ALPINE_VERSION=3.23.2

FROM alpine:${ALPINE_VERSION}

COPY entrypoint.sh /entrypoint.sh
COPY softlevel /run/openrc/
COPY reboot.sh /usr/local/sbin/reboot/
COPY shadowsocks-rust/config.json /root/shadowsocks-rust/
RUN <<EOF
set -eux
apk update
apk --no-cache add shadowsocks-rust-ssserver
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
chmod +x /entrypoint.sh
chmod +x /usr/local/sbin/reboot
EOF

EXPOSE 8388/tcp

ENTRYPOINT ["/entrypoint.sh"]
