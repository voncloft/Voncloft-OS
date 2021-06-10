# Begin ~/.bashrc
# Written for Beyond Linux From Scratch
# by James Robertson <jameswrobertson@earthlink.net>

# Personal aliases and functions.

# Personal environment variables and startup programs should go in
# ~/.bash_profile.  System wide environment variables and startup
# programs are in /etc/profile.  System wide aliases and functions are
# in /etc/bashrc.
PATH=$PATH:/usr/sbin:/sbin
if [ -f "/etc/bashrc" ] ; then
  source /etc/bashrc
fi
screenfetch
sh /usr/bin/process_monitor.sh

fortune | cowsay | lolcat
alias reload='clear && source /home/$(whoami)/.bashrc'
# Set up user specific i18n variables
#export LANG=<ll>_<CC>.<charmap><@modifiers>
alias router='sudo ssh -p712 root@router'
alias update-plasma='sudo scratch upgrade -c kdecoration libkscreen libksysguard breeze breeze-gtk kscreenlocker oxygen kinfocenter ksysguard kwayland-server kwin plasma-workspace plasma-disks bluedevil kde-gtk-config khotkeys kmenuedit kscreen kwallet-pam kwayland-integration kwrited milou plasma-nm plasma-pa plasma-workspace-wallpapers polkit-kde-agent powerdevil plasma-desktop kdeplasma-addons kgamma5 ksshaskpass sddm-kcm discover kactivitymanagerd plasma-integration plasma-tests xdg-desktop-portal-kde drkonqi plasma-vault plasma-browser-integration kde-cli-tools systemsettings plasma-thunderbolt plasma-firewall plasma-systemmonitor qqc2-breeze-style'
alias update-kf5='sudo scratch upgrade -c attica extra-cmake-modules kapidox karchive kcodecs kconfig kcoreaddons kdbusaddons kdnssd kguiaddons ki18n kidletime kimageformats kitemmodels kitemviews kplotting kwidgetsaddons kwindowsystem networkmanager-qt solid sonnet threadweaver kauth kcompletion kcrash kdoctools kpty kunitconversion kconfigwidgets kservice kglobalaccel kpackage kdesu kemoticons kiconthemes kjobwidgets knotifications ktextwidgets kxmlgui kbookmarks kwallet kded kio kdeclarative kcmutils kirigami2 knewstuff frameworkintegration kinit notifyconfig kparts kactivities syntax-highlighting ktexteditor kdesignerplugin kwayland plasma-framework kpeople kxmlrpcclient bluez-qt kfilemetadata baloo kactivities-stats krunner prison qqc2-desktop-style kjs kdelibs4support khtml kjsembed kmediaplayer kross kholidays purpose kcalendarcore kcontacts kquickcharts kdav'
alias update-kde-apps='sudo scratch upgrade -c dolphin kate konsole kpat ksirk kmahjongg kcalc dolphin-plugins ffmpegthumbs kapman kdeconnect-kde kdegraphics-thumbnailers khelpcenter kio-extras kmines kmix knavalbattle knetwalk knights kolf ksudoku libkcddb libkdcraw libkdegames libkexiv2 libkmahjongg okular polkit-kde-agent-1 palapeli spectacle'
# End ~/.bashrc
complete -cf sudo
eval "$(thefuck --alias)"
