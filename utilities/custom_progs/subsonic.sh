url=http://www.subsonic.org/pages/download.jsp
name=subsonic
echo $name
cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi
###to get rid of <> tags in html
#grep -Po "(?<=>)[^<>]*(?=<)" index.html | grep -v : | tr '[:upper:]' '[:lower:]' >> test.txt

###return only numbers
#grep -E -o '\<[0-9]{1,2}\.[0-9]{2,5}\>' download.jsp >> test.txt

#####more efficient
egrep -o "([0-9]{1,}\.)+[0-9]{1,}" download.jsp >> test.txt

###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
#sed -i -e "s/$name-//g" test.txt
#sed -i -e 's/.tar.gz//g' test.txt
#sed -i -e 's/.tar.bz2//g' test.txt
#sed -i -e '/stable/d' test.txt
#sed -i -e "/$name/d" test.txt
###beta###
cat test.txt | sort -V -r | head -n 1

##Production###
if [ -f download.jsp ];
then
	echo $name >> stripped_info.txt
	cat test.txt | sort -V -r | head -n 1 >> stripped_info.txt
fi
rm -v *.html
rm -v *.html.*
rm -v *.jsp
rm -v *.jsp.*
