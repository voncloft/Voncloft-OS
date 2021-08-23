url=https://www.rust-lang.org/
name=Rust
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
grep -i "href" $file | grep $name | grep -Po '(?<=href=")[^"]*' > test.txt

###to get rid of <> tags in html
#grep -Po "(?<=>)[^<>]*(?=<)" $file > test.txt

###return only numbers
#grep -E -o '\<[0-9]{1,2}\.[0-9]{2,5}\>' $file >> test.txt

#####more efficient to get version numbers
#egrep -o "([0-9]{1,}\.)+[0-9]{1,}" $file > test.txt

###CUSTOM COMMANDS FOR WEBSITE STRIPPING###
sed -i -e "s/https:\/\/blog.rust-lang.org\///g" test.txt
sed -i -e "s/http:\/\/forge.rust-lang.org\///g" test.txt
#sed -i -e 's/.tar.gz//g' test.txt
#sed -i -e 's/.tar.bz2//g' test.txt
#sed -i -e '/stable/d' test.txt
#sed -i -e "/$name/d" test.txt
#sed -i -e "s/v//g" test.txt
#sed -i -e 's/v//g' test.txt

###beta###
command='cat test.txt | head -n 1'
output=$(eval $command)
echo $output
date_output=$(echo "$output" | cut -f 1-3  -d/ | sed "s/\//-/g" )
echo $date_output



scratchpkg_rust=$(grep "date=" /Voncloft-OS/compilers/rust/spkgbuild | sed "s/_date=//g")
echo $scratchpkg_rust
size=$(eval $command)

check=${#size}

if [ $check -ge 1 ];
then
	##Production###
	#if [ -f $file ];
	#then
	#	echo $name >> stripped_info.txt
	#	eval $command >> stripped_info.txt
	#	rm -v $file
	
	#fi
	#Fix the date
	sed -i -e "s/$scratchpkg_rust/$date_output/g"  /Voncloft-OS/compilers/rust/spkgbuild
fi
