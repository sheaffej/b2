#!/bin/bash
set -e

source "/opt/ros/$ROS_DISTRO/setup.bash"

# Initial build
if [[ ! -f /initial.complete && ! -f initial.running ]]; then
    touch /initial.running

    # Link code source if not in place already
    PROJECTS="b2 roboclaw_driver"
    CODE_MNT="/workspaces/b2_project"
    for PRJ in $PROJECTS; do
        echo "Linking ${ROS_WS}/src/${PRJ}"
        [[ ! -f ${ROS_WS}/src/${PRJ} ]] && ln -s ${CODE_MNT}/${PRJ} ${ROS_WS}/src/${PRJ}
    done

    # Set up bash environment
    echo >> /root/.bashrc
    echo "source ${CODE_MNT}/b2_docker/mybashrc" >> /root/.bashrc

    SETUPLOG=/setup.log

    echo "================================="
    echo " Initialize the catkin workspace"
    echo "================================="
    pushd ${ROS_WS}
    apt-get update
    catkin_make &>> $SETUPLOG
    source ${ROS_WS}/devel/setup.bash

    echo "==========================================="
    echo " Install project dependencies using rosdep"
    echo "==========================================="
    rosdep update &>> $SETUPLOG
    rosdep install --from-paths src --ignore-src -r -y &>> $SETUPLOG
    
    touch /initial.complete
    rm -f /initial.running
    popd
fi

exec "$@"