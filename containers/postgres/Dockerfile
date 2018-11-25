FROM postgres:11.0-alpine

ARG host_group_id
ARG host_user_id

COPY healthcheck.sh /usr/local/bin/

RUN set -x \
#    && OLD_UID=$(id -u postgres) \
#    && OLD_GID=$(id -g postgres) \
#    && deluser postgres \
#    && addgroup -g ${host_group_id} postgres \
#    && adduser -D -u ${host_user_id} -h /var/lib/postgresql -s /bin/sh -G postgres postgres \
#    && find / -user ${OLD_UID} -exec chown postgres {} \; \
#    && find / -group ${OLD_GID} -exec chgrp postgres {} \; \
#    && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && chmod +x /usr/local/bin/healthcheck.sh \
    && apk update \
    && apk add --no-cache --virtual .runtimeDeps \
        postgresql-contrib \
#    && psql -U postgres -d ${POSTGRES_DB} -c "CREATE EXTENSION ltree;" \
    && rm -rf /var/cache/apk/* /var/tmp/* /tmp/*
