#!/bin/sh

/usr/bin/supervisord -c /root/supervisor/supervisord.conf

exec "$@"
