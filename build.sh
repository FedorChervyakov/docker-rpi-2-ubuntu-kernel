#!/bin/bash

cd /workspace/src
mkdir -p /workspace/out
export CC=arm-linux-gnueabihf-gcc
export $(dpkg-architecture -aarmhf); export CROSS_COMPILE=arm-linux-gnueabihf-
fakeroot debian/rules clean
fakeroot debian/rules binary-headers binary binary-perarch
mv ../*.deb ../out/
echo "Done ;-)"
