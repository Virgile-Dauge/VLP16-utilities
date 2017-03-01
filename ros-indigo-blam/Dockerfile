FROM virgiletn/indigo-gtsam:latest
LABEL maintainer "virgile.dauge@inria.fr"

USER root

RUN apt-get -y update
RUN apt-get -y install libeigen3-dev
RUN apt-get -y install ros-indigo-pcl-ros

RUN cd home/ros/ && \
git clone https://github.com/erik-nelson/blam.git

RUN /bin/bash -c "source /opt/ros/indigo/setup.bash"

#RUN cd home/ros/blam/ && \
#./update
