#!/bin/bash
set -e

LINUX_DISTRO="unknown"
#Detect the Linux Distro
check_linux_distro () {
    set +e
    which apt-get &> /dev/null
    if [ $? == 0 ]; then
        LINUX_DISTRO="ubuntu"
    fi

    which yum &> /dev/null
    if [ $? == 0 ]; then
        LINUX_DISTRO="centos"
    fi
    set -e
}

install_opencv_dependencies_centos () {
    sudo yum -y upgrade
    sudo yum -y update --disablerepo=epel\*
    sudo yum -y install epel-release
    sudo yum -y update
    set +e
    sudo rpm -v --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
    sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
    set -e
    sudo yum -y groupinstall "Development Tools"
    sudo yum -y install cmake gcc gtk2-devel numpy pkconfig
    sudo yum -y install libpng-devel libjpeg-turbo-devel jasper-devel libtiff-devel
    sudo yum -y install openexr-devel
    sudo yum -y install libwebp-devel
    sudo yum -y install libdc1394-devel
    sudo yum -y install tbb-devel eigen3-devel
    sudo yum -y install boost boost-thread boost-devel
    sudo yum -y install libv4l-devel
    sudo yum -y install gstreamer-plugins-base-devel
    sudo yum -y install ffmpeg ffmpeg-devel
    sudo yum -y install unzip wget
    sudo yum -y install cmake3
}

install_opencv_dependencies_ubuntu () {
    sudo apt-get -y update
    sudo apt-get -y install build-essential cmake git pkg-config checkinstall yasm git gfortran
    sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev
    sudo apt-get -y install libjpeg-dev  libtiff-dev openexr libatlas-base-dev
    sudo apt-get -y install python3-dev python3-numpy libtbb2 libtbb-dev libdc1394-22-dev
    sudo apt-get -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev 
    sudo apt-get -y install libgtk2.0-dev libtbb-dev
    sudo apt-get -y install libfaac-dev libmp3lame-dev libtheora-dev
    sudo apt-get -y install libvorbis-dev libxvidcore-dev
    sudo apt-get -y install libopencore-amrnb-dev libopencore-amrwb-dev
    sudo apt-get -y install libavresample-dev
    sudo apt-get -y install x264 v4l-utils
    sudo apt-get -y install unzip 
    OS_VERSION=`cat /etc/lsb-release | grep "DISTRIB_DESCRIPTION" | cut -d" " -f2 | cut -c1-2`
    if [[ "$OS_VERSION" == "14" ]]; then
        sudo apt-get -y install cmake3
    fi
}

install_opencv () {
    DV_DWLD_DIR=/opt/deepvision/downloads/
    DV_OCV_SRC_DIR=${DV_DWLD_DIR}/opencv
    DV_OCV_INSTALL_DIR=/opt/deepvision/opencv

    if [ -d "${DV_OCV_INSTALL_DIR}" ]; then
        echo "[INFO] OpenCV already installed"
        return 1
    fi

    sudo mkdir -p ${DV_OCV_SRC_DIR}

    cd ${DV_DWLD_DIR}
    sudo git clone https://github.com/opencv/opencv.git ${DV_OCV_SRC_DIR}
    cd ${DV_OCV_SRC_DIR}
    sudo git checkout 4.1.0 -b dv_4.1.0
    sudo mkdir -p ${DV_OCV_SRC_DIR}/build
    cd ${DV_OCV_SRC_DIR}/build
    CMAKE_BIN=cmake
    if [ -f /usr/bin/cmake3 ]; then
        CMAKE_BIN=cmake3
    fi

    sudo ${CMAKE_BIN} .. -DCMAKE_BUILD_TYPE=RELEASE -DCMAKE_INSTALL_PREFIX=${DV_OCV_INSTALL_DIR} -DWITH_V4L=ON  -DWITH_GTK=ON -DWITH_OPENCL=OFF -DBUILD_opencv_gpu=OFF
    sudo make

    sudo mkdir -p ${DV_OCV_INSTALL_DIR}
    sudo make install
}

install_dependencies_ubuntu () {
    #sudo apt-get -y install lsb-release
    install_opencv_dependencies_ubuntu
    install_opencv
}

install_dependencies_centos () {
    #sudo yum -y install redhat-lsb-core
    install_opencv_dependencies_centos
    install_opencv
}

check_linux_distro

echo "Script installs OpenCV along with it's dependencies on deployment host."
echo "This is needed for proper functioning of samples nnapps provided in DVSDK."
echo "Script may cause changes to existing package already installed in the system."
echo "If you are not sure, Please install OpenCV and it's dependencies manually."
read -p "Do you want to continue [y/n]:" user_choice

if [ "$user_choice" != "y" ]; then
    echo "[INFO] Exiting..."
    exit
fi

echo "[INFO] Platform Detected: " $LINUX_DISTRO
if [ $LINUX_DISTRO == "ubuntu" ]; then
    install_dependencies_ubuntu
elif [ $LINUX_DISTRO == "centos" ]; then
    install_dependencies_centos
else
    echo "[ ERR] Unsupported linux distribution."
    echo "[INFO] Please contact: DeepVision Inc"
    exit
fi

echo "[INFO] dependencies installed"
