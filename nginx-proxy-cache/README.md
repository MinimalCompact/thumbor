# Minimal Compact thumbor nginx proxy cache

A caching proxy for thumbor based on [nginx-proxy](https://github.com/nginx-proxy/nginx-proxy)

## Basics

[nginx-proxy](https://github.com/nginx-proxy/nginx-proxy) provides a way to dynamically attach docker images and get them proxied by Nginx.

This image adds a proxy caching layer into `nginx-proxy`, using the built-in `proxy_cache` directive.

## Defaults

* Cache data is stored inside the container in `/var/cache/nginx`
* Max cache size is set to 10Gb (`max_size=10g`)
* Cached data that isn't accessed for more than 48 hours will be purged (`inactive=48h`)
* Cache memory size is set to 500m (`keys_zone=thumbor:500m`) holds all active keys and metadata of the cache in memory

## Overriding defaults

* You can/should mount a volume to persist cached data even when the container is recreated, e.g. `docker run -v /var/run/docker.sock:/tmp/docker.sock:ro -v /path/to/cache:/var/cache/nginx minimalcompact/thumbor-nginx-proxy-cache`
* use `PROXY_CACHE_SIZE`, `PROXY_CACHE_INACTIVE`, `PROXY_CACHE_MEMORY_SIZE` to override the max cache size, inactive time or memory size

## Examples

See recipes for usage examples
