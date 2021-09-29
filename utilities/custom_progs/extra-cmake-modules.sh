url=https://download.kde.org/stable/frameworks/
name=extra-cmake-modules

echo $name
cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi

#grep -Po "(?<=>)[^<>]*(?=<)" index.html | grep -v : | tr '[:upper:]' '[:lower:]' >> test.txt

grep -E -o '\<[0-9]{1,2}\.[0-9]{2,5}\>' index.html >> test.txt

###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
#sed -i -e "s/$name-//g" test.txt
#sed -i -e 's/.tar.gz//g' test.txt
#sed -i -e 's/.tar.bz2//g' test.txt
#sed -i -e '/stable/d' test.txt
#sed -i -e "/$name/d" test.txt
###beta###
cat test.txt | sort -V -r | head -n 1

###Production###
if [ -f index.html ];
then
	echo $name >> stripped_info.txt
	cat test.txt | sort -V -r | head -n 1 >> stripped_info.txt
fi
rm -v *.html
rm -v *.html.*
