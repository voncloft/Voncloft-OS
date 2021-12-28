url=https://www.x.org/archive/individual/
#name=
file=index.html

cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi

###to get rid of <> tags in html
grep "folder.gif" index.html | grep -Po "(?<=>)[^<>]*(?=<)" | grep -v : | tr '[:upper:]' '[:lower:]' >> test.txt

###return only numbers
#grep -E -o '\<[0-9]{1,2}\.[0-9]{2,5}\>' download.jsp >> test.txt

#####more efficient to get version numbers
####egrep -o "([0-9]{1,}\.)+[0-9]{1,}" download.jsp >> test.txt

###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
sed -i -e "/nbsp/d" test.txt
sed -i -e "/-/d" test.txt


###beta###
lines=$(cat test.txt)
while IFS=$'\/' read -ra items; do
	#echo $url$items
	wget $url$items
	 grep -Po "(?<=>)[^<>]*(?=<)" $items  | grep -v : | tr '[:upper:]' '[:lower:]' | grep tar.gz | sort -V -r >> $items.txt
done <<< $lines
##Production###
#if [ -f $file ];
#then
#	echo $name >> stripped_info.txt
#	cat test.txt | sort -V -r | head -n 1 >> stripped_info.txt
#	rm -v $file
#fi


