#!/bin/bash

ROOT_FOLDER=$(dirname $(readlink -f "$0"))
CONFIG_FOLDER=$ROOT_FOLDER/config
OPENWRT_WS=$ROOT_FOLDER/openwrt

# Get device config
if [ -z $1 ]; then
	for name in $(ls $ROOT_FOLDER/config)
	do
		LISTS=$LISTS"$name null "
	done
	TARGET=$(whiptail --noitem --title "OpenWrt Build Wizard" --menu "Choose a target:" 15 60 6 $LISTS 3>&1 1>&2 2>&3)
	if [ $? != 0 ]; then
		echo "<== User cancelled"
		exit 1
	fi
else
	TARGET=$1
fi

# Switch to workspace
cd $OPENWRT_WS

# Remove old configure
rm -f .config
rm -f .config.old

# Import device defconfig
echo -e "\033[32;1m==> Build target: $TARGET \033[0m"
cat $CONFIG_FOLDER/$TARGET >> .config
make defconfig

# Build
THREAD_NUM=$(cat /proc/cpuinfo | grep "processor"| wc -l)
if [ $OPENWRT_DEBUG ]; then
	make -j1 V=s
else
	make -j $THREAD_NUM
fi
