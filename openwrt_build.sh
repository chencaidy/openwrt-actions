#!/bin/bash

ROOT_FOLDER=$(dirname $(readlink -f "$0"))
CONFIG_FOLDER=$ROOT_FOLDER/config
OPENWRT_WS=$ROOT_FOLDER/openwrt

# Switch to workspace
cd $OPENWRT_WS

# Remove old configure
rm -f .config
rm -f .config.old

# Import device defconfig
echo -e "\033[32;1m==> Build target: $1 \033[0m"
cat $CONFIG_FOLDER/$1 >> .config
make defconfig

# Build
THREAD_NUM=$(cat /proc/cpuinfo | grep "processor"| wc -l)
make -j $THREAD_NUM

