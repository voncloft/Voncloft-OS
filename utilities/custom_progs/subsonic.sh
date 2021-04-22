url=http://www.subsonic.org/pages/download.jsp
name=subsonic

cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi

#grep -Po "(?<=>)[^<>]*(?=<)" download.jsp | grep $name | grep -v : | tr '[:upper:]' '[:lower:]' >> test.txt
#grep $name download.jsp | grep -Po "(?<=>)[^<>]*(?=<)" >> test.txt

grep '<td><a href="download2' download.jsp >> test.txt
###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
sed -i -e 's/                            <td><a href="download2.jsp?target=subsonic-//g' test.txt
sed -i -e 's/-setup.exe"//g' test.txt
sed -i -e 's/.pkg"//g' test.txt
sed -i -e 's/.deb"//g' test.txt
sed -i -e 's/.rpm"//g' test.txt
sed -i -e 's/-standalone.tar.gz"//g' test.txt
sed -i -e 's/-war.zip"//g' test.txt
###beta###
#cat test.txt

###Production###
echo $name >> stripped_info.txt
cat test.txt | sort -V -r | head -n 1 >> stripped_info.txt

rm -v *.html
rm -v *.html.*
rm -v *.jsp
rm -v *.jsp.*
