FROM virgiletn/ros-kinetic:light
LABEL maintainer "virgile.dauge@inria.fr"

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

RUN git clone \
        https://github.com/ros-drivers/velodyne.git \
        /home/catkin_ws/src/velodyne/

RUN apt-get -qq update \
        && apt-get install -y \
        sudo \
        && rosdep install --as-root apt:yes -r --from-paths /home/catkin_ws/ --ignore-src --rosdistro kinetic -y \
        && rm -rf /var/lib/apt/lists/*

RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash \
                  && cd /home/catkin_ws/ \
                  && catkin_make"

ADD vlp16_calibration_file.yaml /home/
