url=https://github.com/eqrion/cbindgen/releases
name=cbindgen
file=releases

cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi

###to get rid of <> tags in html
grep -Po "(?<=>)[^<>]*(?=<)" $file | grep -v : | tr '[:upper:]' '[:lower:]' | grep v | egrep -o "([0-9]{1,}\.)+[0-9]{1,}" > test.txt

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
command="cat test.txt | sort -r -V | head -n 1"
eval $command


##Production###
#if [ -f $file ];
#then
#	echo $name >> stripped_info.txt
#	#cat test.txt | sort -V -r | head -n 1 | sed 's/v//g' >> stripped_info.txt
#	eval $command >> stripped_info.txt
#	rm -v $file
#fi


