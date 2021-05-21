#!/bin/bash

ROOT_FOLDER=$(dirname $(readlink -f "$0"))
OPENWRT_WS=$ROOT_FOLDER/openwrt

function git_update
{
	cd $1
	echo "Updating $1"
	git reset --hard
	git clean -df
	git pull
}

# Update LEDE
echo -e "\033[32;1m==> Update LEDE \033[0m"
if [ -d "$OPENWRT_WS/.git" ]; then
	git_update $OPENWRT_WS
else
	cd $ROOT_FOLDER
	git clone https://github.com/coolsnowwolf/lede.git openwrt
fi

# Update packages
echo -e "\033[32;1m==> Update packages \033[0m"
cd $OPENWRT_WS
./scripts/feeds update -a
./scripts/feeds install -a

# Update target
echo -e "\033[32;1m==> Update target \033[0m"
if [ -d "$OPENWRT_WS/target/linux/amlogic/.git" ]; then
	git_update $OPENWRT_WS/target/linux/amlogic
else
	cd $OPENWRT_WS/target/linux
	git clone https://github.com/chencaidy/openwrt-target-amlogic.git amlogic
fi

# Update thirdparty
echo -e "\033[32;1m==> Update thirdparty \033[0m"
PACKAGE_FOLDER=$OPENWRT_WS/package/openwrt-packages
mkdir -p $PACKAGE_FOLDER
## From fw876
if [ -d "$PACKAGE_FOLDER/helloworld/.git" ]; then
	git_update $PACKAGE_FOLDER/helloworld
else
	cd $PACKAGE_FOLDER
	git clone https://github.com/fw876/helloworld.git
fi
## From jerrykuku
if [ -d "$PACKAGE_FOLDER/lua-maxminddb/.git" ]; then
	git_update $PACKAGE_FOLDER/lua-maxminddb
else
	cd $PACKAGE_FOLDER
	git clone https://github.com/jerrykuku/lua-maxminddb.git
fi
if [ -d "$PACKAGE_FOLDER/luci-app-vssr/.git" ]; then
	git_update $PACKAGE_FOLDER/luci-app-vssr
else
	cd $PACKAGE_FOLDER
	git clone https://github.com/jerrykuku/luci-app-vssr.git
fi
if [ -d "$PACKAGE_FOLDER/luci-theme-argon/.git" ]; then
	git_update $PACKAGE_FOLDER/luci-theme-argon
else
	cd $PACKAGE_FOLDER
	git clone https://github.com/jerrykuku/luci-theme-argon.git -b 18.06
fi

# Update U-Boot
echo -e "\033[32;1m==> Update U-Boot \033[0m"
if [ -d "$OPENWRT_WS/package/boot/uboot-amlogic/.git" ]; then
	git_update $OPENWRT_WS/package/boot/uboot-amlogic
else
	cd $OPENWRT_WS/package/boot
	git clone https://github.com/chencaidy/openwrt-package-uboot-amlogic uboot-amlogic
fi

# Patcher
echo -e "\033[32;1m==> Applying patch \033[0m"
PATCH_FOLDER=$ROOT_FOLDER/patches
for name in $(find $PATCH_FOLDER -name "*.patch")
do
	patch -N -r- -p1 -d $OPENWRT_WS < $name
done

