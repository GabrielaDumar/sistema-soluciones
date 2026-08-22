#!/usr/bin/env bash
set -e

: "${PORT:=10000}"
: "${BACKEND_HOST:=127.0.0.1}"
export PORT
export BACKEND_HOST

envsubst '${PORT} ${BACKEND_HOST}' < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf

nginx -g 'daemon off;'