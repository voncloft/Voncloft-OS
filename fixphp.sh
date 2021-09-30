#!/bin/sh
cd /Voncloft-OS
for f in python/*/spkgbuild;
do
#echo "$f"
if grep -q "github" "$f"; then
	#echo $f
	source "$f"
	#echo "New Version: https://github.com/python-trio/async_generator/archive/refs/tags/"
	url="New Version https://github.com/$(echo $source |  cut -d / -f4,5)/tags/"
	echo $url
fi
done
#https://github.com/python-trio/async_generator/archive/refs/tags/
