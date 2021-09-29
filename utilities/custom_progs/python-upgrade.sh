#!/bin/sh

for f in /Voncloft-OS/python/*; 
do
	#./python-packages.sh ${f##*/};
	filename=${f##*/}
	#$filename=$f
	final=${filename#python-}
	
	sh /Voncloft-OS/utilities/bin/python-packages.sh $final
	sh /Voncloft-OS/utilities/bin/python-url.sh $final
done
