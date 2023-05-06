#!/usr/bin/env bats

BASE=tests/setup/basic

setup () {
    if [[ "$BATS_TEST_NUMBER" -eq 1 ]]; then
        export AUTO_WEBP=True
        docker-compose -f $BASE/docker-compose.yml up -d
        timeout 2m bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:8888/healthcheck)" != "200" ]]; do sleep 5; done' || false
        rm -rf $BASE/data/*
    fi
}

teardown () {
    if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
        docker-compose -f $BASE/docker-compose.yml down
    fi
}

@test "PNG returns an image/png content-type" {
    curl -sSL -D - http://localhost:8888/unsafe/500x150/iili.io/H8m6pHv.png -o /dev/null |grep 'Content-Type: image/png'
}

@test "PNG result is cached" {
    ls $BASE/data/1/93/d2f8049ecceae339b0576ce9fee79931
    curl -sSL -D - http://localhost:8888/unsafe/500x150/iili.io/H8m6pHv.png -o /dev/null |grep 'Content-Type: image/png'
}

@test "AUTO_WEBP returns an image/webp image" {
    curl -H 'Accept: image/webp' -sSL -D - http://localhost:8888/unsafe/500x150/iili.io/H8m6pHv.png -o /dev/null |grep 'Content-Type: image/webp'
}

@test "AUTO_WEBP result is cached" {
    ls $BASE/data/f/8e/83d9248ee51a85082f1f6b95085ed8ef
    curl -H 'Accept: image/webp' -sSL -D - http://localhost:8888/unsafe/500x150/iili.io/H8m6pHv.png -o /dev/null |grep 'Content-Type: image/webp'
}

@test "filters:format(jpeg) returns an image/jpeg content-type" {
    rm -f $BASE/data/c/ab/107f801b5c03c0acc27deb34fa98eabc
    curl -sSL -D - 'http://localhost:8888/unsafe/500x150/filters:format(jpeg)/iili.io/H8m6pHv.png' -o /dev/null |grep 'Content-Type: image/jpeg'
}

@test "filters:format(jpeg) result is cached" {
    ls $BASE/data/c/ab/107f801b5c03c0acc27deb34fa98eabc
    curl -sSL -D - 'http://localhost:8888/unsafe/500x150/filters:format(jpeg)/iili.io/H8m6pHv.png' -o /dev/null |grep 'Content-Type: image/jpeg'
}

@test "filters:format(webp) returns an image/webp content-type" {
    rm -f $BASE/data/c/ab/107f801b5c03c0acc27deb34fa98eabc
    curl -sSL -D - 'http://localhost:8888/unsafe/500x150/filters:format(webp)/iili.io/H8m6pHv.png' -o /dev/null |grep 'Content-Type: image/webp'
}

@test "filters:format(webp) result is cached" {
    ls $BASE/data/9/fb/ff2896a24893ab6e2d0d1c8195f5bfb9
    curl -sSL -D - 'http://localhost:8888/unsafe/500x150/filters:format(webp)/iili.io/H8m6pHv.png' -o /dev/null |grep 'Content-Type: image/webp'
}

@test "only one content-type header is present" {
    count=`curl -H 'Accept: image/webp' -sSL -D - http://localhost:8888/unsafe/500x150/iili.io/H8m6pHv.png -o /dev/null |grep 'Content-Type:'|wc -l`
    [ $count -eq 1 ]
}
