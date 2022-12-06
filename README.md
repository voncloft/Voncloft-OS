# Voncloft-OS - Personal LFS build

A Linux From Scratch Repository that I self maintain.

## (You are on your own if you choose to use my repository)

_As of 10-18-2022_

**Update:**
- fixed update utility

**Next Project:**
- KRDC KRFB
- involves libssh (not 2), libvnc, xrdp - fix deps

**Updates:**
- Not EVERYTHING will be updated, at best it is at my leisure on packages I view worth my while.
- Packages are checked via the "updates" in /Voncloft-OS (Always a work in progress) - I will review the updates before pushing them to github
- Updates can be viewed here: http://voncloft.dnsfor.me/updated

**Work on next:**
- PHP: needs to not overwrite httpd existing config files upon upgrading
- Hollywood: dependencies and install script
- Cinnamon has been put on hold as of 4/5 - due to systemd dependencies, which I am doubting whether or not to use
- work on all universal user passes on vpn
- need to fix lxdm pamd.d file
- Work on **Needs Testing**
- Work on **bugs**
- Work on **Programs to be added in the future**

**Needs Testing:**
- lua52 needs to be tested can only install manually currently, attempted to fix on Dec 6 2022
- x11vnc (currently in beta)
- qtcreator
- postfix
- mythtv
- python - might have errors will fix as a need be basis (again your own risk - I can be lazy)
- perl - might have errors will fix as a need be basis (again your own risk - I can be lazy)
- chessx - needs testing and its dependencies
- scid_vs_pc - needs testing

**bugs:**
- mesa fails to build opengl drivers for virtualbox, building by hand....does don't know why

**Programs to be added in the future:**
- KDEVELOP

**SPECIAL FOLDERS:**
- REPOS: all packages categorized for my OS
- logs: whats been done to repo
- logs/YEAR: html layout of updates
- logs/old-test-updates: applied updates after script has been ran
- other: Misc junk
- scripts: scripts I use and keep here for safe keeping
- workbench: projects I untar and tar due to changes
- working_on: get to it eventually, not as important as beta

**Other:**
- Everything in workbench is files that continuously get changed and tarballed for later
- Everything in working_on/sort_later needs to be tested.
- Will use a spare PC to test everything on or a virtual box
