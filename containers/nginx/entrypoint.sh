#!/usr/bin/env sh

envsubst "${ENV_VAR_LIST}" < /etc/nginx/tmpl/app.conf > /etc/nginx/conf.d/app.conf
cp /etc/nginx/tmpl/healthcheck.conf /etc/nginx/conf.d

exec "$@"