#!/usr/bin/env bash

set -eo pipefail

host="$(hostname -s)"
user="${POSTGRES_USER:-postgres}"
export PGPASSWORD="${POSTGRES_PASSWORD:-}"

args=(
	# force postgres to not use the local unix socket (test "external" connectibility)
	--host "$host"
	--username "$user"
	--quiet --no-align --tuples-only
)

if select="$(echo 'SELECT 1' | psql "${args[@]}")" && [ "$select" = '1' ]; then
	exit 0
fi

exit 1