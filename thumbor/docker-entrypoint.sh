#!/bin/sh

# To disable warning libdc1394 error: Failed to initialize libdc1394
ln -s /dev/null /dev/raw1394

if [ ! -f /app/thumbor.conf ]; then
  envtpl /app/thumbor.conf.tpl  --allow-missing --keep-template
fi

# If log level is defined we configure it, else use default log_level = info
if [ -n "$LOG_LEVEL" ]; then
    LOG_PARAMETER="-l $LOG_LEVEL"
fi

# Check if thumbor host address is defined -> (default host 0.0.0.0)
if [ -z ${THUMBOR_HOST+x} ]; then
    THUMBOR_HOST='0.0.0.0'
fi

# Check if thumbor port is defined -> (default port 80)
if [ -z ${THUMBOR_PORT+x} ]; then
    THUMBOR_PORT=80
fi

if [ "$1" = 'thumbor' ]; then
    echo "---> Starting thumbor with ${THUMBOR_NUM_PROCESSES:-1} processes..."
    exec thumbor --ip=$THUMBOR_HOST --port=$THUMBOR_PORT --conf=/app/thumbor.conf $LOG_PARAMETER --processes=${THUMBOR_NUM_PROCESSES:-1}
fi

exec "$@"
