cd /var/log/old
wget https://archive.mozilla.org/pub/security/nss/releases/
if [ -f test.txt ];
then
	rm test.txt
fi
grep -Po "(?<=>)[^<>]*(?=<)" index.html | grep -v : | tr '[:upper:]' '[:lower:]' | grep -v dir | grep nss | grep -v index >> test.txt
sed -i -e 's/nss_//g' test.txt
sed -i -e 's/_rtm\///g' test.txt
sed -i -e 's/_/./g' test.txt
echo "nss" >> stripped_info.txt
cat test.txt | sort -n -r | head -n 1 >> stripped_info.txt
rm -v *.html
rm -v *.html.*
