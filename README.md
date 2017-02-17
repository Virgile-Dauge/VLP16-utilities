* Docker ros image creation

Let's start with the latest ros-indigo image from dockerHub :

  docker run -it ros:indigo

Then install essential build tools (need g++ and updated versions of cmake) :

  sudo apt-get update && sudo apt-get install build-essential

* Installing velodyne nodes
  * Required ros packets :
      * diagnostic-updater
      * angles
  * Required libraries :
      * libyaml-cpp-dev
      * libpcap-dev
      
sudo apt-get install ros-indigo-diagnostic-updater
sudo apt-get install ros-indigo-angles
sudo apt-get install libyaml-cpp-dev
sudo apt-get install libpcap-dev

in catkin_ws/src/

git clone https://github.com/ros-drivers/velodyne.git

Then install essential build tools (need g++ and updated versions of cmake) :

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

sudo apt-get install ros-indigo-diagnostic-updater
sudo apt-get install ros-indigo-angles
sudo apt-get install libyaml-cpp-dev
sudo apt-get install libpcap-dev

in catkin_ws/src/

git clone https://github.com/ros-drivers/velodyne.git

roslaunch velodyne_pointcloud VLP16_points.launch calibration:=/home/virgile/vlp16cf.yaml

sudo docker exec -i -t berserk_yalow /bin/bash
docker network create foo

docker run -it --rm --net foo --name master virgiletn/ros-indigo roscore

docker run -it --rm --net foo --name lidarReader virgiletn/ros-indigo roslaunch velodyne_pointcloud VLP16_points.launch calibration:=/home/workspace/vlp16cf.yaml

docker run -it --rm --net foo --name lidarReader --env ROS_HOSTNAME=lidarReader --env ROS_MASTER_URI=http://master:11311 virgiletn/ros-indigo bash

roslaunch velodyne_pointcloud VLP16_points.launch calibration:=/home/workspace/vlp16cf.yaml

docker run -it --rm --net foo --name dataAnalyst --env ROS_HOSTNAME=dataAnalyst --env ROS_MASTER_URI=http://master:11311 virgiletn/ros-indigo bash

docker network create --subnet=192.168.1.0/24 foo

docker run -it --rm --net foonet2 --name master --ip 192.168.1.77 virgiletn/ros-indigo bash
