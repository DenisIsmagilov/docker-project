FROM elasticsearch:5.6-alpine

ARG host_group_id
ARG host_user_id

COPY healthcheck.sh /usr/local/bin/

RUN set -x \
    && apk update \
    && apk add --no-cache --virtual .runtimeDeps \
        curl \
    && rm -rf /var/cache/apk/* /var/tmp/* /tmp/*
