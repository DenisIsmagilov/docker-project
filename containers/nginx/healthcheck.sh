#!/usr/bin/env sh

set -eo pipefail

host="$(hostname -s)"
#    #curl -f "$host"/healthcheck:8080 || exit 1
#    #curl --fail http://localhost:8080/ || exit 1
status=`curl -so /dev/null -w %{http_code} "$host":8080/healthcheck`

if [ $? -eq 0 -a "$status" = "200" ] ; then
    exit 0
fi

exit 1