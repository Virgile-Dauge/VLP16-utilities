## TO DO

- [ ] Test BLAM
  - [x] Build ros-indigo docker image
  - [x] Install BLAM and it's requirements on it
  - [x] Allowing acces to host X server
  - [ ] Testing BLAM offline (with a pre-recorded rosbag)
  - [ ] Find a way to Give acces to the VLP16 from the container
  - [ ] Test BLAM with the direct sensor data stream


## Docker ros image creation

Let's start with the latest ros-indigo image from dockerHub :
```
  docker run -it ros:indigo
```
Then install essential build tools (need g++ and updated versions of cmake) :
```
  sudo apt-get update && sudo apt-get install build-essential
```
## Installing velodyne nodes
Velodyne is a collection of ROS packages supporting Velodyne high definition 3D LIDARs. They produce a ROS Topic '/velodyne_points' of [PointCloud2](http://docs.ros.org/api/sensor_msgs/html/msg/PointCloud2.html) type containning
Updated wiki can be found here : http://ros.org/wiki/velodyne
#### Required ros packages :
* diagnostic-updater
```
sudo apt-get install ros-indigo-diagnostic-updater
```
* angles
```
sudo apt-get install ros-indigo-angles
```
#### Required libraries :
* libyaml-cpp-dev
```
sudo apt-get install libyaml-cpp-dev
```
* libpcap-dev
```
sudo apt-get install libpcap-dev
```

### Velodyne nodes
in 'catkin_ws/src/'
```
git clone https://github.com/ros-drivers/velodyne.git
```

##Intalling BLAM
git clone https://bitbucket.org/gtborg/gtsam.git
cd gtsam
mkdir build
cmake ..
make install

git clone https://github.com/erik-nelson/blam.git

sudo apt-get install libeigen3-dev
sudo apt-get install ros-indigo-pcl-ros

cd blam
./update

mkdir catkin_ws
cd catkin_ws/
mkdir src
cd src/
catkin_init_workspace

in catkin_ws/src/

git clone https://github.com/ros-drivers/velodyne.git

roslaunch velodyne_pointcloud VLP16_points.launch calibration:=/home/virgile/vlp16cf.yaml

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
```
--user=$(id -u)  \
--env="DISPLAY" \
--env="QT_X11_NO_MITSHM=1"
--volume="/etc/group:/etc/group:ro" \
--volume="/etc/passwd:/etc/passwd:ro" \
--volume="/etc/shadow:/etc/shadow:ro" \
--volume="/etc/sudoers.d:/etc/sudoers.d:ro" \ --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
```
