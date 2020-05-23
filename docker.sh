#!/bin/bash

set -eo pipefail

build() {
    docker build --rm -f Dockerfile -t boringtun:latest .
}

push() {
    docker tag boringtun:latest ritvikgautam/boringtun:latest
    docker push ritvikgautam/boringtun:latest
}

if [ "$1" = "build" ]; then
    build
elif [ "$1" = "push" ]; then
    push
else echo "Unrecognized argument. Use either `build` or `push`."
fi
