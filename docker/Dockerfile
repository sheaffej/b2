FROM ros:kinetic

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

ENV ROS_WS /ros

COPY b2_entrypoint.sh /
ENTRYPOINT [ "/b2_entrypoint.sh" ]
CMD [ "sleep", "infinity" ]
