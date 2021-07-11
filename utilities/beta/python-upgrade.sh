#!/bin/sh

for f in /Voncloft-OS/python/*; 
do
	#./python-packages.sh ${f##*/};
	filename=${f##*/}
	#$filename=$f
	final=${filename#python-}
	./python-packages.sh $final
done
