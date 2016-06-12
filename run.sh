#!/bin/sh

set -eux

cd "$(dirname "$0")"
TAG="$USER/${PWD##*/}"

set -- "$@" --cap-add NET_BIND_SERVICE \
	-v $(pwd)/etc:/etc/caddy \
	-v ~/.caddy:/root/.caddy

exec docker run "$@" "$TAG"

