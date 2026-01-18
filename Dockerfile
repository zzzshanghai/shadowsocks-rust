# syntax=docker/dockerfile:1.3-labs

ARG ALPINE_VERSION=3.23.2

FROM alpine:${ALPINE_VERSION}

COPY entrypoint.sh /entrypoint.sh
COPY softlevel /run/openrc/softlevel
COPY reboot.sh /usr/local/sbin/reboot
COPY shadowsocks-rust/ssserver /usr/bin
COPY hysteria/hysteria-linux-amd64-avx /usr/bin
COPY supervisord.conf /root/supervisord.conf
COPY shadowsocks-rust/config.json /root/shadowsocks-rust

RUN <<EOF
set -eux
apk update
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
chmod +x /entrypoint.sh
EOF

EXPOSE 8388/tcp

ENTRYPOINT ["/entrypoint.sh"]
