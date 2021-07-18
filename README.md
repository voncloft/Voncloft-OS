# Voncloft-OS - Personal LFS build

A Linux From Scratch Repository that I self maintain.

_As of 06-27-2021_

**Update:**
- Cinnamon has been put on hold as of 4/5 - due to systemd dependencies, which I am doubting whether or not to use
- work on all universal user passes on vpn
- need to fix lsdm pamd.d file

**Needs Testing:**
- qtcreator
- postfix
- mythtv
- python - might have errors will fix as a need be basis
- perl - might have errors will fix as a need be basis
- chessx - needs testing and its dependencies
- scid_vs_pc - needs testing

**Programs to be added in the future:**
- KDEVELOP

**System Changes:**
- Qt5 has been moved from /opt/qt5 to /usr

**Other:**
- Everything in workbench is files that continuously get changed and tarballed for later
- Everything in working_on/sort_later needs to be tested.
- Will use a spare PC to test everything on or a virtual box
- Template folder is a base for all packages as of 3/16/21

**Updates:**
- Not EVERYTHING will be updated, at best it is at my leisure on packages I view worth my while.
- Packages are checked one time a day at 3:01 PM CST in my repository against https://distrowatch.com/packages.php (amongst other scripts located in Utilities/custom_progs) using a script located in utilities/bin/checkrepository
- Updates can be viewed here: http://voncloft.dnsfor.me/updated

**Workon next:**
- PHP: needs to not overwrite httpd existing config files upon upgrading

**bugs:**
- mesa fails to build opengl drivers for virtualbox, building by hand....does don't know why
