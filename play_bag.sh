#!/bin/zsh

# Check if a bag file name argument is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <bag_file_name>"
  exit 1
fi

# Get the bag file name from the command-line argument
bag_file="$1"

# Check if the bag file exists
if [ ! -f "$bag_file" ]; then
  echo "Bag file '$bag_file' not found."
  exit 1
fi

# Run the rosbag play command
rosbag play "$bag_file"

