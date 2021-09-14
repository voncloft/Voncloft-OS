#!/bin/sh
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
	echo "Ignoring: $ignoring"
	echo ""
	get_url $1
	echo "URL:       $url_finalized"
	echo "Filename:  $name"
	echo "Version:   $version"
	fetch

	
}
ignoring="kf5 plasma kde-apps python perl"
main $@
