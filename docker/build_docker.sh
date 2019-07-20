#!/bin/bash

IMAGE_NAME="sheaffej/b2"
TAG="latest"

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd $MYDIR

docker build -t $IMAGE_NAME:$TAG .

popd &>/dev/null

