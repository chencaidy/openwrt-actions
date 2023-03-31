#!/bin/bash

echo -e "\033[32;1m==> Update environment \033[0m"

sudo apt-get update
sudo apt-get -y install antlr3 asciidoc autoconf automake autopoint binutils build-essential bzip2 ccache curl device-tree-compiler flex g++-multilib gawk gcc-multilib gettext git gperf libc6-dev-i386 libelf-dev libglib2.0-dev libncurses5-dev libssl-dev libtool msmtp p7zip p7zip-full patch python2.7 python3 qemu-utils rsync subversion swig texinfo uglifyjs unzip upx-ucl wget xmlto zlib1g-dev

