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

if [ "$1" = 'thumbor' ]; then
    echo "---> Starting thumbor with ${THUMBOR_NUM_PROCESSES:-1} processes..."
    exec thumbor --port=8000 --conf=/app/thumbor.conf $LOG_PARAMETER --processes=${THUMBOR_NUM_PROCESSES:-1}
fi

exec "$@"
