# docker-rpi-ubuntu-kernel

Image to cross-build the Ubuntu kernel for the Raspberry Pi 2. See this https://forums.raspberrypi.com/viewtopic.php?f=131&t=284556&p=1734458#p1734458

## Usage

From the host:

```
mkdir workspace
cd workspace
git clone https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux-raspi/+git/focal src
```

Now you can build and configure the kernel in the container:

```
docker build -t rpi_kernel .
docker run --rm -it --name builder -v $PWD/workspace:/workspace rpi_kernel:latest /bin/bash
```

Then, in the container:

```
cd /workspace/src
mkdir -p /workspace/out
export CC=arm-linux-gnueabihf-gcc
export $(dpkg-architecture -aarmhf); export CROSS_COMPILE=arm-linux-gnueabihf-
fakeroot debian/rules clean
fakeroot debian/rules editconfigs
fakeroot debian/rules binary-headers binary binary-perarch skipmodule=true skipabi=true
mv ../*.deb ../out/
```

in workspace/out you should get the packages to install in your pi:

```
$ ls -lh workspace/out/
total 55M
-rw-r--r-- 1 root root 787K 21 ago 00.35 linux-buildinfo-5.11.0-1016-raspi_5.11.0-1016.17_arm64.deb
-rw-r--r-- 1 root root 1,3M 21 ago 00.35 linux-headers-5.11.0-1016-raspi_5.11.0-1016.17_arm64.deb
-rw-r--r-- 1 root root 9,6M 21 ago 00.35 linux-image-5.11.0-1016-raspi_5.11.0-1016.17_arm64.deb
-rw-r--r-- 1 root root  31M 21 ago 00.35 linux-modules-5.11.0-1016-raspi_5.11.0-1016.17_arm64.deb
-rw-r--r-- 1 root root  12M 20 ago 23.49 linux-raspi-headers-5.11.0-1016_5.11.0-1016.17_arm64.deb
```
