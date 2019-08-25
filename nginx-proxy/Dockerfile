FROM jwilder/nginx-proxy

LABEL maintainer="MinimalCompact"

COPY ./nginx.conf /etc/nginx/
COPY ./imgpath.js /etc/nginx/
COPY ./nginx.tmpl /app/

COPY ./deprecated.sh /app/docker-entrypoint.sh
