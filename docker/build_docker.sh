#!/bin/bash

IMAGE_NAME="b2-base"
TAG="latest"

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd $MYDIR/..

if [[ ! -z $1 && $1 == "nocache" ]]; then
  echo "---- Buiding without cache ----"
  NOCACHE="--no-cache"
fi

# Choose Dockerfile
if [ $(uname -m | grep arm) ]; then
  DOCKERFILE=Dockerfile.arm   # armv7l
else
  DOCKERFILE=Dockerfile       # x86_64
fi

docker build $NOCACHE -t $IMAGE_NAME:$TAG -f $DOCKERFILE .

popd &>/dev/null

