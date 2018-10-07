#!/usr/bin/env sh

set -eo pipefail

curl --silent --fail localhost:9200/_cluster/health || exit 1