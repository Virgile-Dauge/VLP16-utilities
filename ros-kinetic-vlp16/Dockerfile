FROM virgiletn/ros-kinetic:light
LABEL maintainer "virgile.dauge@inria.fr"

RUN git clone \
        https://github.com/ros-drivers/velodyne.git \
        /home/catkin_ws/src/velodyne/

RUN apt-get -qq update \
        && apt-get install -y \
        sudo \
        && rosdep install --as-root apt:yes -r --from-paths /home/catkin_ws/ --ignore-src --rosdistro kinetic -y \
        && rm -rf /var/lib/apt/lists/*

SHELL ["bin/bash", "-c"]
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash \
                  && cd /home/catkin_ws/ \
                  && catkin_make"

ADD vlp16_calibration_file.yaml /home/

CMD cd /home/catkin_ws \
    && source devel/setup.bash \
    && roslaunch velodyne_pointcloud VLP16_points.launch calibration:=/home/vlp16_calibration_file.yaml
