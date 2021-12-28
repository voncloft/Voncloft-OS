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
#wget $download_link_capital
###get non capital shit
grep -i "href" $file | grep .tar.gz | grep -Po '(?<=href=")[^"]*' > url.txt
#rm -rfv $file

#get capital shit - seriously python what the fuck are you thinking not having a uniformed website.

#wget $download_link_capital
#grep -i "href" $file | grep .tar.gz | grep -Po '(?<=href=")[^"]*' > url.txt
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

geturl="cat url.txt | head -n 1 |  sed 's/\//\\\\\//g'" 
#eval $command
#eval $geturl
size=$(eval $geturl)
new_repo=$(eval $geturl)
check=${#size}


get_repo_url="grep source /Voncloft-OS/python/python-$1/spkgbuild | sed 's/source=//g' | sed 's/\"//g' | sed 's/\//\\\\\//g'"
my_repo=$(eval $get_repo_url)

#eval $get_repo_url
echo "Check: " $check


echo "My url: "  $my_repo
echo "New url: " $new_repo
echo "Command to be ran"

#get_directory=
if [ $check -ge 1 ];
then
##Production###
	if [ -f $file ];
	then
		#echo python-$1 >> python_url.txt
		#eval $geturl >> python_url.txt
		#sed -i -e 's/$my_repo/$new_repo/g' /Voncloft-OS/python/python-$1/spkgbuild
		echo "sed -i -e 's/$my_repo/$new_repo/g' /Voncloft-OS/python/python-$1/spkgbuild"
		sed -i -e "s/$my_repo/$new_repo/g" /Voncloft-OS/python/python-$1/spkgbuild
		echo "new url written"
		###Find way to change cd command
		#######changelog python-$1 "Fixed URL"
		sed -i -e 's/cd ${name#python-}-$version/cd */g' /Voncloft-OS/python/python-$1/spkgbuild
		#changelog python-$1 "Fixed URL and directory install"

		rm -v $file
		rm -v $file.*
	fi
fi

