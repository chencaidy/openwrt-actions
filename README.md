# OpenWrt autobuild for Amlogic

![amlogic workflow](https://github.com/chencaidy/openwrt-actions/actions/workflows/amlogic.yml/badge.svg)

## Description

* `config` Device specific config
* `patcher` A simple OpenWrt patch script and patchset
* `openwrt_env.sh` Configure local environment
* `openwrt_update.sh` Update or clone source code
* `openwrt_build.sh` Build wizard

## Manualy build

1. Cleanly install Ubuntu 18.04
2. Clone actions repo and enter workspace
3. Setup environment: `./openwrt_env.sh`
4. Update source code: `./openwrt_update.sh`
5. Build: `./openwrt_build.sh`
6. Choose a target device in whiptail dialog
