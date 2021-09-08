#!/bin/bash
set -e

cmd="$@"

while ! curl -sSL "http://${SELENIUM_HOST}:${SELENIUM_PORT}/wd/hub/status" 2>&1 \
        | jq -r '.value.ready' 2>&1 | grep 'true' >/dev/null; do
    echo 'Waiting for the Selenium Server'
    sleep 1
done

>&2 echo "Selenium container is up - executing tests"

echo CMD: $cmd

exec $cmd
