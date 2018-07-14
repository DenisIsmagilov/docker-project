#!/usr/bin/env sh

envsubst "${ENV_VAR_LIST}" < /etc/nginx/conf.d/app.conf.tmpl > /etc/nginx/conf.d/app.conf
exec nginx -g 'daemon off;'