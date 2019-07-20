#!/bin/bash

IMAGE_NAME="ros:kinetic"
CONTAINER_NAME="b2"
LOCAL_PROJECT_DIR="/Users/jsheaffer/code-projects/b2"
CONTAINER_PROJECT_DIR="/app/b2"
COMMAND="sleep infinity"

# Clean up any previous container
ID=`docker ps -aqf "name=$CONTAINER_NAME"`
if [[ -n $ID ]]; then
    echo "Removing previous container $ID"
    docker rm -f $CONTAINER_NAME 1>/dev/null
fi

echo "Starting container..."
docker run -d \
    --name $CONTAINER_NAME \
    --hostname $CONTAINER_NAME \
    --mount type=bind,readonly,source=$LOCAL_PROJECT_DIR,target=$CONTAINER_PROJECT_DIR \
    $IMAGE_NAME $COMMAND