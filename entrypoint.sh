#!/bin/sh

/usr/bin/supervisord -c /home/supervisor/supervisord.conf

exec "$@"
