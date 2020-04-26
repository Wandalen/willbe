#!/bin/bash
set +e

echo "@ : $@"

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  echo "a1"
  set -- node "$@"
fi

echo "PATH : $PATH"
echo "@ : $@"
which node
which npm

exec "$@"
