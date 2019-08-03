#!/usr/bin/env bats

BASE=recipes/docker-compose/simple
setup () {
    if [[ "$BATS_TEST_NUMBER" -eq 1 ]]; then
        docker-compose -f $BASE/docker-compose.yml up -d
        timeout 2m bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost/healthcheck)" != "200" ]]; do sleep 5; done' || false
        rm -rf $BASE/data/*
    fi
}

teardown () {
    if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
        docker-compose -f $BASE/docker-compose.yml down
    fi
}

@test "PNG returns an image/png content-type" {
    curl -sSL -D - http://localhost/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Content-Type: image/png'
}

@test "PNG result is cached" {
    ls $BASE/data/result_storage/default/8b/83/b846d9575c01f23bff9f430d5f81f16c44cb
    curl -sSL -D - http://localhost/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Content-Type: image/png'
}

@test "next PNG request is fetched from cache" {
    echo 1234 > $BASE/data/result_storage/default/8b/83/b846d9575c01f23bff9f430d5f81f16c44cb
    curl -H -sSL -D - http://localhost/unsafe/500x150/i.imgur.com/Nfn80ck.png |tail -1 |grep 1234
}

@test "AUTO_WEBP returns an image/webp image" {
    curl -H 'Accept: image/webp' -sSL -D - http://localhost/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Content-Type: image/webp'
}

@test "AUTO_WEBP result is cached" {
    ls $BASE/data/result_storage/auto_webp/8b/83/b846d9575c01f23bff9f430d5f81f16c44cb
    curl -H 'Accept: image/webp' -sSL -D - http://localhost/unsafe/500x150/i.imgur.com/Nfn80ck.png -o /dev/null |grep 'Content-Type: image/webp'
}

@test "next WEBP request is fetched from cache" {
    echo 1234 > $BASE/data/result_storage/auto_webp/8b/83/b846d9575c01f23bff9f430d5f81f16c44cb
    curl -H 'Accept: image/webp' -sSL -D - http://localhost/unsafe/500x150/i.imgur.com/Nfn80ck.png |tail -1 |grep 1234
}

@test "filters:format(jpeg) returns an image/jpeg content-type" {
    rm -f $BASE/data/result_storage/default/8b/83/b846d9575c01f23bff9f430d5f81f16c44cb
    curl -sSL -D - 'http://localhost/unsafe/500x150/filters:format(jpeg)/i.imgur.com/Nfn80ck.png' -o /dev/null |grep 'Content-Type: image/jpeg'
}

@test "filters:format(jpeg) result is cached" {
    ls $BASE/data/result_storage/default/77/1f/8c8786e4ad7ed364b2ea722fbe8f3ec043b6
    curl -sSL -D - 'http://localhost/unsafe/500x150/filters:format(jpeg)/i.imgur.com/Nfn80ck.png' -o /dev/null |grep 'Content-Type: image/jpeg'
}

@test "next filters:format(jpeg) request is fetched from cache" {
    echo 1234 > $BASE/data/result_storage/default/77/1f/8c8786e4ad7ed364b2ea722fbe8f3ec043b6
    curl -sSL -D - 'http://localhost/unsafe/500x150/filters:format(jpeg)/i.imgur.com/Nfn80ck.png' |tail -1 |grep 1234
}

@test "filters:format(webp) returns an image/webp content-type" {
    rm -f $BASE/data/result_storage/default/a4/5a/9b7ed7290937d3c996c178141ae5517f8567
    curl -sSL -D - 'http://localhost/unsafe/500x150/filters:format(webp)/i.imgur.com/Nfn80ck.png' -o /dev/null |grep 'Content-Type: image/webp'
}

@test "filters:format(webp) result is cached" {
    ls $BASE/data/result_storage/default/a4/5a/9b7ed7290937d3c996c178141ae5517f8567
    curl -sSL -D - 'http://localhost/unsafe/500x150/filters:format(webp)/i.imgur.com/Nfn80ck.png' -o /dev/null |grep 'Content-Type: image/webp'
}

@test "next filters:format(webp) request is fetched from cache" {
    echo 1234 > $BASE/data/result_storage/default/a4/5a/9b7ed7290937d3c996c178141ae5517f8567
    curl -sSL -D - 'http://localhost/unsafe/500x150/filters:format(webp)/i.imgur.com/Nfn80ck.png' |tail -1 |grep 1234
}
