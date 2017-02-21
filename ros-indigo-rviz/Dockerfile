FROM ros:indigo-ros-core
LABEL maintainer "virgile.dauge@inria.fr"

# nvidia-docker hooks
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}
ENV LIBGL_ALWAYS_INDIRECT 0
ENV QT_X11_NO_MITSHM 1

RUN apt-get -y update
RUN apt-get -y install ros-indigo-rviz

# IMPORTANT: Update these values to your primary computer user id and group id
# On OSX use `id -u` and `id -g` to find the correct values
ENV uid 1000
ENV gid 1000

RUN export uid=${uid} gid=${gid} && \
    mkdir -p /home/ros && \
    echo "ros:x:${uid}:${gid}:ros,,,:/home/ros:/bin/bash" >> /etc/passwd && \
    echo "ros:x:${uid}:" >> /etc/group && \
    echo "ros ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ros && \
    chmod 0440 /etc/sudoers.d/ros && \
    chown ${uid}:${gid} -R /home/ros

USER ros
ENV HOME /home/ros

RUN printf "export QT_GRAPHICSSYSTEM=native\nsource /opt/ros/indigo/setup.bash" >> /home/ros/.bashrc
