#!/usr/bin/env bash

DOCKER_IMAGE="sheaffej/b2-base"
CODE_MOUNT="/workspaces/b2"
MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJECT_DIR="$MYDIR/.."  # Directory containing the project

docker run -it --rm \
--mount type=bind,source=$PROJECT_DIR,target=$CODE_MOUNT \
--env DISPLAY \
--net host --privileged \
$DOCKER_IMAGE $@
