name=$1
url=https://pypi.org/project/$name/#history
url_capital=https://pypi.org/project/${name^}/#history
file=index.html

echo $name
cd /var/log/old

rm -rfv $file

#GRAB WEBSITE
wget $url
#wget $url_capital
if [ -f test.txt ];
then
	rm test.txt
fi

###to get rid of <> tags in html
#grep -Po "(?<=>)[^<>]*(?=<)" $file | grep -v : | tr '[:upper:]' '[:lower:]' | grep $name | egrep -o "([0-9]{1,}\.)+[0-9]{1,}" > test.txt
grep -i $name $file | grep "card release__card" | egrep -o "([0-9]{1,}\.)+[0-9]{1,}" > test.txt
#rm -rfv $file

#wget $url_capital
#grep -i $name $file | grep "card release__card" | egrep -o "([0-9]{1,}\.)+[0-9]{1,}" > test.txt
#rm -rfv $file
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
command="cat test.txt | sort -V -r | head -n 1"
#command="cat test.txt | sort -V -r"

size=$(eval $command)

check=${#size}
echo "Check: " $check
#rm -rfv $file
#rm -rfv $file.*
eval $command
if [ $check -ge 1 ];
then
##Production###
	if [ -f $file ];
	then
		echo python-$1 >> stripped_info.txt
		eval $command >> stripped_info.txt
		#rm -v $file
	fi
fi
rm -rfv $file

#rm -rfv $file
#rm -rfv $file.*
