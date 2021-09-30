#!/bin/sh
cd /Voncloft-OS
for f in python/*/spkgbuild;
do
#echo "$f"
if grep -q "github" "$f"; then
	if grep -q "tar.gz" $f; then
	
	echo $f
	source "$f"
	url="https://github.com/$(echo $source |  cut -d / -f4,5)/tags/"
	wget $url -O index.html -q
        uversion=$(grep -Eio [0-9a-z.]+.tar.[bgx]z2? index.html \
                                | sed "s/.tar.*//g"     \
                                | sort -V -r \
                                | egrep -o "([a-z])" \
                                | uniq \
                                | head -n1)
        url=$(echo $url | cut -d / -f1-5)/archive/refs/tags/$uversion\$version.tar.gz
        echo $url
	sed -i -e "s,$source,$url,g" $f
fi
fi
done
