#!/bin/bash
set -e

ROOT_DIR=$(dirname $(readlink -f "$0"))
WORKSPACE_DIR=$ROOT_DIR/immortalwrt
CONFIG_DIR=$ROOT_DIR/config

# Get device config
if [ -z $1 ]; then
	for name in $(ls $CONFIG_DIR)
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
cd $WORKSPACE_DIR

# Remove old configure
rm -f .config
rm -f .config.old

# Import device defconfig
echo -e "\033[32;1m==> Build target: $TARGET \033[0m"
cat $CONFIG_DIR/$TARGET >> .config
make defconfig

# Build
THREAD_NUM=$(cat /proc/cpuinfo | grep "processor"| wc -l)
if [ $OPENWRT_DEBUG ]; then
	make -j1 V=s
else
	make -j $THREAD_NUM
fi
