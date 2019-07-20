#!/bin/bash

CONTAINER_NAME="b2"
ENTRYPOINT="/ros_entrypoint.sh"
CMDS="bash"

docker exec -it $CONTAINER_NAME $ENTRYPOINT $CMDS
