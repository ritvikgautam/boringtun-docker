#!/bin/bash

set -eo pipefail

build() {
    docker build --rm -f Dockerfile -t borington:latest .
}

push() {
    docker tag borington:latest ritvikgautam/borington:latest
    docker push ritvikgautam/borington:latest
}

if [ "$1" = "build" ]; then
    build
elif [ "$1" = "push" ]; then
    push
else echo "Unrecognized argument. Use either `build` or `push`."
fi
