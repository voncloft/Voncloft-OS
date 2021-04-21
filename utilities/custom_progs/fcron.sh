url=http://fcron.free.fr/allarchives.php
name=fcron

cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi

grep -Po "(?<=>)[^<>]*(?=<)" allarchives.php | tr '[:upper:]' '[:lower:]' | grep $name | grep -v : | grep -v linux | grep -v web | grep -v run  >> test.txt
#grep _ index.html | grep -Po "(?<=>)[^<>]*(?=<)" >> test.txt

###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
sed -i -e '/rpm/d' test.txt
sed -i -e '/src/d' test.txt
sed -i -e 's/fcron //g' test.txt
#sed -i -e "/$name/d" test.txt
###beta###

#cat test.txt  | sort -V -r | head -n 1

###Production###
echo $name >> stripped_info.txt
cat test.txt | sort -V -r | head -n 1 >> stripped_info.txt

rm -v *.html
rm -v *.html.*
rm -v *.php
rm -v *.php.*
