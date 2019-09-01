#!/usr/bin/env bats

BASE=tests/setup/basic

teardown () {
    docker-compose -f $BASE/docker-compose.yml down
}

load_thumbor () {
    docker-compose -f $BASE/docker-compose.yml up -d
    timeout 2m bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost/healthcheck)" != "200" ]]; do sleep 5; done' || false
}

@test "no webp headers by default even if browser accepts" {
    rm -rf $BASE/data/*
    load_thumbor
    run bash -c "curl -H 'Accept: image/webp' -sSL -D - http://localhost/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Content-Type: image/png'"
    [ $status -eq 0 ]
}

@test "webp headers if AUTO_WEBP is set and browser accepts webp" {
    export AUTO_WEBP=True
    rm -rf $BASE/data/*
    load_thumbor
    run bash -c "curl -H 'Accept: image/webp' -sSL -D - http://localhost/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Content-Type: image/webp'"
    [ $status -eq 0 ]
}

@test "NOTE: nginx proxy cache can override AUTO_WEBP (Must clear the cache when you change the settings!)" {
    export AUTO_WEBP=False
    load_thumbor
    run bash -c "curl -H 'Accept: image/webp' -sSL -D - http://localhost/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Content-Type: image/webp'"
    [ $status -eq 0 ]
}
