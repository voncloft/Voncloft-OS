#!/bin/sh
vercomp() {
        if [ "$1" = "$2" ]; then
                return 0 # same version
		echo "0"
        #elif [ "$1" = "$(echo "$1\n$2" | sort -V | head -n1)" ]; then
        elif [ "$(printf '%s\n' "$1" "$2" | sort -V | head -n1)" = "$1" ]; then
                return 1 # $1 lower than $2
                echo "1"
        else
                return 2 # $1 higher than $2
                echo "2"
        fi
}
get_url()
{
	source $1
	url="${source[0]}"
	url_finalized=$(echo $url | cut -d ' ' -f1 | sed 's|\(.*\)/.*|\1|')/
	
}
fetch() {
	echo $PWD
        wget $url_finalized
        echo "wget $url_finalized"
}
main()
{
	rm index.html
	uversion="7.0"
	echo "Ignoring: $ignoring"
	echo ""
	get_url $1
	echo "URL:       $url_finalized"
	echo "Filename:  $name"
	echo "Version:   $version"
	echo "Upgraded:  $uversion"
	fetch
        #find upgraded version from fetch code compare and then upgrade package using uversion as variable name
        if [ "$uversion" != "$version" ];
        then
        	vercomp $uversion $version
        	if [ $? = 2 ]; then
        		#do things
        		echo "NEW"
        	elif [ $? = 1 ];then
        		echo "OLD"
        	else
        		echo "Same"
        	fi
        fi
}
ignoring="kf5 plasma kde-apps python perl"
main $@
