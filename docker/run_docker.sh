#!/bin/bash


DOCKER_IMAGE="sheaffej/b2-base:dev"
CONTAINER_NAME="b2-base"    # Hostname for the started container
ROBOT_HOSTNAME="b2"         # Hostname of the Ubuntu robot host
DEV_HOSTNAME="ros-dev"      # Hostname of the Ubuntu dev host/VM
CODE_MOUNT="/workspaces/b2"

OPTIONS="--rm -it"

echo
while [ $# -gt 0 ]; do
    case $1 in
        "tag")
            shift
            DOCKER_IMAGE="$1"
            ;;
        *)
            echo "Unknown argument" $1
    esac
    shift
done

VOLUMES="/tmp/.X11-unix $HOME/.Xauthority:/root/.Xauthority"
MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJECT_DIR="$MYDIR/.."  # Directory containing the project

# Configure volumes, devices, and networking based on host
if [[ $DEV || $ROBOT ]]; then

    # Attach volumes if present
    for VOL in $VOLUMES; do
        LOCALVOL=$(echo $VOL | tr : " " | awk '{print $1}')
        if [[ -e $LOCALVOL ]]; then
            DOCKER_VOLUMES="$DOCKER_VOLUMES -v $VOL"
        fi
    done

    NETWORK="--network=host --env ROS_HOSTNAME=`hostname`"
    DOCKER_DEVICES="--privileged"
fi


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
docker run $OPTIONS \
$NAME \
--mount type=bind,source=$PROJECT_DIR,target=$CODE_MOUNT \
-e DISPLAY=$DISPLAY \
$DOCKER_VOLUMES \
$DOCKER_DEVICES \
$NETWORK \
$RESTART \
$DOCKER_IMAGE


# ---------------------------
# Attach an interactive shell
# ---------------------------
# Only run if container started in daemon mode
if [[ $STARTSHELL -eq 1 ]]; then
sleep 2     # Ensure the entry script starts before attaching the shelle
docker exec -it $CONTAINER_NAME bash
fi
