FROM ubuntu:xenial
MAINTAINER Nils Jakobi (jakobi.nils@gmail.com)
ENV DEBIAN_FRONTEND noninteractive
# Add camera configuration file and liveslam shortcut
#ADD camera.yaml /root/.ros/camera/
#ADD liveslam /usr/bin

# Stupid apt update
RUN apt update

# Install some prerequisits
RUN apt install -y cmake cmake-curses-gui build-essential libsuitesparse-dev libeigen3-dev libboost-all-dev libopencv-dev zlib1g-dev libglew-dev freeglut3-dev libpython2.7-dev

RUN apt install -y git

# Install Pangolin
RUN git clone https://github.com/stevenlovegrove/Pangolin.git

# clone dso
RUN git clone https://github.com/JakobEngel/dso.git

# Install ziplib
WORKDIR dso/thirdparty
RUN tar -zxvf libzip-1.1.1.tar.gz
WORKDIR libzip-1.1.1/
RUN ./configure && make && make install && cp lib/zipconf.h /usr/local/include/zipconf.h
