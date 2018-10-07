#!/usr/bin/env sh

set -eo pipefail

host="$(hostname -i)"

if ping="$(redis-cli -h "$host" ping)" && [ "$ping" = 'PONG' ]; then
	exit 0
fi

exit 1