#!/bin/sh
#kernel_version=$(ls /usr/lib/modules)
grub-mkconfig -o /boot/grub/grub.cfg
#sudo scratch install -rc nvidia-modules nvidia nvidia-32 virtualbox-modules
#sudo dkms autoinstall -k $kernel_version
cd /usr/src/vbox*
make
make install
