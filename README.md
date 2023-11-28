# OpenWrt autobuild for Amlogic

## Status

| Platform | Devices | Release date | Build status | Link |
|:---------|:--------|:-------------|:-------------|:-----|
x86-64 | generic | Every week 5 (UTC+0) | [![Build Status](https://github.com/chencaidy/openwrt-actions/actions/workflows/amd64.yml/badge.svg)](https://github.com/chencaidy/openwrt-actions/actions/workflows/amd64.yml) | [![Link](https://img.shields.io/badge/Download-MEGA-blue)](https://mega.nz/folder/yFc3RY5Q#Qtbwdfx7PW0vNC-FuuLlnQ/folder/LEliFBiK)

## Description

* `config` Device specific config
* `patches` A simple OpenWrt patchset
* `openwrt_env.sh` Configure local environment
* `openwrt_update.sh` Update source code and patch
* `openwrt_build.sh` Build wizard

## Manually build

1. Cleanly install Ubuntu 20.04
2. Clone actions repo and enter workspace
3. Setup environment: `./openwrt_env.sh`
4. Update source code: `./openwrt_update.sh`
5. Build: `./openwrt_build.sh`
6. Choose a target device in whiptail dialog

## Credit

* [Project ImmortalWrt](https://github.com/immortalwrt/immortalwrt)
* [OpenWrt Project](https://github.com/openwrt/openwrt)
* [Jerrykuku 老竭力](https://github.com/jerrykuku)
* [Vernesong](https://github.com/vernesong)
