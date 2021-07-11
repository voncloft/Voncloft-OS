name=
url=https://www.cpan.org/modules/01modules.index.html
file=01modules.index.html
echo $name
cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi

###to get rid of <> tags in html
grep -Po "(?<=>)[^<>]*(?=<)" $file | grep -v : | tr '[:upper:]' '[:lower:]' | grep tar.gz > test.txt

###return only numbers
#grep -E -o '\<[0-9]{1,2}\.[0-9]{2,5}\>' $file >> test.txt

#####more efficient to get version numbers
#egrep -o "([0-9]{1,}\.)+[0-9]{1,}" $file > test.txt

###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
#sed -i -e "s/$name-//g" test.txt
sed -i -e 's/.tar.gz//g' test.txt
#sed -i -e 's/.tar.bz2//g' test.txt
#sed -i -e '/stable/d' test.txt
#sed -i -e "/$name/d" test.txt
#sed -i -e "s/v//g" test.txt
#sed -i -e 's/v//g' test.txt
sed -i -e 's/^/perl-/' test.txt
sed -i -e 's/-0/\n0/g' test.txt
sed -i -e 's/-1/\n1/g' test.txt
sed -i -e 's/-2/\n2/g' test.txt
sed -i -e 's/-3/\n3/g' test.txt
sed -i -e 's/-4/\n4/g' test.txt
sed -i -e 's/-5/\n5/g' test.txt
sed -i -e 's/-6/\n6/g' test.txt
sed -i -e 's/-7/\n7/g' test.txt
sed -i -e 's/-8/\n8/g' test.txt
sed -i -e 's/-9/\n9/g' test.txt

sed -i -e 's/-v0/\n0/g' test.txt
sed -i -e 's/-v1/\n1/g' test.txt
sed -i -e 's/-v2/\n2/g' test.txt
sed -i -e 's/-v3/\n3/g' test.txt
sed -i -e 's/-v4/\n4/g' test.txt
sed -i -e 's/-v5/\n5/g' test.txt
sed -i -e 's/-v6/\n6/g' test.txt
sed -i -e 's/-v7/\n7/g' test.txt
sed -i -e 's/-v8/\n8/g' test.txt
sed -i -e 's/-v9/\n9/g' test.txt

###beta###
command="cat test.txt"
eval $command

##Production###
if [ -f $file ];
then
#	echo $name >> stripped_info.txt
	eval $command >> stripped_info.txt
	rm -v $file
fi


