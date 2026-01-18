# syntax=docker/dockerfile:1.3-labs

ARG ALPINE_VERSION=3.23.2

FROM alpine:${ALPINE_VERSION}

COPY reboot.sh /usr/local/sbin/reboot/
COPY config.json /root/

RUN <<EOF
set -eux
apk update
apk --no-cache add shadowsocks-rust-ssserver
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
chmod +x /usr/local/sbin/reboot
chown -R root:root /root
EOF

EXPOSE 8388/tcp

CMD ["ssserver", "-c", "/root/config.json"]
