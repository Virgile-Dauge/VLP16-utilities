FROM virgiletn/ros-kinetic:light
LABEL maintainer "virgile.dauge@inria.fr"

#Installing all required dependencies according to the source cloned before
RUN apt-get -qq update \
        && apt-get install -y \
        ros-kinetic-rviz \
        libgl1-mesa-glx  \
        libgl1-mesa-dri  \
        && rosdep install --as-root apt:yes -r --from-paths /home/catkin_ws/ --ignore-src --rosdistro kinetic -y \
        && rm -rf /var/lib/apt/lists/*

#Changing default shell for multi commands
SHELL ["bin/bash", "-c"]

#Default command launching the node
CMD source /opt/ros/kinetic/setup.bash \
        && rosrun rviz rviz
