# Minimal Compact thumbor nginx proxy cache

A caching proxy for thumbor based on [nginx-proxy](https://github.com/jwilder/nginx-proxy)

## Basics

[nginx-proxy](https://github.com/jwilder/nginx-proxy) provides a way to dynamically attach docker images and get them proxied by Nginx.

This image adds a proxy caching layer into `nginx-proxy`, using the built-in `proxy_cache` directive.

## Defaults

* Cache data is stored inside the container in `/var/cache/nginx`
* Cache size is set to 10Gb (`keys_zone=thumbor:10g`)
* Cached data that isn't accessed for more than 48 hours will be purged (`inactive=48h`)

## Overriding defaults

* You can/should mount a volume to persist cached data even when the container is recreated, e.g. `docker run -v /var/run/docker.sock:/tmp/docker.sock:ro -v /path/to/cache:/var/nginx/cache minimalcompact/thumbor-nginx-proxy-cache`
* use `PROXY_CACHE_SIZE`, `PROXY_CACHE_INACTIVE` to override the cache size and inactive time

## Examples

See recipes for usage examples
