# OpenWrt autobuild for Amlogic

## Status

| Platform | Devices | Release date | Build status | Link |
|:---------|:--------|:-------------|:-------------|:-----|
AMD64 | Generic | Every week 5 (UTC+0) | [![Build Status](https://github.com/chencaidy/openwrt-actions/actions/workflows/amd64.yml/badge.svg)](https://github.com/chencaidy/openwrt-actions/actions/workflows/amd64.yml) | [![Link](https://img.shields.io/badge/Download-MEGA-blue)](https://mega.nz/folder/yFc3RY5Q#Qtbwdfx7PW0vNC-FuuLlnQ/folder/LEliFBiK)
Amlogic | AMedia X96 Air | Every week 5 (UTC+0) | [![Build Status](https://github.com/chencaidy/openwrt-actions/actions/workflows/amlogic.yml/badge.svg)](https://github.com/chencaidy/openwrt-actions/actions/workflows/amlogic.yml) | [![Link](https://img.shields.io/badge/Download-MEGA-blue)](https://mega.nz/folder/yFc3RY5Q#Qtbwdfx7PW0vNC-FuuLlnQ/folder/udUD3QqB)
Amlogic | Phicomm N1 | Every week 5 (UTC+0) | [![Build Status](https://github.com/chencaidy/openwrt-actions/actions/workflows/amlogic.yml/badge.svg)](https://github.com/chencaidy/openwrt-actions/actions/workflows/amlogic.yml) | [![Link](https://img.shields.io/badge/Download-MEGA-blue)](https://mega.nz/folder/yFc3RY5Q#Qtbwdfx7PW0vNC-FuuLlnQ/folder/LI0HhIKK)

## Description

* `config` Device specific config
* `patches` A simple OpenWrt patchset
* `openwrt_env.sh` Configure local environment
* `openwrt_update.sh` Update source code and patch
* `openwrt_build.sh` Build wizard

## Manually build

1. Cleanly install Ubuntu 18.04
2. Clone actions repo and enter workspace
3. Setup environment: `./openwrt_env.sh`
4. Update source code: `./openwrt_update.sh`
5. Build: `./openwrt_build.sh`
6. Choose a target device in whiptail dialog

## Credit

* [OpenWrt Project](https://github.com/openwrt/openwrt)
* [Lean's OpenWrt source](https://github.com/coolsnowwolf/lede)
* [Jerrykuku 老竭力](https://github.com/jerrykuku)
* [Vernesong](https://github.com/vernesong)
