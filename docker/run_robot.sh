#!/bin/bash


DOCKER_IMAGE="sheaffej/b2-base:dev"
CONTAINER_NAME="b2-base"    # Hostname for the started container
# ROBOT_HOSTNAME="b2"         # Hostname of the Ubuntu robot host
CODE_MOUNT="/workspaces/b2"

OPTIONS="-d"

echo
while [ $# -gt 0 ]; do
    case $1 in
        "tag")
            shift
            DOCKER_IMAGE="$1"
            ;;
        "-it")
            OPTIONS="-it"
            ;;
        # "dev")
        #     DEV=1
        #     OPTIONS="--rm -d"
        #     STARTSHELL=1
        #     NAME="--name $CONTAINER_NAME"
        # ;;
        # "robot")
        #     ROBOT=1
        #     OPTIONS="--rm -d"
        #     NAME="--name $CONTAINER_NAME"
        # ;;
        *)
            echo "Unknown argument" $1
    esac
    shift
done

# VOLUMES="/tmp/.X11-unix $HOME/.Xauthority:/root/.Xauthority"
MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJECT_DIR="$MYDIR/.."  # Directory containing the project

# Configure volumes, devices, and networking based on host

    # Attach volumes if present
    # for VOL in $VOLUMES; do
    #     LOCALVOL=$(echo $VOL | tr : " " | awk '{print $1}')
    #     if [[ -e $LOCALVOL ]]; then
    #         DOCKER_VOLUMES="$DOCKER_VOLUMES -v $VOL"
    #     fi
    # done

    # Always restart container on robot hardware
    # if [[ `hostname` == $ROBOT_HOSTNAME ]]; then
    #     RESTART="--restart always"
    # fi

    # NETWORK="--network=host --env ROS_HOSTNAME=`hostname`"
    # DOCKER_DEVICES="--privileged"


# -----------------------
# Re-create the container
# -----------------------
ID=`docker ps -aqf "name=$CONTAINER_NAME"`
if [[ -n $ID ]]; then
    echo "Removing previous container $ID"
    docker rm -f $CONTAINER_NAME 1>/dev/null
fi

echo "Starting container..."
docker run $OPTIONS \
--name $CONTAINER_NAME \
--mount type=bind,source=$PROJECT_DIR,target=$CODE_MOUNT \
--privileged \
--network=host --env ROS_HOSTNAME=`hostname` \
--restart always \
$DOCKER_IMAGE


# ---------------------------
# Attach an interactive shell
# ---------------------------
# Only run if container started in daemon mode
if [[ $OPTIONS == "-d" ]]; then
sleep 2     # Ensure the entry script starts before attaching the shelle
docker exec -it $CONTAINER_NAME bash
fi
