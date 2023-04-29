#!/usr/bin/env bats

BASE=tests/setup/basic

teardown () {
    docker-compose -f $BASE/docker-compose.yml down
}

load_thumbor () {
    docker-compose -f $BASE/docker-compose.yml up -d
    timeout 2m bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:8888/healthcheck)" != "200" ]]; do sleep 5; done' || false
}

@test "no CORS headers by default" {
    load_thumbor
    run bash -c "curl -sSL -D - http://localhost:8888/unsafe/500x150/iili.io/H8m6pHv.png -o /dev/null |grep 'Access-Control-Allow-Origin'"
    [ $status -eq 1 ]
}

@test "CORS headers based on CORS_ALLOW_ORIGIN value" {
    export CORS_ALLOW_ORIGIN=http://www.xyz
    load_thumbor
    run bash -c "curl -sSL -D - http://localhost:8888/unsafe/500x150/iili.io/H8m6pHv.png -o /dev/null |grep 'Access-Control-Allow-Origin: http://www.xyz'"
    [ $status -eq 0 ]
}
