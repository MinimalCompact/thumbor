#!/usr/bin/env bats

BASE=tests/setup/basic

teardown () {
    docker-compose -f $BASE/docker-compose.yml down
}

load_thumbor () {
    docker-compose -f $BASE/docker-compose.yml up -d
    timeout 2m bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:8888/healthcheck)" != "200" ]]; do sleep 5; done' || false
}

@test "proxy cache memory size=500m, inactive=48h, max_size=10g by default" {
    load_thumbor
    run bash -c "docker-compose -f $BASE/docker-compose.yml exec -T nginx-proxy bash -c 'cat /etc/nginx/conf.d/default.conf' | grep 'keys_zone=thumbor:500m inactive=48h max_size=10g'"
    [ $status -eq 0 ]
}

@test "proxy cache size, memory size and inactive can be set by ENV" {
    export PROXY_CACHE_SIZE=20g
    export PROXY_CACHE_INACTIVE=24h
    export PROXY_CACHE_MEMORY_SIZE=10m
    load_thumbor
    docker-compose -f $BASE/docker-compose.yml exec -T nginx-proxy bash -c 'cat /etc/nginx/conf.d/default.conf'
    run bash -c "docker-compose -f $BASE/docker-compose.yml exec -T nginx-proxy bash -c 'cat /etc/nginx/conf.d/default.conf' | grep 'keys_zone=thumbor:10m inactive=24h max_size=20g'"
    [ $status -eq 0 ]
}

@test "proxy cache is controlled by thumbor MAX_AGE" {
    export MAX_AGE=123456789
    load_thumbor
    sudo rm -rf $BASE/data/*
    # original (un-cached request)
    run bash -c "curl -H -sSL -D - http://localhost:8888/unsafe/500x150/iili.io/H8m6pHv.png -o /dev/null |grep 'Cache-Control: max-age=123456789,public'"
    [ $status -eq 0 ]
    # cached request
    run bash -c "curl -H -sSL -D - http://localhost:8888/unsafe/500x150/iili.io/H8m6pHv.png -o /dev/null |grep 'Cache-Control: max-age=123456789,public'"
    [ $status -eq 0 ]
}
