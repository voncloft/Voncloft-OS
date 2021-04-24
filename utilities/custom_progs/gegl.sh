url=https://download.gimp.org/pub/gegl/
name=gegl
file=index.html

cd /var/log/old

#GRAB WEBSITE
wget $url

if [ -f test.txt ];
then
	rm test.txt
fi

###custom commmands
sed -i -e '/Apache/d' $file
sed -i -e '/PUBLIC/d' $file

#####more efficient to get version numbers
egrep -o "([0-9]{1,}\.)+[0-9]{1,}" $file >> test.txt

###beta###
latest=$(cat test.txt | sort -V -r | head -n 1)
#cat test.txt | sort -V -r 
rm $file
wget $url$latest

sed -i -e '/Apache/d' $latest
sed -i -e '/PUBLIC/d' $latest
rm -v test.txt

egrep -o "([0-9]{1,}\.)+[0-9]{1,}" $latest | grep 0. >> test.txt
cat test.txt | sort -V -r | head -n 1 >> test.txt
 
##Production###
#if [ -f $file ];
#then
	echo $name >> stripped_info.txt
	cat test.txt | sort -V -r | head -n 1 >> stripped_info.txt
	rm -v $file
	rm -v test.txt
	rm -v $latest
	rm -v $latest.*
#fi


