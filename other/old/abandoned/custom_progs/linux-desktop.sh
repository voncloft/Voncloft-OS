url=https://www.kernel.org/
name=linux
file=index.html
echo $name
cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi

###show url in tags
#grep -i "href" $file | grep .tar.gz | grep -Po '(?<=href=")[^"]*' > test.txt

###to get rid of <> tags in html
#grep -Po "(?<=>)[^<>]*(?=<)" $file > test.txt

###return only numbers
#grep -E -o '\<[0-9]{1,2}\.[0-9]{2,5}\>' $file >> test.txt

#####more efficient to get version numbers
#egrep -o "([0-9]{1,}\.)+[0-9]{1,}" $file > test.txt

grep "stable" $file | egrep -o "([0-9]{1,}\.)+[0-9]{1,}" > test.txt
###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
#sed -i -e "s/$name-//g" test.txt
#sed -i -e 's/.tar.gz//g' test.txt
#sed -i -e 's/.tar.bz2//g' test.txt
#sed -i -e '/stable/d' test.txt
#sed -i -e "/$name/d" test.txt
#sed -i -e "s/v//g" test.txt
#sed -i -e 's/v//g' test.txt

###beta###
command="cat test.txt | sort -V -r | head -n 1"
eval $command
size=$(eval $command)

check=${#size}

if [ $check -ge 1 ];
then
	##Production###
	#if [ -f $file ];
	#then
		echo $name-desktop >> stripped_info.txt
		eval $command >> stripped_info.txt
		rm -v $file
		rm -rv $file.*
	#fi
fi
