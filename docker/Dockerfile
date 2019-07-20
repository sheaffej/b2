FROM ros:kinetic

ENV ROS_WS /ros

RUN apt-get update \
	&& apt-get install -y \
 		python-pip \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install --no-cache-dir --upgrade pip

RUN pip install --no-cache-dir \
        pytest

RUN echo >> /root/.bashrc && \
    echo "source ${ROS_WS}/src/b2/docker/mybashrc" >> /root/.bashrc

