#!/usr/bin/env bash

set -eo pipefail

host="$(hostname -s)"
#curl -f "$host"/healthcheck || exit 1
#curl --fail http://localhost:80/ || exit 1
status=`curl -so /dev/null -w %{http_code} "$host"/healthcheck`

if [ $? -eq 0 -a "$status" = "200" ] ; then
    exit 0
fi

exit 1