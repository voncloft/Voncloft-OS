#!/bin/sh
#TODO:  INTEGRATE ENTIRE REPO - DISABLE THE sed that upgrades the spkgbuild for testing
print_progress() {
        echo -ne " $@\033[0K\r"
}
vercomp() {
        if [ "$1" = "$2" ]; then
		echo "0" #same version
        elif [ "$(printf '%s\n' "$1" "$2" | sort -V | head -n1)" = "$1" ]; then
                return 1 # $1 lower than $2
        else
                return 2 # $1 higher than $2
        fi
}
get_url()
{
	source $1
	ppath=$1
	url="${source[0]}"
	url=$(echo $url | cut -d ' ' -f1 | sed 's|\(.*\)/.*|\1|')/
}
fetch() {
        wget -q -O index.html $url
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
check_manual_upd()
{
	update=$(echo $ppath | sed "s/spkgbuild/override/g")
	if [ -f $update ];then
		return 1
	else
		return 0
	fi
}
run_manual_upd()
{
	#update=$(echo $ppath | sed 's/spkgbuild/update/g')
	update_script=$(echo $ppath)
	echo "ALERT:     Update script found in $update_script"
	source $update_script
	fetch
	get_generic
}
cmd_torun()
{
        case $url in
                *github.com*)
                	cmd="github"
                        check_manual_upd
                        if [ $? = 1 ];then
                                run_manual_upd
                        else
                		fetch
                		uversion=$(grep -Eio [0-9a-z.]+.tar.[bgx]z2? index.html \
				| sed "s/.tar.*//g"	\
        	        	| sort -V -r \
				| egrep -o "([0-9]{1,}\.)+[0-9]{1,}" \
                		| uniq \
                		| head -n1)
			fi
                	;;
                #*downloads.sourceforge.net*)
                #	cmd="sourceforge"
                #	fetch
                #	;;
                #*sourceforge.net*)
                #	cmd="sourcefoge"
                #	fetch
                #	;;
                #*gitlab.com*)
                #	cmd="gitlab"
		#	fetch
                #	;;
                #*python.org*|*pypi.org*|*pythonhosted.org*|*pypi.io*|*pypi.org*)
                #	cmd="python"
                #	fetch;;
                *rubygems.org*)
			cmd="ruby"
                	check_manual_upd
                	if [ $? = 1 ];then
                		run_manual_upd
                	else
	                	fetch
				uversion=$(grep -i "href" index.html | grep -Po '(?<=href=")[^"]*' | egrep -o "([0-9]{1,}\.)+[0-9]{1,}" | head -n1)
			fi
			;;
                #*launchpad.net*)
                #	cmd="launchpad"
		#	fetch
                #	;;
                #*ftp.gnome.org*)
                #	cmd="gnome"
                #	fetch
                #	;;
                *archive.xfce.org*)
                	cmd="xfce"
                	check_manual_upd
                	if [ $? = 1 ];then
                		run_manual_upd
                	else
 		               	fetch
                		uversion=$(egrep -o "([0-9]{1,}\.)+[0-9]{1,}" index.html \
                		| sort -V -r \
                        	| head -n1)
                        	url=$url$uversion/
                        	#echo $url
                        	rm index.html
                        	fetch
                        	uversion=$(egrep -o "([0-9]{1,}\.)+[0-9]{1,}" index.html \
                        	| sort -V -r \
                        	| head -n1)
                        fi
                	;;
		*plasma*)
			cmd="plasma"
			check_manual_upd
			if [ $? = 1 ];then
				run_manual_upd
			else
				fetch 
				uversion=$(egrep -o "([0-9]{1,}\.)+[0-9]{1,}" index.html \
				| sort -V -r \
                        	| head -n1)
                        fi
			;;
                *frameworks*)
                	cmd="frameworks"
                	check_manual_upd
                	if [ $? = 1 ];then
                		run_manual_upd
                	else
                		fetch
                		uversion=$(egrep -o "([0-9]{1,}\.)+[0-9]{1,}" index.html \
                		| sort -V -r \
                		| head -n1).0
                	fi
                	;;
                *.kde.*/*/release-service/*)
                	cmd="kde-apps"
			check_manual_upd
			if [ $? = 1 ];then
				run_manual_upd
			else
                		fetch
                		uversion=$(egrep -o "([0-9]{1,}\.)+[0-9]{1,}" index.html \
                		| sort -V -r \
                		| head -n1)
                	fi
                	;;
                *)
                	cmd="generic"
			check_manual_upd
			if [ $? = 1 ];
			then
				run_manual_upd
			else
				echo "ERROR:     Update script does not exist for $name trying manually"
				fetch
        			uversion=$(grep -Eio $name[_-][0-9a-z.]+.tar.[bgx]z2? index.html \
        			| sed "s/$name[-_]//;s/\.tar.*//" \
        			| grep -Evi '(alpha|beta|rc|pre)' \
        			| egrep -o "([0-9]{1,}\.)+[0-9]{1,}" \
        			| sort -V -r \
        			| uniq \
        			| head -n1)
			fi
                	;;
        esac
}
perform_override()
{
        get_url $check_override
	fix_spkgbuild=$(echo $ppath | sed 's/override/spkgbuild/g')
        echo "PPath:     $fix_spkgbuild"
        echo "URL:       $url"
        echo "Filename:  $name"
        echo "Version:   $version"
        alter_per_url
        echo "New URL:   $url"
	cmd_torun
        ppath=$(echo $ppath | sed 's/override/spkgbuild/g')
        echo "Command:   $cmd"
        echo "Upgraded:  $uversion"
}
upgrade_normally()
{
	echo "PPath:     $ppath"
        echo "URL:       $url"
        echo "Filename:  $name"
        echo "Version:   $version"
        alter_per_url
        echo "New URL:   $url"
        cmd_torun
        echo "Command:   $cmd"
        echo "Upgraded:  $uversion"
}
upgrade_process()
{
        #find upgraded version from fetch code compare and then upgrade package using uversion as variable name
        check=${#uversion}
        if [ $check -ge 1 ];
        then
                if [ "$uversion" != "$version" ];
                then
                vercomp $uversion $version
                        if [ $? = 2 ]; then
                                echo "NEW"
                                ((count=count+1))
                                final="<b><u>$ppath</u></b>\n"
                                final+="<br>installed version in repo: $version\n"
                                final+="<br>upgraded to version: $uversion\n"
                                final+="<br><br>\n\n"
                                echo -e $final >> $logpath/reports/repository_upgrade_report-$(date +"%m-%d-%y").html
                                echo -e "sed -i -e s/version=$version/version=$uversion/g $ppath<br>" >> $logpath/changes/repository_changes-$(date +"%m-%d-%y").html   
                                sed -i -e "s/version=$version/version=$uversion/g" $ppath
                                changelog "$ppath" "Upgraded from version $version to version $uversion"
                                #cp index.html $name-index.html
                        elif [ $? = 1 ];then
                                echo "OLD"
                        fi
                fi
        fi
        rm index.html
}
alerts_and_logs()
{
	echo -e "Packages upgraded: $count<br><br>\n" >> $logpath/reports/repository_upgrade_report-$(date +"%m-%d-%y").html
	echo -e "Packages upgraded: $count\n" >> $logpath/changes/repository_changes-$(date +"%m-%d-%y").html
	words=$(cat $logpath/reports/repository_upgrade_report-$(date +"%m-%d-%y").html)
	title="Outdated Packages in Repository: "$(date +"%m-%d-%y")
	if [ ! -z $count ];
	then
        	mailme voncloft@gmail.com "$words" "$title"
        	mailme phone@vtext.com "Updated packages: $count" "Upgrade Report"
        	#missing_packages=$(cat missing.txt | grep -v '<head' | wc -l)
        	#mailme 2606159678@vtext.com "Total Missing: $missing_packages" "Total Outdated Packages"
        	#echo "<br><br>Total Missing: $missing_packages" >> missing.txt
        	#missing=$(cat missing.txt)
        	#mailme voncloft@gmail.com "$missing" "Missing Packages not in the loop to be checked as of: "$(date +"%m-%d-%y")
	fi
	#rm -v /var/log/old/testing.txt
	#rm -v test.txt
	cp $logpath/reports/repository_upgrade_report-$(date +"%m-%d-%y").html /var/log/old/repository_upgrade_report-$(date +"%m-%d-%y").html
	cp $logpath/changes/repository_changes-$(date +"%m-%d-%y").html /var/log/old/repository_changes-$(date +"%m-%d-%y").html
	echo -e "<br>" >> $logpath/over_updated/over_updated-$(date +"%m-%d-%y").html 
	cp $logpath/over_updated/over_updated-$(date +"%m-%d-%y").html /var/log/old/over_updated-$(date +"%m-%d-%y").html
	cp missing.txt $logpath/missing/missing-$(date +"%m-%d-%y").html
	#find /Voncloft-OS/logs -maxdepth 100 -exec cp /Voncloft-OS/utilities/files/secondary.php {} \;
	find /Voncloft-OS/logs/ -maxdepth 5 -type d -exec cp /Voncloft-OS/logs/secondary.php {} \;
}
main()
{
	for f in $repos;
	do
	echo "-----------------------------------------------------------------------------------"
	if [ "${f##*/}" != "REPO" ];then
		get_url $f/spkgbuild
		check_override=$(echo $f/spkgbuild | sed 's/spkgbuild/override/g')
		if [ ! -f $check_override ];then
			upgrade_normally
		else
			perform_override
		fi
			upgrade_process
	fi
	done
	alerts_and_logs
}
####GLOBAL VARIABLES##############
#ignoring="kf5 plasma kde-apps python perl"
#echo "Ignoring: $ignoring"

#repos="cinnamon/* compilers/* displaym/* extra/* firewall/* fonts/* gnome/* hardware/* kde/* kde-apps/* kf5/* libs/* lxde/* lxqt/* mate/* media/* multilib/* networking/* nonfree/* perl/* plasma/* python/* qt/* ruby-gems/* server/* xfce/* xorg/* core/*"
#repos="networking/firefox core/nano kf5/* plasma/* kde-apps/* core/wget extra/* compilers/*"
#repos="compilers/rust"
repos="compilers/*"
logpath=/Voncloft-OS/logs/$(date +"%Y")/$(date +"%b")
mkdir -pv $logpath/changes
mkdir -pv $logpath/reports
mkdir -pv $logpath/over_updated
mkdir -pv $logpath/missing
#foltotar /var/log/old/repo-$(date +"%m-%d-%y").tar.gz /Voncloft-OS
mv repo-$(date +"%m-%d-%y").tar.gz /var/log/old
echo -e '<head><link rel="stylesheet" type="text/css" href="http://voncloft.dnsfor.me/updated/colors.css" /></head>' >> $logpath/reports/repository_upgrade_report-$(date +"%m-%d-%y").html
echo -e '<head><link rel="stylesheet" type="text/css" href="http://voncloft.dnsfor.me/updated/colors.css" /></head>' >> $logpath/changes/repository_changes-$(date +"%m-%d-%y").html
echo -e '<head><link rel="stylesheet" type="text/css" href="http://voncloft.dnsfor.me/updated/colors.css" /></head>' >> $logpath/over_updated/over_updated-$(date +"%m-%d-%y").html
echo -e '<head><link rel="stylesheet" type="text/css" href="http://voncloft.dnsfor.me/updated/colors.css" /></head>' >> missing.txt
echo -e "$(date +%H)<br>" >> $logpath/reports/repository_upgrade_report-$(date +"%m-%d-%y").html
echo -e "$(date +%H)<br>" >> $logpath/changes/repository_changes-$(date +"%m-%d-%y").html
echo -e "$(date +%H)<br>" >> $logpath/over_updated/over_updated-$(date +"%m-%d-%y").html

main $@
