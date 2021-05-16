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
echo "Build target: $1"
cat $CONFIG_FOLDER/$1 >> .config
make defconfig

# Build
make -j V=s

