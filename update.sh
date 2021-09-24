#!/bin/sh
#Written: 09-19-21
#TODO: Create tables instead of lists for reports showing ppath, url, and previous version, maybe even repo classification
#TODO: Find way to upgrade urls for python and perl

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
	curl -f "$url" -o index.html -s
	#wget -O index.html $url -q
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
                        #url=https://pypi.org/simple/${name#python-};;
			url=https://pypi.org;;
		*cpan.*)
			url=https://cpan.org;;
                *rubygems.org*)
                        url=https://rubygems.org/gems/${name/ruby-/};;
                *launchpad.net*)
                        url=https://launchpad.net/$(echo $url | cut -d / -f4)/;;
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
		*..subsonic.*)
			url="http://www.subsonic.org/pages/download.jsp"
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
	update_script=$(echo $ppath)
	echo -e "${CYAN}ALERT:     Update script found in $update_script${NC}"
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
                *cpan.*)
                        cmd="perl"
                        check_manual_upd
                        if [ $? = 1 ];then
                                run_manual_upd
                        else
                        	#spkg_url=$source
				retry_index
				grep_retry
                        fi
                ;;
                *python.org*|*pypi.org*|*pythonhosted.org*|*pypi.io*|*pypi.org*)
                	cmd="python"
                        check_manual_upd
                        if [ $? = 1 ];then
                                run_manual_upd
                        else
                                retry_index
                                grep_retry
			fi
			;;
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
                *.subsonic.*)
                	cmd="custom"
                	check_manual_upd
                	if [ $? = 1 ];then
                		url="http://www.subsonic.org/pages/download.jsp"
                		run_manual_upd
                	fi
                	;;
                *)
                	cmd="generic"
			check_manual_upd
			if [ $? = 1 ];
			then
				run_manual_upd
			else
				echo -e "${FRED}ERROR:     Update script does not exist for $name trying manually${NC}"
				fetch
				if [ ! -f index.html ];then
					retry_index
					grep_retry
				else
				uversion=$(grep -Eio $name[_-][0-9a-z.]+.tar.[bgx]z2? index.html \
        				| sed "s/$name[-_]//;s/\.tar.*//" \
        				| grep -Evi '(alpha|beta|rc|pre)' \
        				| egrep -o "([0-9]{1,}\.)+[0-9]{1,}" \
        				| sort -V -r \
        				| uniq \
        				| head -n1)
        			fi
			fi
                	;;
        esac
}
retry_index()
{
#echo "PPath $ppath"
spkg_src=$(grep "source=" $ppath | sed "s/source=//g")

#echo "spkgbuild $spkg_src"
url="https://raw.githubusercontent.com/archlinux/svntogit-community/packages/$name/trunk/PKGBUILD"
fetch
if [ ! -f /Voncloft-OS/index.html ];then
	url="https://raw.githubusercontent.com/archlinux/svntogit-community/packages/$name/trunk/PKGBUILD"
	fetch
fi
if [ ! -f /Voncloft-OS/index.html ];then
	url="https://raw.githubusercontent.com/archlinux/svntogit-packages/packages/$name/trunk/PKGBUILD"
	fetch
fi
}
grep_retry()
{
                                unset uversion url_lazy new_url
				if [ -f test.txt ];then
                                	rm test.txt
				fi
				if [ -f /Voncloft-OS/index.html ];then
                                        grep "pkgver=" index.html > /Voncloft-OS/test.txt
                                        #sed "s/v//g" /Voncloft-OS/test.txt
                                        #sed "s/pkger/pkgver/g" /Voncloft-OS/test.txt
                                        #grep "url=" index.html >> /Voncloft-OS/test.txt
                                        grep "name=" index.html >> /Voncloft-OS/test.txt
                                        grep "pkgname=" index.html | cut -d ' ' -f1 >> /Voncloft-OS/test.txt
                                        grep "url=" index.html >> /Voncloft-OS/test.txt
                                        grep "source=" index.html >> /Voncloft-OS/test.txt
                                        sed -i -e "s/(//g" /Voncloft-OS/test.txt
                                        sed -i -e "s/)//g" /Voncloft-OS/test.txt

                                        new_url=$spkg_url
                                        source /Voncloft-OS/test.txt
                                        uversion="$pkgver"
                                        #echo "new url $source"
					#sed -i -e "s,$spkg_src,$source,g" $ppath
                                        #echo "NEW VERSION $uversion"
                                        #echo "New URL2 $new_url"
                                        if [ ! -f /Voncloft-OS/index.html ];then
                                                echo "NO PACKAGE FOUND AT ARCH"
                                                #put sed command here
                                        fi
                                        #echo $new_url
                                fi
}
perform_override()
{
        get_url $check_override
	fix_spkgbuild=$(echo $ppath | sed 's/override/spkgbuild/g')
        echo -e "${WHITE}PPath:     $fix_spkgbuild${NC}"
        echo -e "${YELLOW}URL:       $url${NC}"
        echo -e "${GREEN}Filename:  $name${NC}"
        echo -e "${BLUE}Version:   $version${NC}"
        alter_per_url
        echo -e "${RED}New URL:   $url${NC}"
	cmd_torun
        ppath=$(echo $ppath | sed 's/override/spkgbuild/g')
        echo -e "${PURPLE}Command:   $cmd${NC}"
        echo -e "${DBLUE}Upgraded:  $uversion${NC}"
}
upgrade_normally()
{
	echo -e "${WHITE}PPath:     $ppath${NC}"
        echo -e "${YELLOW}URL:       $url${NC}"
        echo -e "${GREEN}Filename:  $name${NC}"
        echo -e "${BLUE}Version:   $version${NC}"
        alter_per_url
        echo -e "${RED}New URL:   $url${NC}"
        cmd_torun
        echo -e "${PURPLE}Command:   $cmd${NC}"
        echo -e "${DBLUE}Upgraded:  $uversion${NC}"
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
				#timestamp_log
                                #final="<b><u>$ppath</u></b>\n"
                                #final+="<br>installed version in repo: $version\n"
                                #final+="<br>upgraded to version: $uversion\n"
                                #final+="<br><br>\n\n"
                                #echo -e $final >> $logpath/reports/repository_upgrade_report-$(date +"%m-%d-%y").html
				create_table $ppath $version $uversion
                                #echo -e "sed -i -e s/version=$version/version=$uversion/g $ppath<br>" >> $logpath/changes/repository_changes-$(date +"%m-%d-%y").html   
                                sed -i -e "s/version=$version/version=$uversion/g" $ppath
                                changelog "$ppath" "Upgraded from version $version to version $uversion"
                                #cp index.html $name-index.html
                        elif [ $? = 1 ];then
                                echo "OLD"
                        fi
                fi
	else
                ((missing=missing+1))
                log_missing
        fi
	if [ -f index.html ];then
        	rm index.html
	fi
}
alerts_and_logs()
{
	echo "-----------------------------------------------------------------------------------"
	if [ ! -z $count ];
	then
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
	#cp missing.txt $logpath/missing/missing-$(date +"%m-%d-%y").html
	#find /Voncloft-OS/logs -maxdepth 100 -exec cp /Voncloft-OS/utilities/files/secondary.php {} \;
	find /Voncloft-OS/logs/ -maxdepth 5 -type d -exec cp /Voncloft-OS/logs/secondary.php {} \;
	if [ $count = 1 ];
	then
		message="package updated"
	else
		message="packages updated"
	fi
	echo -e "${BLUE}$count $message${NC}"
	else
	
		echo -e "${BLUE}No new updates${NC}"
	fi
	if [ ! -z $missing ];
	then
		if [ $missing = 1 ];
		then
			message="package missed"
		else
			message="packages missing"
		fi
	echo -e "${BLUE}$missing $message${NC}"
	else
	message="No missing packages"
	echo -e "${BLUE}$message${NC}"
	fi
}
prepare_backup_and_logs()
{
	foltotar /var/log/old/repo-$(date +"%m-%d-%y").tar.gz /Voncloft-OS
	#mv repo-$(date +"%m-%d-%y").tar.gz /var/log/old
	if [ ! -f $logpath/reports/repository_upgrade_report-$(date +"%m-%d-%y").html ];then
		mkdir -pv $logpath/changes
		mkdir -pv $logpath/reports
		mkdir -pv $logpath/over_updated
		mkdir -pv $logpath/missing
		echo -e '<head><link rel="stylesheet" type="text/css" href="http://voncloft.dnsfor.me/updated/colors.css" /></head>' >> $logpath/reports/repository_upgrade_report-$(date +"%m-%d-%y").html
		echo -e '<head><link rel="stylesheet" type="text/css" href="http://voncloft.dnsfor.me/updated/colors.css" /></head>' >> $logpath/changes/repository_changes-$(date +"%m-%d-%y").html
		echo -e '<head><link rel="stylesheet" type="text/css" href="http://voncloft.dnsfor.me/updated/colors.css" /></head>' >> $logpath/over_updated/over_updated-$(date +"%m-%d-%y").html
		echo -e '<head><link rel="stylesheet" type="text/css" href="http://voncloft.dnsfor.me/updated/colors.css" /></head>' >> $logpath/missing/missing-$(date +"%m-%d-%y").html

		#echo -e "$(date +%H)<br>" >> $logpath/reports/repository_upgrade_report-$(date +"%m-%d-%y").html
		#echo -e "$(date +%H)<br>" >> $logpath/changes/repository_changes-$(date +"%m-%d-%y").html
		#echo -e "$(date +%H)<br>" >> $logpath/over_updated/over_updated-$(date +"%m-%d-%y").html
	fi
}
timestamp_log()
{
	if [ ! -z $count ] && [ $count -eq 1 ];then
                        echo -e "\n$(date +%H)<br>" >> $logpath/reports/repository_upgrade_report-$(date +"%m-%d-%y").html
                        echo -e "\n$(date +%H)<br>" >> $logpath/changes/repository_changes-$(date +"%m-%d-%y").html
                        echo -e "\n$(date +%H)<br>" >> $logpath/over_updated/over_updated-$(date +"%m-%d-%y").html

	fi
}
log_missing()
{
	if [ ! -z $missing ] && [ $missing -eq 1 ];then
		echo -e "\n$(date +%H)<br>" >> $logpath/missing/missing-$(date +"%m-%d-%y").html
	fi
	if [ -z $uversion ];then
                echo $ppath"<br>" >> $logpath/missing/missing-$(date +"%m-%d-%y").html
       	fi
}
finish_logs()
{
	if [ ! -z $missing ];then
		echo "<br>Total missing packages: $missing" >> $logpath/missing/missing-$(date +"%m-%d-%y").html
		echo "<br><br>" >> $logpath/missing/missing-$(date +"%m-%d-%y").html
	fi
	if [ ! -z $count ];then
        	echo -e "<br>" >> $logpath/reports/repository_upgrade_report-$(date +"%m-%d-%y").html
        	echo -e "<br>" >> $logpath/changes/repository_changes-$(date +"%m-%d-%y").html
        	echo -e "<br>" >> $logpath/over_updated/over_updated-$(date +"%m-%d-%y").html
		echo -e "</table>" >> $table_log
	fi
}
create_table()
{
	
	echo "<CENTER>" >> $table_log
	if [ $count = 1 ];then
		echo -e '<table border = "2"><caption>Updates for' $(date +"%m-%d-%y") $(date "+%H")'</caption>' >> $table_log
		echo '<tr><td align=center>Package Path</td><td>Old Version</td><td>New Version</td><td>Changelog</td><td>spkgbuild</td></tr>' >> $table_log
	fi
	spkg_dir=$(echo $1 | sed "s/\/spkgbuild//g")
	changelog="http://voncloft.dnsfor.me/repository/$spkg_dir/CHANGELOG"
        echo '<tr><td align=center>'$1'</td><td align=center>'$2'</td><td align=center>'$3'</td><td align=center><a href='$changelog'>Changelog</a></td><td><a href=http://voncloft.dnsfor.me/repository/'$1'>spkgbuild</a></td></tr>' >> $table_log	

}
main()
{
	prepare_backup_and_logs
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
	finish_logs	
	alerts_and_logs

}
####GLOBAL VARIABLES##############
###COLORS###
RED='\e[0;31;40m'
YELLOW='\e[0;33;40m'
GREEN='\e[0;32;40m'
BLUE='\e[0;34;40m'
WHITE='\e[0;37;40m'
PURPLE='\e[0;35;40m'
DBLUE='\e[1;34;40m'
CYAN='\e[0;36;40m'
FRED='\e[5;31;40m'
NC='\033[0m'

cd /Voncloft-OS
###GLOBAL VARIABLE###
logpath=/Voncloft-OS/logs/$(date +"%Y")/$(date +"%b")
table_log=$logpath/reports/repository_upgrade_report-$(date +"%m-%d-%y").html
bare_essentials="networking/firefox networking/thunderbird core/nss extra/nspr"
#repos="networking/firefox networking/thunderbird core/nano kf5/* plasma/* kde-apps/* core/wget extra/* compilers/* media/vlc nonfree/* server/*"
#repos="cinnamon/* compilers/* core/* displaym/* extra/* firewall/* fonts/* gnome/* lxde/* lxqt/* mate/* media/* multilib/* networking/* nonfree/* plasma/* qt/* ruby-gems/* server/* xfce/* xorg/* python/* perl/*"

###TESTING###
#ignoring="kf5 plasma kde-apps python perl"
#repos="python/python-apsw"
repos="python/python-xapp python/python-wheezy-template python/python-ujson"
#repos="perl/* python/*"
#repos="python/python-decorator python/python-defusedxml python/python-dephell python/python-genty"
#repos="core/wget core/iasl python/python-aiopg perl/perl-a*"
#repos="$bare_essentials"
#echo "Ignoring: $ignoring"
#repos="extra/*"
#repos="core/wget"
#repos="cinnamon/* compilers/* displaym/* extra/* firewall/* fonts/* gnome/* hardware/* kde/* kde-apps/* kf5/* libs/* lxde/* lxqt/* mate/* media/* multilib/* networking/* nonfree/* perl/* plasma/* python/* qt/* ruby-gems/* server/* xfce/* xorg/* core/*"
#repos="extra/chessx"
start_time="$(date -u +%s)"
###Start Checking###
main $@
end_time="$(date -u +%s)"
elapsed="$(($end_time-$start_time))"
echo "Total of $elapsed seconds elapsed for process"
