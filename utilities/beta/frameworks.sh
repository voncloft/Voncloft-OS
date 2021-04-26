url=https://download.kde.org/stable/frameworks/
#name=
file=index.html

cd /var/log/old

#GRAB WEBSITE
wget $url
#rm -v index.html
if [ -f test.txt ];
then
	rm test.txt
fi

###to get rid of <> tags in html
#grep -Po "(?<=>)[^<>]*(?=<)" index.html | grep -v : | tr '[:upper:]' '[:lower:]' >> test.txt

###return only numbers
#grep -E -o '\<[0-9]{1,2}\.[0-9]{2,5}\>' download.jsp >> test.txt

#####more efficient to get version numbers
egrep -o "([0-9]{1,}\.)+[0-9]{1,}" $file >> test.txt

###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
#sed -i -e "s/$name-//g" test.txt
#sed -i -e 's/.tar.gz//g' test.txt
#sed -i -e 's/.tar.bz2//g' test.txt
#sed -i -e '/stable/d' test.txt
#sed -i -e "/$name/d" test.txt

###beta###
latest=$(cat test.txt | sort -V -r | head -n 1)
#rm -v index.html
echo $latest
echo $url$latest
wget $url$latest

#grep -Po "(?<=>)[^<>]*(?=<)" $latest | grep -v : | tr '[:upper:]' '[:lower:] | grep tar'


###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
#sed -i -e 's/&nbsp//g' $latest

#grep -e "tar.xz" $latest | grep -Po "(?<=>)[^<>]*(?=<)" | grep -v sig | grep "tar.xz" | sed "s/-$latest/\n$latest/g" | sed 's/.tar.xz//g'
wget "$url$latest/portingAids"


#grep -e "tar.xz" portingAids | grep -Po "(?<=>)[^<>]*(?=<)" | grep -v sig | grep "tar.xz" | sed "s/-$latest/\n$latest/g" | sed 's/.tar.xz//g'
##Production###
if [ -f $latest ];
then
	grep "tar.xz" $latest | grep -Po "(?<=>)[^<>]*(?=<)" | grep -v sig | grep "tar.xz" | sed 's/-5/\n5/g' | sed 's/.tar.xz//g' >> stripped_info.txt
	grep -e "tar.xz" portingAids | grep -Po "(?<=>)[^<>]*(?=<)" | grep -v sig | grep "tar.xz" | sed "s/-$latest/\n$latest/g" | sed 's/.tar.xz//g' >> stripped_info.txt
	rm -v $latest
	rm -v $latest.*
	rm -v index.html
	rm -v portingAids
	rm -v portingAids.*
	rm -v index.html.*
fi


