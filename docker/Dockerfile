FROM ros:kinetic

SHELL ["/bin/bash", "-c"]
ENV ROS_WS /ros

# Install pip 
RUN apt-get update && \
	apt-get install -y python-pip && \
	pip install --no-cache-dir --upgrade pip && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Python testing packages
RUN pip install \
		pytest \
		pytest-cov \
		coveralls

# Install OS packages
RUN apt-get update && \
	apt-get install -y \
		bash-completion \
		htop \
	&& \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Intsall Python app dependencies 
# RUN pip install --ignore-installed \
		# serial 

# Configure the environment
RUN echo >> /root/.bashrc && \
    echo "source ${ROS_WS}/src/b2/docker/mybashrc" >> /root/.bashrc
