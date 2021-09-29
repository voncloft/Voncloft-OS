url=https://www.cpan.org/modules/01modules.index.html
name=
file=01modules.index.html

echo $name
cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi

#show url in tags
grep -i "href" $file | grep .tar.gz | grep -Po '(?<=href=")[^"]*' > perl_packages.txt
sed -i -e "s/\.\.\//https:\/\/www.cpan.org\//g"  perl_packages.txt
###to get rid of <> tags in html
#grep -Po "(?<=>)[^<>]*(?=<)" $file | grep -v : | tr '[:upper:]' '[:lower:]' | grep $name > test.txt

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
#command="cat perl_url.txt"
#eval $command
#size=$(eval $command)

#check=${#size}
#for f in /Voncloft-OS/perl/*;
#do
#	if  [[ ${f##*/} != "perl" ]];
#	then
#		echo ${f##*/} >> on_hand.txt
#	fi
#done


if [ -f $file ];
then	
	input=perl_packages.txt
	while IFS= read -r line
	do
	word=${line##*/}
        remove_substring=${word##*-}
        path_test=$(echo /Voncloft-OS/perl/perl-$word | sed "s/-$remove_substring//g" | tr '[:upper:]' '[:lower:]' | sed "s/voncloft-os/Voncloft-OS/g" )
	
	#echo $path_test
	if [ -d "$path_test" ] && [ $path_test != "/Voncloft-OS/perl/perl" ];
	then
		word=${line##*/}
		remove_substring=${word##*-}
		#echo $word | tr '[:upper:]' '[:lower:]'
		echo perl-$word | sed "s/-$remove_substring//g" | tr '[:upper:]' '[:lower:]' >> stripped_info.txt
		echo $remove_substring | sed "s/\.tar\.gz//g" | sed "s/\.tgz//g" >> stripped_info.txt
		#echo $line
		echo $path_test
		my_version=$(grep source $path_test/spkgbuild | sed 's/source=//g' | sed 's/\"//g' | sed 's/\//\\\//g')
		echo "My URL: " $my_version
		new_version=$(echo $line | sed 's/\//\\\//g')
		echo "New URL: " $new_version
		#echo 'sed -i -e s/'$my_version'/'$new_version'/g '$path_test/spkgbuild
		sed -i -e "s/$my_version/$new_version/g" $path_test/spkgbuild
	fi
	done < $input
fi
