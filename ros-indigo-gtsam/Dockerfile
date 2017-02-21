FROM virgiletn/ros-indigo-rviz:nvidia
LABEL maintainer "virgile.dauge@inria.fr"

USER root

RUN apt-get -y update

RUN git clone https://bitbucket.org/gtborg/gtsam.git && \
    cd gtsam && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make install && \
    cd ../..

USER ros
