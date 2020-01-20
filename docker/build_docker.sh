#!/bin/bash

DOCKER_IMAGE="sheaffej/b2-base"

echo
while [ $# -gt 0 ]; do
    case $1 in
        "tag")
            shift
            DOCKER_IMAGE="$1"
            ;;
        "nocache")
          NOCACHE="--no-cache"
          echo "Buiding without cache"
          ;;
        *)
            echo "Unknown argument" $1
    esac
    shift
done

echo "Using Docker image tag: $DOCKER_IMAGE"

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJ_DIR=$MYDIR/..

docker build $NOCACHE -t $DOCKER_IMAGE .


