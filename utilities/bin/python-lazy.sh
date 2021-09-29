for f in /Voncloft-OS/python/*;
do
	filename=${f##*/}
	sh python-url.sh ${filename#python-}
	
done
