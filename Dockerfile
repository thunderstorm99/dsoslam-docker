FROM ubuntu:xenial
MAINTAINER Nils Jakobi (jakobi.nils@gmail.com)
ENV DEBIAN_FRONTEND noninteractive
# Add camera configuration file and liveslam shortcut
#ADD camera.yaml /root/.ros/camera/
#ADD liveslam /usr/bin

# Install some prerequisits
RUN apt-get install -y cmake cmake-curses-gui build-essential libsuitesparse-dev libeigen3-dev libboost-all-dev libopencv-dev
