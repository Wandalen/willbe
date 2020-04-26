#!/bin/bash
set -e

# if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
#   set -- node "$@"
# fi

echo "$@"
which node
which npm

exec "$@"
