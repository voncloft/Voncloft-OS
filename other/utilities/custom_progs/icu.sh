url=https://github.com/unicode-org/icu/tags
name=icu
file=tags
echo $name
cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi

###show url in tags
grep -i "href" $file | grep .tar.gz | grep -v cldr | grep -Po '(?<=href=")[^"]*' > test.txt

###to get rid of <> tags in html
#grep -Po "(?<=>)[^<>]*(?=<)" $file | grep "tar.gz"  > test.txt

###return only numbers
#grep -E -o '\<[0-9]{1,2}\.[0-9]{2,5}\>' $file >> test.txt

#####more efficient to get version numbers
#egrep -o "([0-9]{1,}\.)+[0-9]{1,}" $file > test.txt

###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
sed -i -e "s/release-//g" test.txt
sed -i -e 's/.tar.gz//g' test.txt

#sed -i -e 's/.tar.bz2//g' test.txt
#sed -i -e '/stable/d' test.txt
#sed -i -e "/$name/d" test.txt
#sed -i -e "s/v//g" test.txt
#sed -i -e 's/v//g' test.txt

###beta###
command="cat test.txt"
final=$(eval $command | head -n 1)
echo ${final##*/}
size=$(eval $command)

check=${#size}

if [ $check -ge 1 ];
then
	##Production###
	#if [ -f $file ];
	#then
		echo $name >> stripped_info.txt
		echo ${final##*/} >> stripped_info.txt
		rm -v $file
	#fi
fi
