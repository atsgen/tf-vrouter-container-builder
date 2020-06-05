#!/bin/bash
# Copyright (c) 2020 ATSgen, all rights reserved
#

kver=$(uname -r)
if [ -f "/lib/modules/$kver/kernel/net/vrouter/vrouter.ko" ]; then
  echo "vrouter kernel already available, skipping build"
  exit 0
fi
cd /vrouter_src
make
mkdir -p /lib/modules/$kver/kernel/net/vrouter/
cp -f vrouter.ko /lib/modules/$kver/kernel/net/vrouter/
depmod -a $kver
