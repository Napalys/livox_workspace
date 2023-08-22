#!/bin/zsh

# Define the output bag file and topics
output_bag="my_data.bag"
topic1="/livox/imu"
topic2="/livox/lidar"

# Record data from the specified topics
rosbag record -O "$output_bag" "$topic1" "$topic2"

