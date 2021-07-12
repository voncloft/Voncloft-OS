name=$1
download_link=https://pypi.org/project/$name/#files
download_link_capital=https://pypi.org/project/${name^}/#files
file=index.html

echo $name
cd /var/log/old

rm -rfv $file
rm -rfv $file.*

if [ -f test.txt ];
then
	rm test.txt
fi

###to get rid of <> tags in html
#grep -Po "(?<=>)[^<>]*(?=<)" $file | grep -v : | tr '[:upper:]' '[:lower:]' | grep $name | egrep -o "([0-9]{1,}\.)+[0-9]{1,}" > test.txt
#grep -i $name $file | grep "card release__card" | egrep -o "([0-9]{1,}\.)+[0-9]{1,}" > test.txt

#rm -rfv $file
#rm -rfv $file.*
wget $download_link
wget $download_link_capital

grep -i "href" $file | grep .tar.gz | grep -Po '(?<=href=")[^"]*' > url.txt
###return only numbers
#grep -E -o '\<[0-9]{1,2}\.[0-9]{2,5}\>' $file >> test.txt

#####more efficient to get version numbers
#egrep -o "([0-9]{1,}\.)+[0-9]{1,}" $file > test.txt

###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
#sed -i -e "s/$name-//g" test.txt
#sed -i -e 's/.tar.gz//g' test.txt
#sed -i -e 's/.tar.bz2//g' test.txt
#sed -i -e '/stable/d' test.txt
#sed -i -e "/$name/d" test.txt
#sed -i -e "s/v//g" test.txt
#sed -i -e 's/v//g' test.txt

###beta###

geturl="cat url.txt | head -n 1" 
#eval $command
eval $geturl
size=$(eval $geturl)
check=${#size}

if [ $check -ge 1 ];
then
##Production###
	if [ -f $file ];
	then
		echo python-$1 >> python_url.txt
		eval $geturl >> python_url.txt
		rm -v $file
		rm -v $file.*
	fi
fi

