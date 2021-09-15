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
	ppath=$1
	url="${source[0]}"
	#url_finalized=$(echo $url | cut -d ' ' -f1 | sed 's|\(.*\)/.*|\1|')/
	url=$(echo $url | cut -d ' ' -f1 | sed 's|\(.*\)/.*|\1|')/
}
fetch() {
	#echo $PWD
        wget -q $url
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
		*/plasma/*)
			url="$(echo $url | cut -d / -f1-5)/"
			;;
                */frameworks/*)
                        url="$(echo $url | cut -d / -f1-5)/"
                        ;;
		*.kde.*/*/release-service/*)
			url="$(echo $url | cut -d / -f1-5)/"
			;;
                *)
                	

        esac
}
cmd_torun()
{
        case $url in
		#under each function maybe have a .sh ran and eval it
                *github.com*)
                	cmd="github"
                	fetch
                	;;
                *downloads.sourceforge.net*)
                	cmd="sourceforge"
                	fetch
                	;;
                *sourceforge.net*)
                	cmd="sourcefoge"
                	fetch
                	;;
                *gitlab.com*)
                	cmd="gitlab"
			fetch
                	;;
                *python.org*|*pypi.org*|*pythonhosted.org*|*pypi.io*|*pypi.org*)
                	cmd="python"
                	fetch;;
                *rubygems.org*)
                	cmd="ruby"
                	fetch
                	;;
                *launchpad.net*)
                	cmd="launchpad"
			fetch
                	;;
                *ftp.gnome.org*)
                	cmd="gnome"
                	fetch
                	;;
                *archive.xfce.org*)
                	cmd="xfce"
                	fetch
                	;;
		*/plasma/*)
			cmd="plasma"
			rm test.txt
			fetch 
			egrep -o "([0-9]{1,}\.)+[0-9]{1,}" index.html >> test.txt
                        uversion=$(cat test.txt | sort -V -r | head -n 1)
			;;
                */frameworks/*)
                	cmd="frameworks"
                	fetch
                	rm test.txt
                	egrep -o "([0-9]{1,}\.)+[0-9]{1,}" index.html >> test.txt
                	uversion=$(cat test.txt | sort -V -r | head -n 1)
                	uversion=${uversion}.0
                	;;
                *.kde.*/*/release-service/*)
                	cmd="kde-apps"
                	fetch
                	rm test.txt
                	egrep -o "([0-9]{1,}\.)+[0-9]{1,}" index.html >> test.txt
                	uversion=$(cat test.txt | sort -V -r | head -n 1)
                	;;
                *)
                	cmd="generic"
			fetch
                	;;

        esac
}
main()
{
	rm index.html
	#options="-q"
	#uversion="7.0"
	echo "Ignoring: $ignoring"
	echo ""
	get_url $1
	echo "PPath:     $ppath"
	echo "URL:       $url"
	echo "Filename:  $name"
	echo "Version:   $version"

	alter_per_url
	echo "New URL:   $url"
	cmd_torun
	echo "Command:   $cmd"
	echo "Upgraded:  $uversion"
        #find upgraded version from fetch code compare and then upgrade package using uversion as variable name
	check=${#uversion}
	if [ $check -ge 1 ];
	then
        	if [ "$uversion" != "$version" ];
        	then
        	vercomp $uversion $version
        		if [ $? = 2 ]; then
        		#do things
        			echo "NEW"
        			sed -i -e "s/version=$version/version=$uversion/g" $ppath
        		
        		elif [ $? = 1 ];then
        			echo "OLD"
        		else
        			echo "Same"
        		fi
        	fi
	fi
}
ignoring="kf5 plasma kde-apps python perl"
main $@
