#!/usr/bin/env bash

cp /etc/nginx/conf.d/app.tmpl /etc/nginx/conf.d/default.conf

sed -i "s/{{ nginx.port }}/$NGINX_PORT/g" /etc/nginx/conf.d/default.conf
sed -i "s/{{ nginx.host }}/$NGINX_HOST/g" /etc/nginx/conf.d/default.conf

#sed -i "s/___PROXY_PORT___/$PROXY_PORT/g" /etc/nginx/nginx.conf > /etc/nginx/conf.d/default.conf

#sed -i -e '/user  nginx\;/a\user www-data\;' \
#       -e 's/user  nginx\;/#user  nginx\;/' \
#       -e '/worker_processes  1\;/a\worker_processes 4\;' \
#       -e 's/worker_processes  1\;/#worker_processes  1\;/' \
#       -e '/include \/etc\/nginx\/conf.d\/\*.conf\;/a\    include \/etc\/nginx\/sites-enabled\/\*.conf\;' \
#       -e 's/include \/etc\/nginx\/conf.d\/\*.conf\;/#include \/etc\/nginx\/conf.d\/\*.conf\;/' \
#       /etc/nginx/nginx.conf

#command: /bin/sh -c "envsubst \$NGINX_HOST,\$NGINX_PORT < /etc/nginx/conf.d/app.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"