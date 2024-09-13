#!/bin/bash
set -e

ROOT_DIR=$(dirname $(readlink -f "$0"))
WORKSPACE_DIR=$ROOT_DIR/immortalwrt
UBOOT_DIR=$WORKSPACE_DIR/package/boot
PACKAGE_DIR=$WORKSPACE_DIR/package/openwrt-packages
TARGET_DIR=$WORKSPACE_DIR/target/linux

function git_update {
	local path=$1
	local repo=$2
	local branch=$3

	if [ -d "$path/.git" ]; then
		cd $path
		git reset --hard
		git clean -df
		git pull --depth 1
	else
		git clone --depth 1 -b $branch $repo $path
	fi
}

# Update ImmortalWrt
echo -e "\033[32;1m==> Update ImmortalWrt \033[0m"
git_update $WORKSPACE_DIR https://github.com/immortalwrt/immortalwrt.git master

# Update packages
echo -e "\033[32;1m==> Update packages \033[0m"
cd $WORKSPACE_DIR && ./scripts/feeds clean
cd $WORKSPACE_DIR && ./scripts/feeds update -a
cd $WORKSPACE_DIR && ./scripts/feeds install -a

# Update custom target
# echo -e "\033[32;1m==> Update custom target \033[0m"
# git_update $TARGET_DIR/amlogic https://github.com/chencaidy/openwrt-target-amlogic.git master

# Update custom U-Boot
# echo -e "\033[32;1m==> Update custom U-Boot \033[0m"
# git_update $UBOOT_DIR/uboot-amlogic https://github.com/chencaidy/openwrt-package-uboot-amlogic.git main

# Update custom packages
echo -e "\033[32;1m==> Update custom packages \033[0m"
git_update $PACKAGE_DIR/mosdns https://github.com/sbwml/luci-app-mosdns.git v5

# Patcher
echo -e "\033[32;1m==> Applying patch \033[0m"
PATCH_DIR=$ROOT_DIR/patches
for name in $(find $PATCH_DIR -name "*.patch"); do
	patch -N -r- -p1 -d $WORKSPACE_DIR <$name
	if [ $? -ne 0 ]; then
		echo -e "\033[31;1m<== Patch failed \033[0m"
		exit 1
	fi
done
