#!/bin/bash

echo -e "\033[32;1m==> Update environment \033[0m"

sudo apt-get update
sudo apt-get -y install build-essential clang flex bison g++ gawk \
gcc-multilib g++-multilib gettext git libncurses5-dev libssl-dev \
python3-setuptools rsync swig unzip zlib1g-dev file wget
