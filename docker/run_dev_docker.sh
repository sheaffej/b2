#!/bin/bash

IMAGE_NAME="b2-dev:latest"
CONTAINER_NAME="b2-dev"

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
REPOS_DIR=$MYDIR/../..  # Directory containing the cloned git repos
REPOS_DIR=/Users/jsheaffer/code-projects

LOCAL_DIR_1="$REPOS_DIR/b2"
TARGET_DIR_1="/ros/src/b2"

LOCAL_DIR_2="$REPOS_DIR/roboclaw_driver"
TARGET_DIR_2="/ros/src/roboclaw_driver"

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
# The install_project_deps.sh script uses rosdep to install the packages
# required by the custom ROS source packages that are mounted.
# We can't install those dependencies in the Dockerfile since the source
# is not yet available in the container during build. We can change this
# in the future and copy the source into the build, then add these deps
# in the container. On container restart, the deps have already been
# satisfied so the install_project_deps.sh script completes quickly.
docker run -d \
--name $CONTAINER_NAME \
--hostname $CONTAINER_NAME \
--mount type=bind,source=$LOCAL_DIR_1,target=$TARGET_DIR_1 \
--mount type=bind,source=$LOCAL_DIR_2,target=$TARGET_DIR_2 \
$IMAGE_NAME


# ---------------------------
# Attach an interactive shell
# ---------------------------
# Assume we would like to be in an attached shell afterwards
# We can exit form this shell and the containers will stay running
# since the container RUNs with the -d option
docker exec -it $CONTAINER_NAME ./b2_entrypoint.sh bash
