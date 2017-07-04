FROM ubuntu:xenial
MAINTAINER Nils Jakobi (jakobi.nils@gmail.com)
ENV DEBIAN_FRONTEND noninteractive
# Add camera configuration file and liveslam shortcut
#ADD camera.yaml /root/.ros/camera/
#ADD liveslam /usr/bin

# Stupid apt update
RUN apt update

# Install some prerequisits
RUN apt install -y cmake cmake-curses-gui build-essential libsuitesparse-dev libeigen3-dev libboost-all-dev libopencv-dev zlib1g-dev libglew-dev freeglut3-dev libpython2.7-dev git

# Install Pangolin
WORKDIR /opt
RUN git clone https://github.com/stevenlovegrove/Pangolin.git
WORKDIR /opt/Pangolin
RUN mkdir build
WORKDIR build
RUN cmake -DCMAKE_BUILD_TYPE=Release .. && make -j4 && make install

# clone dso
WORKDIR /opt
RUN git clone https://github.com/JakobEngel/dso.git

# Install ziplib
WORKDIR /opt/dso/thirdparty
RUN tar -zxvf libzip-1.1.1.tar.gz
WORKDIR /opt/dso/thirdparty/libzip-1.1.1/
RUN ./configure && make && make install && cp lib/zipconf.h /usr/local/include/zipconf.h

# install dso
WORKDIR /opt/dso
RUN mkdir build
WORKDIR /opt/dso/build
RUN cmake ..  && make -j4

# install tools for getting the dataset
WORKDIR /opt/dso/build/bin
RUN apt -y install wget unzip
RUN wget http://vision.in.tum.de/mono/dataset/sequence_01.zip
RUN unzip sequence_01.zip
