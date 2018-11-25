FROM memcached:1.5-alpine

ARG host_group_id
ARG host_user_id

USER root

COPY --chown=memcache:memcache healthcheck.sh /usr/local/bin/

RUN set -x \
    && rm -rf /var/cache/apk/* /var/tmp/* /tmp/*

USER memcache
