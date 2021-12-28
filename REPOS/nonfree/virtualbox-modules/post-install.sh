#!/bin/sh
	if [ -f /lib/modules/KERNELVERSION ]; then
		kernver=$(cat /lib/modules/KERNELVERSION)
	else
		kernver=$(file /boot/vmlinuz-venom  | cut -d ' ' -f9)
	fi
	depmod $kernver
