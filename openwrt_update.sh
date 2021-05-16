#!/bin/bash

ROOT_FOLDER=$(dirname $(readlink -f "$0"))
OPENWRT_WS=$ROOT_FOLDER/openwrt

# Update LEDE
echo -e "\033[32;1m==> Update LEDE \033[0m"
if [ -d "$OPENWRT_WS/.git" ]; then
	cd $OPENWRT_WS
	git pull
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
	cd $OPENWRT_WS/target/linux/amlogic
	git pull
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
	cd $PACKAGE_FOLDER/helloworld
	git pull
else
	cd $PACKAGE_FOLDER
	git clone https://github.com/fw876/helloworld.git
fi
## From jerrykuku
if [ -d "$PACKAGE_FOLDER/lua-maxminddb/.git" ]; then
	cd $PACKAGE_FOLDER/lua-maxminddb
	git pull
else
	cd $PACKAGE_FOLDER
	git clone https://github.com/jerrykuku/lua-maxminddb.git
fi
if [ -d "$PACKAGE_FOLDER/luci-app-vssr/.git" ]; then
	cd $PACKAGE_FOLDER/luci-app-vssr
	git pull
else
	cd $PACKAGE_FOLDER
	git clone https://github.com/jerrykuku/luci-app-vssr.git
fi
if [ -d "$PACKAGE_FOLDER/luci-theme-argon/.git" ]; then
	cd $PACKAGE_FOLDER/luci-theme-argon
	git pull
else
	cd $PACKAGE_FOLDER
	git clone https://github.com/jerrykuku/luci-theme-argon.git -b 18.06
fi

