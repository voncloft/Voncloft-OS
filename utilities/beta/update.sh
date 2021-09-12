#!/bin/bash
#use in /testing/Voncloft-OS


get_url()
{
	url=$(grep "source" $1 | sed 's/source=//g' | sed 's/\"//g')
}
get_version()
{
	version=$(grep "version=" $1 | sed 's/version=//' )
}
modify_url()
{
	modified_url_withname="${url//\$name/$1}"
	final_version="${modified_url_withname//\$version/$version}"
}
main()
{
	
	get_url $1
	get_version $1
	modify_url $2
	#echo $modified_url_withname
	echo $final_version
}
main $@
