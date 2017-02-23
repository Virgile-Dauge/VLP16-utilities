## TO DO

- [ ] Test BLAM
  - [x] Build ros-indigo docker image
  - [x] Install BLAM and it's requirements on it
  - [x] Allowing acces to host X server
  - [x] Allowing acces to graphic card from container (NVIDIA)
  - [x] Testing BLAM offline (with a pre-recorded rosbag)
  - [x] Find a way to Give acces to the VLP16 from the container
  - [x] Test BLAM with the direct sensor data stream

## Docker ros image creation

Let's start with the latest ros-indigo image from dockerHub :
```
  docker run -it ros:indigo
```
Then install essential build tools (need g++ and updated versions of cmake) :
```
  sudo apt-get update && sudo apt-get install build-essential
```
##Docker commit
```
docker commit -a "virgile" -m "message" CONTAINER [REPOSITORY[:TAG]]
```
##Docker cleannup
Remove all stopped containers
```
docker rm -v $(docker ps -a -q -f status=exited)
```
Remove unwanted ‘dangling’ images
```
docker rmi $(docker images -f "dangling=true" -q)
```
Remove volumes
```
docker volume rm $(docker volume ls -qf dangling=true)
```
##Docker build
```
docker tag 7d9495d03763 maryatdocker/docker-whale:latest
```
mkdir -p catkin_ws/src/
cd catkin_ws/src/

catkin_init_workspace

in catkin_ws/src/

sudo docker exec -i -t berserk_yalow /bin/bash
docker network create foo

docker run -it \
--rm \
--net foo \
--name master \
virgiletn/ros-indigo roscore

docker run -it \
 --rm \
 --net foo \
 --name lidarReader \
 --env ROS_HOSTNAME=lidarReader \
 --env ROS_MASTER_URI=http://master:11311 \
 --ip 192.168.1.77 \
 virgiletn/ros-indigo bash

cd home/workspace/catkin_ws/ && source devel/setup.bash

roslaunch velodyne_pointcloud VLP16_points.launch calibration:=/home/workspace/vlp16cf.yaml

docker run -it \
--rm \
--net foo \
--name dataAnalyst \
--env ROS_HOSTNAME=dataAnalyst \
--env ROS_MASTER_URI=http://master:11311 \
--user=$(id -u)  \
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1" \
--volume="/etc/group:/etc/group:ro" \
--volume="/etc/passwd:/etc/passwd:ro" \
--volume="/etc/shadow:/etc/shadow:ro" \
--volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
virgiletn/ros-indigo bash

docker network create --subnet=192.168.1.0/24 foo

docker run -it --rm --net foo --name master --ip 192.168.1.77 virgiletn/ros-indigo bash

2368
#Docker encapsulation
###Allowing GUI display
Needed for using any graphical tool.
If you want to run it with your current USER
```
--user=$(id -u)  \
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1"
--volume="/etc/group:/etc/group:ro" \
--volume="/etc/passwd:/etc/passwd:ro" \
--volume="/etc/shadow:/etc/shadow:ro" \
--volume="/etc/sudoers.d:/etc/sudoers.d:ro" \ --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
```
Simple way :
```
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
```
but you need to allow acces to yout host Xserver
```
xhost +local:root
```
(not safe) OR
```
export containerId=$(docker ps -l -q)
xhost +local:`docker inspect --format='{{ .Config.Hostname }}' $containerId`
docker start $containerId
```

docker run -it \
--rm \
--net foo \
--name dataAnalyst \
--env ROS_HOSTNAME=dataAnalyst \
--env ROS_MASTER_URI=http://master:11311 \
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
--device=/dev/dri:/dev/dri \
virgiletn/ros-indigo:rviz bash

docker run -it \
--rm \
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1" \
--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
ros-rviz bash


##Enabling Graphical Acceleration.
###Installing nvidia-docker
# Install nvidia-docker and nvidia-docker-plugin
```
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.0/nvidia-docker_1.0.0-1_amd64.deb
sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb
sudo apt-get install nvidia-modprobe
```
# Test nvidia-smi
```
nvidia-docker run --rm nvidia/cuda nvidia-smi
```
Checking glx on host :
```
glxgear
```
nvidia-docker run -it \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="LIBGL_ALWAYS_INDIRECT=0" \
    ros-rviz \
    bash -c "roscore & rosrun rviz rviz"

    nvidia-docker run -it \
        --env="DISPLAY" \
        --env="QT_X11_NO_MITSHM=1" \
        --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
        --env="LIBGL_ALWAYS_INDIRECT=0" \
        virgiletn/ros-indigo:nvidia \
        bash -c "roscore & rosrun rviz rviz"

        nvidia-docker run -it \
            --env="DISPLAY" \
            --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
            virgiletn/ros-indigo:nvidia \
            bash -c "roscore & rosrun rviz rviz"

            nvidia-docker run -it \
            --rm \
            --net host \
            --name blam \
            --env ROS_HOSTNAME=coucou \
            --env ROS_MASTER_URI=http://coucou:11311 \
                --env="DISPLAY" \
                --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
                virgiletn/ros-indigo-blam \
                roscore
