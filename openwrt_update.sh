#!/bin/bash

ROOT_DIR=$(dirname $(readlink -f "$0"))
OPENWRT_WS=$ROOT_DIR/openwrt
UBOOT_DIR=$OPENWRT_WS/package/boot
PACKAGE_DIR=$OPENWRT_WS/package/openwrt-packages
TARGET_DIR=$OPENWRT_WS/target/linux

function git_update
{
	local path=$1
	local name=$2
	local branch=$3
	local url=$4

	echo -e "\033[1m>>> Pull $name \033[0m"
	if [ -d "$path/$name/.git" ]; then
		cd $path/$name
		git reset --hard
		git clean -df
		git pull
	else
		cd $path
		git clone -b $branch $url $name
	fi
}

# Update LEDE
echo -e "\033[32;1m==> Update LEDE \033[0m"
git_update $ROOT_DIR openwrt master https://github.com/coolsnowwolf/lede.git

# Update packages
echo -e "\033[32;1m==> Update packages \033[0m"
cd $OPENWRT_WS && ./scripts/feeds clean
cd $OPENWRT_WS && ./scripts/feeds update -a
cd $OPENWRT_WS && ./scripts/feeds install -a

# Update target
echo -e "\033[32;1m==> Update target \033[0m"
git_update $TARGET_DIR amlogic master https://github.com/chencaidy/openwrt-target-amlogic.git

# Update thirdparty
echo -e "\033[32;1m==> Update thirdparty \033[0m"
mkdir -p $PACKAGE_DIR
git_update $PACKAGE_DIR helloworld master https://github.com/fw876/helloworld.git
git_update $PACKAGE_DIR lua-maxminddb master https://github.com/jerrykuku/lua-maxminddb.git
git_update $PACKAGE_DIR luci-app-vssr master https://github.com/jerrykuku/luci-app-vssr.git
git_update $PACKAGE_DIR luci-theme-argon 18.06 https://github.com/jerrykuku/luci-theme-argon.git
git_update $PACKAGE_DIR luci-app-openclash master https://github.com/vernesong/OpenClash.git

# Update U-Boot
echo -e "\033[32;1m==> Update U-Boot \033[0m"
git_update $UBOOT_DIR uboot-amlogic main https://github.com/chencaidy/openwrt-package-uboot-amlogic.git

# Patcher
echo -e "\033[32;1m==> Applying patch \033[0m"
PATCH_DIR=$ROOT_DIR/patches
for name in $(find $PATCH_DIR -name "*.patch")
do
	patch -N -r- -p1 -d $OPENWRT_WS < $name
	if [ $? -ne 0 ]; then
		echo -e "\033[31;1m<== Patch failed \033[0m"
		exit 1
	fi
done

