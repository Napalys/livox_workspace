#!/bin/zsh

# Source the ROS setup script (adjust the path as needed)
source /root/livox_workspace/ros_driver/devel/setup.zsh

# Run the roslaunch command
roslaunch livox_ros_driver livox_lidar.launch

