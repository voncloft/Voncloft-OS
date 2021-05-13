url=http://www.sudo.ws/dist/
name=sudo
file=index.html
echo $name
cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi

grep -Po "(?<=>)[^<>]*(?=<)" $file | grep -v : | tr '[:upper:]' '[:lower:]' | grep $name- | grep -v sig | grep -v patch  >> test.txt

###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
sed -i -e 's/sudo-//g' test.txt
sed -i -e 's/.tar.gz//g' test.txt

###beta###
#cat test.txt | sort -V -r | head -n 1

###Production###
if [ -f $file ];
then
echo $name >> stripped_info.txt
cat test.txt | sort -V -r | head -n 1 >> stripped_info.txt
fi
rm -v *.html
rm -v *.html.*
