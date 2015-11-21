 #!/bin/sh

set -eu

cd "$(dirname "$0")"
TAG="$USER/${PWD##*/}"

exec docker run -it -e TERM "$@" "$TAG"

