# syntax=docker/dockerfile:1.3-labs

ARG ALPINE_VERSION=3.23.2

FROM alpine:${ALPINE_VERSION}

COPY reboot.sh /usr/local/sbin/reboot/

RUN <<EOF
set -eux
apk update
apk --no-cache add shadowsocks-rust-ssserver
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo "Asia/Shanghai" > /etc/timezone
adduser -s /sbin/nologin -u 1000 -h /home/www-data -S -D -G www-data www-data
chmod +x /usr/local/sbin/reboot
EOF

COPY config.json /home/www-data/

EXPOSE 8388/tcp

CMD ["ssserver", "-c", "/home/www-data/config.json"]
