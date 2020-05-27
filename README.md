![](https://s3.eu-west-2.amazonaws.com/minimal-compact/images/mc-thumbor.png "MinimalCompact Thumbor")

# Minimal Compact thumbor

The quickest way to run [thumbor](https://github.com/thumbor/thumbor).

Key Features and Goals:

* The latest version of thumbor and dependencies, in a docker image
* Supports both solo thumbor and multiprocess in one image
* [Nginx frontend docker image with built-in caching](nginx-proxy-cache/README.md), using [nginx-proxy](https://github.com/jwilder/nginx-proxy)
* SIMD support via docker tags
* remotecv docker image (for async smart cropping and feature detection)
* Clear version tagging to match Thumbor versions

[Dockerhub minimalcompact/thumbor](https://hub.docker.com/r/minimalcompact/thumbor)

## Quick Start

```
$ docker run -p 80:80 minimalcompact/thumbor
$ wget http://localhost/unsafe/500x150/i.imgur.com/Nfn80ck.png
```

multi-process

```
$ docker run -p 80:80 -e THUMBOR_NUM_PROCESSES=8 minimalcompact/thumbor
$ wget http://localhost/unsafe/500x150/i.imgur.com/Nfn80ck.png

```
https://hub.docker.com/r/minimalcompact/thumbor

## Recipes

Check out the recipes folder for some examples (still work in progress).

The recipes include comments to document how things should be set up and why.

## Changelog / Deprecation

* `minimalcompact/thumbor-nginx-proxy` is deprecated and replaced by `minimalcompact/thumbor-nginx-proxy-cache`
  see https://github.com/MinimalCompact/thumbor/pull/55

## History

This project is a loose fork of `APSL/docker-thumbor`. It's not a direct fork, because lots has changed, and it's not
backwards compatible. Nevertheless, the foundation that `APSL/docker-thumbor` provided was great, and we wish to thank its
contributors.
