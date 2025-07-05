#!/bin/sh
#kernel_version=$(ls /usr/lib/modules)
grub-mkconfig -o /boot/grub/grub.cfg
version=$(cat /lib/modules/KERNELVERSION)
#virtualbox modules
cd /usr/src/vbox*
KERN_DIR=/lib/modules/$version/build KER_VER=$version make
KERN_DIR=/lib/modules/$version/build KER_VER=$version make install

#virtualbox
sudo dkms install -m nvidia -k $version
#sudo scratch install -rc nvidia-modules nvidia nvidia-32 virtualbox-modules
#sudo dkms autoinstall -k $kernel_version
#cd /usr/src/vbox*
#make
#make install
