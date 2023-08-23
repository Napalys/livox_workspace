FROM nvidia/cuda:11.4.3-cudnn8-devel-ubuntu18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && apt install -y --no-install-recommends git curl vim rsync ssh wget zsh tmux g++

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)" -- \
    -t robbyrussell \
    -p git \
    -p ssh-agent \
    -p https://github.com/agkozak/zsh-z \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting

RUN apt update && apt install -y curl lsb-release
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt update && apt install -y ros-melodic-desktop-full
RUN apt-get install -y libgtest-dev ros-melodic-catkin python-pip python3-pip

RUN echo "source /opt/ros/melodic/setup.zsh" >> ~/.zshrc
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc

SHELL ["/bin/zsh", "-c"]


RUN git config --global user.email "xxx@163.com"
RUN git config --global user.name "kin-docker"

RUN apt-get update && apt-get install --no-install-recommends -y \
    libblosc-dev \
    libboost-iostreams-dev \
    libboost-numpy-dev \
    libboost-python-dev \
    libboost-system-dev \
    libeigen3-dev \
    libtbb-dev \
    libgflags-dev \
    libgl1-mesa-glx \
    libgoogle-glog-dev \
    protobuf-compiler \
    python3-catkin-tools \
    && rm -rf /var/lib/apt/lists/*


RUN git clone https://github.com/borglab/gtsam.git \
    && cd gtsam && git checkout b10963802c13893611d5a88894879bed47adf9e0 \
    && mkdir build && cd build && cmake .. && make -j$(nproc) && make install

RUN mv /usr/include/flann/ext/lz4.h /usr/include/flann/ext/lz4.h.bak  && \
    mv /usr/include/flann/ext/lz4hc.h /usr/include/flann/ext/lz4.h.bak && \
    ln -s /usr/include/lz4.h /usr/include/flann/ext/lz4.h && \
    ln -s /usr/include/lz4hc.h /usr/include/flann/ext/lz4hc.h

RUN mkdir -p /root/workspace/src && mkdir -p /home/xchu/data/ramlab_dataset
WORKDIR /root/workspace
RUN cd src && git clone https://github.com/JokerJohn/LIO_SAM_6AXIS.git

RUN sudo apt-get update
RUN sudo apt-get install -y apt-utils
RUN sudo apt-get install libgeographic-dev -y
RUN sudo apt-get install software-properties-common -y
RUN sudo add-apt-repository ppa:borglab/gtsam-release-4.0
RUN sudo apt install libgtsam-dev libgtsam-unstable-dev -y


RUN mkdir livox_workspace

WORKDIR /root/livox_workspace
RUN git clone https://github.com/Livox-SDK/Livox-SDK && cd Livox-SDK && cd build && cmake .. && make && make install

SHELL ["/bin/bash", "-c"]

RUN apt install gdb -y

RUN source /opt/ros/melodic/setup.sh && git clone https://github.com/Livox-SDK/livox_ros_driver.git ros_driver/src && cd ros_driver && catkin_make && cd devel && source setup.sh && cd ../build && make install && cd ../.. && mkdir -p livox_mapping/src && \
    cd livox_mapping/src && \
    git clone https://github.com/Livox-SDK/livox_mapping.git && \
    cd .. && \
    catkin_make && \
    cd devel && source setup.bash
    
RUN apt-get install gedit -y
RUN apt-get install libceres-dev -y
RUN apt-get install libsuitesparse-dev



   






