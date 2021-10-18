#!/bin/sh
#Last Updated: 7/22/17
#Updated: 10/13/2021
#echo "$(date)" >> /var/log/my_scripts/shows_watched.log
#season variables of Tv Shows

#format of folder naming scheme: Name.of.show-Season.$showvariable

Sunny="14"
tank="13"
Saul="5"
South_Park="23"
Rick="5"
sheldon="5"
archer="11"
ghosts="1"
family_guy="20"
shows="Cartoons/Family.Guy-Season.$family_guy Sitcoms/Ghosts-Season.$ghosts Sitcoms/Shark.Tank-Season.$tank Sitcoms/Sunny-Season.$Sunny Sitcoms/Better.Call.Saul-Season.$Saul Cartoons/South.Park-Season.$South_Park Cartoons/Rick.and.Morty-Season.$Rick Sitcoms/Young.Sheldon-Season.$sheldon Cartoons/Archer-Season.$archer"

if [[ $1 = "x" ]];then
echo "Checking for correct folders"

for x in $shows;
do
	show=$(echo $x | cut -d '-' -f1 | sed "s/\./\\ /g")
	season=$(echo $x | cut -d '-' -f2 | sed "s/\./\\ /g")
	ppath="/media/Storage/Videos/$show/$season"
	if [ -d "$ppath" ];then
		echo "$ppath exists"
	else
		echo "$ppath does not exist creating folder now"
		mkdir -pv "$ppath"
	fi
done
fi
move_files()
{
# Drive Variable (in case of new hard drive - sitcoms/cartoons/ permanent location resides here)
export Drive='/Drives/External/sda1'
#Drive to look for files to transfer

cd /temp/Stripped\ Files
shopt -s nocaseglob
# Remove Garbage
rm -rf */*SAMPLE* --verbose
rm -rf */*sample* --verbose
rm -rf */*Sample* --verbose

#Ignore case if it has the base word do move commands listed below

#Scan thru the directories and put it into the library
mv */*family* "$Drive/Storage/Videos/Cartoons/Family Guy/Season $family_guy" --verbose
mv */*ghosts* "$Drive/Storage/Videos/Sitcoms/Ghosts/Season $ghosts" --verbose
mv */*Park* "$Drive/Storage/Videos/Cartoons/South Park/Season $South_Park" --verbose
mv */*Saul* "$Drive/Storage/Videos/Sitcoms/Better Call Saul/Season $Saul" --verbose
mv */*Sunny* "$Drive/Storage/Videos/Sitcoms/Sunny/Season $Sunny" --verbose
mv */*tank* "$Drive/Storage/Videos/Sitcoms/Shark Tank/Season $tank" --verbose
mv */Rick* "$Drive/Storage/Videos/Cartoons/Rick and Morty/Season $Rick" --verbose
mv */*sheldon* "$Drive/Storage/Videos/Sitcoms/Young Sheldon/Season $sheldon" --verbose
mv */archer* "$Drive/Storage/Videos/Cartoons/Archer/Season $archer" --verbose

#move all missed files to the misc folder
mv */*.mkv $Drive/Storage/Videos/Misc --verbose
mv */*.avi $Drive/Storage/Videos/Misc --verbose
mv */*.mp4 $Drive/Storage/Videos/Misc --verbose

#delete empty folders
rm -rf /temp/Stripped\ Files/* --verbose
cp ../index.php .
cp ../secondary.php .

#generate the php files for the display pages on the webserver
#cd $Drive/Storage/Videos && find . -type d -exec cp secondary.php {} \; && cd /temp && find . -type d -exec cp secondary.php {} \; && cd /temp/Downloading && cp secon*.backup secondary.php --verbose
#str="Done Transfering Files.\n"
#echo | sed "i$str" >> /var/log/my_scripts/shows_watched.log
}
if [[ $1 = "x" ]];then
	move_files
fi
