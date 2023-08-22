# Livox Lidar Docker Setup
This guide provides the steps to setup and run the Livox Lidar Docker image.

# Prerequisites
Docker installed on your machine.
NVIDIA Docker runtime (for GPU support).
X11 for GUI applications (if you're planning to run GUI applications from inside the container).
Setup Steps
## 1. Build the Docker Image
To build the Docker image for Livox Lidar, navigate to the directory containing the Dockerfile and run the following command:

```bash
docker build -t livox_lidar_image .
```

This command builds a Docker image with the tag livox_lidar_image.

## 2. Allow Docker to Access X11
Before running the Docker container, if you intend to use GUI applications from inside the container, you'll need to give Docker access to your X11 server. Run:

```bash
xhost +local:docker
```

## 3. Run the Docker Container
To run the Docker container with the necessary configurations and permissions, use the following command:

```bash
docker run -it \
  --privileged \
  -v $(pwd):/root/scripts/ \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=:1 \
  --net=host \
  --gpus all \
  --name livox_docker livox_lidar_image /bin/zsh
```

