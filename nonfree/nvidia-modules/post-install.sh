#!/bin/sh
	if [ -f /lib/modules/KERNELVERSION ]; then
		kernver=$(cat /lib/modules/KERNELVERSION)
	else
		kernver=$(uname -r)
	fi
	depmod $kernver
