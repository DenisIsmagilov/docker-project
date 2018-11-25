FROM zookeeper:3.4

ARG host_group_id
ARG host_user_id

COPY healthcheck.sh /usr/local/bin/

RUN set -x \
    && rm -rf /var/cache/apk/* /var/tmp/* /tmp/*
