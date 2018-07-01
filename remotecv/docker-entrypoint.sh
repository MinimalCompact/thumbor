#!/bin/bash

# To disable warning libdc1394 error: Failed to initialize libdc1394
ln -s /dev/null /dev/raw1394

set -e

[[ -z $REMOTECV_REDIS_HOST ]] && REMOTECV_REDIS_HOST=redis
[[ -z $REMOTECV_REDIS_PORT ]] && REMOTECV_REDIS_PORT=6379
[[ -z $REMOTECV_REDIS_DATABASE ]] && REMOTECV_REDIS_DATABASE=0
[[ -z $REMOTECV_LOG_LEVEL ]] && REMOTECV_LOG_LEVEL=INFO
[[ -z $REMOTECV_LOADER ]] && REMOTECV_LOADER=remotecv.http_loader
[[ -z $REMOTECV_STORE ]] && REMOTECV_STORE=remotecv.result_store.redis_store
if [ -n "$REMOTECV_TIMEOUT" ]; then
    TIMEOUT_PARAMETER="-t $REMOTECV_TIMEOUT"
fi
if [ -n "$REMOTECV_SENTRY_URL" ]; then
    SENTRY_URL_PARAMETER="--sentry_url $REMOTECV_SENTRY_URL"
fi

if [ "$1" = 'remotecv' ]; then
    exec remotecv --host $REMOTECV_REDIS_HOST --port $REMOTECV_REDIS_PORT --database $REMOTECV_REDIS_DATABASE -l $REMOTECV_LOG_LEVEL -o $REMOTECV_LOADER -s $REMOTECV_STORE $TIMEOUT_PARAMETER $SENTRY_URL_PARAMETER
fi

exec "$@"
