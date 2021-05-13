url=https://archive.mozilla.org/pub/nspr/releases/
name=nspr
echo $name
cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi

grep -Po "(?<=>)[^<>]*(?=<)" index.html | grep -v : | tr '[:upper:]' '[:lower:]' | grep -v dir | grep -v index | grep "v" >> test.txt

###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
sed -i -e 's/v//g' test.txt
sed -i -e 's/\///g' test.txt

###beta###
#cat test.txt | sort -V -r | head -n 1

###Production###
echo $name >> stripped_info.txt
cat test.txt | sort -V -r | head -n 1 >> stripped_info.txt

rm -v *.html
rm -v *.html.*
