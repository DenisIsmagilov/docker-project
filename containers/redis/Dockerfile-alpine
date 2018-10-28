FROM redis:5.0-alpine

ARG host_group_id
ARG host_user_id

COPY healthcheck.sh /usr/local/bin/

RUN set -x \
    && chmod +x /usr/local/bin/healthcheck.sh \
    && rm -rf /var/cache/apk/* /var/tmp/* /tmp/*
