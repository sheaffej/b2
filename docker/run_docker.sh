#!/bin/bash

IMAGE_NAME="sheaffej/b2:latest"
CONTAINER_NAME="b2"
COMMAND="sleep infinity"

LOCAL_DIR_1="/Users/jsheaffer/code-projects/b2"
TARGET_DIR_1="/ros/src/b2"

# -----------------------
# Re-create the container
# -----------------------

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
    --mount type=bind,readonly,source=$LOCAL_DIR_1,target=$TARGET_DIR_1 \
    $IMAGE_NAME $COMMAND


# ---------------------------
# Attach an interactive shell
# ---------------------------
# Assume we would like to be in an attached shell afterwards
# We can exit form this shell and the containers will stay running
# since the container RUNs with the -d option
docker exec -it $CONTAINER_NAME ./ros_entrypoint.sh bash
