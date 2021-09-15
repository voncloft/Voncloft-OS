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
	#url_finalized=$(echo $url | cut -d ' ' -f1 | sed 's|\(.*\)/.*|\1|')/
	url=$(echo $url | cut -d ' ' -f1 | sed 's|\(.*\)/.*|\1|')/
}
fetch() {
	#echo $PWD
        wget $url
        echo "wget $url"
}
alter_per_url() {
        case $url in
                *github.com*)
                        url=https://github.com/$(echo $url | cut -d / -f4,5)/tags;;
                *downloads.sourceforge.net*)
                        url="https://sourceforge.net/projects/$(echo $url | cut -d / -f4)/rss?limit=200";;
                *sourceforge.net*)
                        url="https://sourceforge.net/projects/$(echo $url | cut -d / -f5)/rss?limit=200";;
                *gitlab.com*)
                        url=$(echo $url | cut -d/ -f1-5)/tags;;
                *python.org*|*pypi.org*|*pythonhosted.org*|*pypi.io*|*pypi.org*)
                        url=https://pypi.org/simple/${name#python-};;
                *rubygems.org*)
                        url=https://rubygems.org/gems/${name/ruby-/};;
                *launchpad.net*)
                        url=https://launchpad.net/$(echo $url | cut -d / -f4)/+download;;
                *ftp.gnome.org*)
                        url=https://ftp.gnome.org/pub/gnome/sources/$filename/cache.json;;
                *archive.xfce.org*)
                        url=http://archive.xfce.org/src/$(echo $url | cut -d / -f5)/$name/;;
                *)
                	url="wee";;

        esac
}
scan_packages
{
        case $url in
		#under each function maybe have a .sh ran and eval it
                *github.com*)
                *downloads.sourceforge.net*)
                *sourceforge.net*)
                *gitlab.com*)
                *python.org*|*pypi.org*|*pythonhosted.org*|*pypi.io*|*pypi.org*)
                *rubygems.org*)
                *launchpad.net*)
                *ftp.gnome.org*)
                *archive.xfce.org*)
                *)

        esac
}
main()
{
	rm index.html
	uversion="7.0"
	echo "Ignoring: $ignoring"
	echo ""
	get_url $1
	echo "URL:       $url"
	echo "Filename:  $name"
	echo "Version:   $version"
	echo "Upgraded:  $uversion"
	alter_per_url
	echo "New URL: $url"
	#fetch
        #find upgraded version from fetch code compare and then upgrade package using uversion as variable name
        #if [ "$uversion" != "$version" ];
        #then
        #	vercomp $uversion $version
        #	if [ $? = 2 ]; then
        #		#do things
        #		echo "NEW"
        #	elif [ $? = 1 ];then
        #		echo "OLD"
        #	else
        #		echo "Same"
        #	fi
        #fi
}
ignoring="kf5 plasma kde-apps python perl"
main $@
