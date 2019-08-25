#!/usr/bin/env bats

BASE=tests/setup/basic

teardown () {
    docker-compose -f $BASE/docker-compose.yml down
}

load_thumbor () {
    docker-compose -f $BASE/docker-compose.yml up -d
    timeout 2m bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost/healthcheck)" != "200" ]]; do sleep 5; done' || false
}

@test "proxy cache size=100m inactive=300m by default" {
    load_thumbor
    run bash -c "docker-compose -f $BASE/docker-compose.yml exec nginx-proxy bash -c 'cat /etc/nginx/conf.d/default.conf' | grep 'keys_zone=thumbor:100m inactive=300m'"
    [ $status -eq 0 ]
}

@test "proxy cache size and inactive can be set by ENV" {
    export PROXY_CACHE_SIZE=200m
    export PROXY_CACHE_INACTIVE=24h
    load_thumbor
    run bash -c "docker-compose -f $BASE/docker-compose.yml exec nginx-proxy bash -c 'cat /etc/nginx/conf.d/default.conf' | grep 'keys_zone=thumbor:200m inactive=24h'"
    [ $status -eq 0 ]
}

@test "proxy cache is controlled by thumbor MAX_AGE" {
    export MAX_AGE=123456789
    load_thumbor
    rm -rf $BASE/data/*
    # original (un-cached request)
    run bash -c "curl -H -sSL -D - http://localhost/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Cache-Control: max-age=123456789,public'"
    [ $status -eq 0 ]
    # cached request
    run bash -c "curl -H -sSL -D - http://localhost/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Cache-Control: max-age=123456789,public'"
    [ $status -eq 0 ]
}