#!/bin/bash
set -e

source "/opt/ros/$ROS_DISTRO/setup.bash"

# Initial build
if [[ ! -f /initial.complete && ! -f initial.running ]]; then
    touch /initial.running
    pushd ${ROS_WS}
    echo >> /root/.bashrc && \
    echo "source ${ROS_WS}/src/b2/docker/mybashrc" >> /root/.bashrc && \
    apt-get update && \
    catkin_make && \
    source ${ROS_WS}/devel/setup.bash && \
    echo "============= done 1 =================" && \
    # ps aux | grep -i apt && \
    # sleep 5 && \
    # ps aux | grep -i apt && \
    echo "============= done 2 =================" && \
    rosdep update && \
    rosdep install --from-paths src --ignore-src -r -y && \
    [ $? -eq 0 ] && touch /initial.complete && rm -f /initial.running
    popd
fi

exec "$@"