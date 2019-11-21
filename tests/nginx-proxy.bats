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
    curl -sSL -D - http://localhost:8888/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Content-Type: image/png'
}

@test "PNG result is cached" {
    ls $BASE/data/d/a9/ad4b1bf58341edd5c957cf0aa94eba9d
    curl -sSL -D - http://localhost:8888/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Content-Type: image/png'
}

@test "AUTO_WEBP returns an image/webp image" {
    curl -H 'Accept: image/webp' -sSL -D - http://localhost:8888/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Content-Type: image/webp'
}

@test "AUTO_WEBP result is cached" {
    ls $BASE/data/6/fd/9d408b450fecb47d2a5370cfbbeccfd6
    curl -H 'Accept: image/webp' -sSL -D - http://localhost:8888/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Content-Type: image/webp'
}

@test "filters:format(jpeg) returns an image/jpeg content-type" {
    rm -f $BASE/data/b/71/72931161fa8b05e9cf6ca882e1bc771b
    curl -sSL -D - 'http://localhost:8888/unsafe/500x150/filters:format(jpeg)/i.imgur.com/Nfn80ck.png' -o /dev/null |grep 'Content-Type: image/jpeg'
}

@test "filters:format(jpeg) result is cached" {
    ls $BASE/data/b/71/72931161fa8b05e9cf6ca882e1bc771b
    curl -sSL -D - 'http://localhost:8888/unsafe/500x150/filters:format(jpeg)/i.imgur.com/Nfn80ck.png' -o /dev/null |grep 'Content-Type: image/jpeg'
}

@test "filters:format(webp) returns an image/webp content-type" {
    rm -f $BASE/data/b/71/72931161fa8b05e9cf6ca882e1bc771b
    curl -sSL -D - 'http://localhost:8888/unsafe/500x150/filters:format(webp)/i.imgur.com/Nfn80ck.png' -o /dev/null |grep 'Content-Type: image/webp'
}

@test "filters:format(webp) result is cached" {
    ls $BASE/data/4/c7/2b3b73bd53c5d7e35f17b6d358ecbc74
    curl -sSL -D - 'http://localhost:8888/unsafe/500x150/filters:format(webp)/i.imgur.com/Nfn80ck.png' -o /dev/null |grep 'Content-Type: image/webp'
}

@test "only one content-type header is present" {
    count=`curl -H 'Accept: image/webp' -sSL -D - http://localhost:8888/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Content-Type:'|wc -l`
    [ $count -eq 1 ]
}
