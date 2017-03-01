FROM ros:kinetic-ros-core
LABEL maintainer "virgile.dauge@inria.fr"

# install ros packages
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ \
    #ros-kinetic-diagnostic-updater \
    #ros-kinetic-angles \
    #ros-kinetic-dynamic-reconfigure \
    #ros-kinetic-nodelet \
    ros-kinetic-desktop-full \
    libyaml-cpp-dev \
    libpcap-dev \
&& rm -rf /var/lib/apt/lists/*

# add environment setup
RUN bin/bash -c "echo 'source /opt/ros/kinetic/setup.bash' >> .bashrc"

# Setup catkin workspace
RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash && \
                  mkdir -p /home/catkin_ws/src && \
                  cd /home/catkin_ws/src && \
                  catkin_init_workspace && \
                  cd /home/catkin_ws/ && \
                  catkin_make && \
                  echo 'source /home/catkin_ws/devel/setup.bash' >> /.bashrc"

RUN bin/bash -c "source .bashrc"

RUN git clone https://github.com/ros-drivers/velodyne.git /home/catkin_ws/src/velodyne/

RUN /bin/bash -c "source /opt/ros/kinetic/setup.bash \
                  && cd /home/catkin_ws/ \
                  && catkin_make"

ADD vlp16_calibration_file.yaml /home/
