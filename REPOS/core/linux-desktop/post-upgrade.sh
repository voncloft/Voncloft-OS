#!/bin/sh
#kernel_version=$(ls /usr/lib/modules)
grub-mkconfig -o /boot/grub/grub.cfg
version=$(cat /etc/LINUX_VERSION)
#virtualbox modules
cd /usr/src/virtual*
KER_VER=$version make
KER_VER=$version make install

#virtualbox
sudo dkms install -m nvidia -v $version
#sudo scratch install -rc nvidia-modules nvidia nvidia-32 virtualbox-modules
#sudo dkms autoinstall -k $kernel_version
#cd /usr/src/vbox*
#make
#make install
