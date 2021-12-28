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
# End ~/.bashrc
complete -cf sudo
eval "$(thefuck --alias)"
