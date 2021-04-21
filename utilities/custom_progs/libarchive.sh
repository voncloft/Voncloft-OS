url=https://github.com/libarchive/libarchive/releases/
name=libarchive

cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi

grep -Po "(?<=>)[^<>]*(?=<)" index.html | grep -v : | tr '[:upper:]' '[:lower:]' | grep $name | grep -v .sig >> test.txt

###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
sed -i -e "s/$name-//g" test.txt
sed -i -e 's/.tar.gz//g' test.txt
sed -i -e 's/.tar.bz2//g' test.txt
sed -i -e '/stable/d' test.txt
sed -i -e 's/-win64.zip.asc//g' test.txt
sed -i -e "/$name/d" test.txt
sed -i -e 's/-win64.zip//g' test.txt
###beta###
#cat test.txt | sort -V -r | head -n 1 | sed 's/v//g'

###Production###
echo $name >> stripped_info.txt
cat test.txt | sort -V -r | head -n 1 | sed 's/v//g' >> stripped_info.txt

rm -v *.html
rm -v *.html.*
