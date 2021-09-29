#Last Updated: 7/22/17
#Updated: 7/22/2021
echo "$(date)" >> /var/log/my_scripts/shows_watched.log
#season variables of Tv Shows
export Sunny="Season 14"
export tank="Season 12"
export Saul="Season 5"
export lucifer="Season 5"
export South_Park="Season 23"
export Rick="Season 5"
export sheldon="Season 4"
export archer="Season 11"
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
#shopt -s nocaseglob

#Scan thru the directories and put it into the library
mv */*Park* "$Drive/Storage/Videos/Cartoons/South Park/$South_Park" --verbose
mv */*Saul* "$Drive/Storage/Videos/Sitcoms/Better Call Saul/$Saul" --verbose
mv */*Sunny* "$Drive/Storage/Videos/Sitcoms/Sunny/$Sunny" --verbose
mv */*tank* "$Drive/Storage/Videos/Sitcoms/Shark Tank/$tank" --verbose
mv */*ucifer* "$Drive/Storage/Videos/Sitcoms/lucifer/$lucifer" --verbose
mv */Rick* "$Drive/Storage/Videos/Cartoons/Rick and Morty/$Rick" --verbose
mv */*sheldon* "$Drive/Storage/Videos/Sitcoms/Young Sheldon/$sheldon" --verbose
mv */archer* "$Drive/Storage/Videos/Cartoons/Archer/$archer" --verbose

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

