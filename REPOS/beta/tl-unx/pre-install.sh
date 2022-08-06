#!/bin/sh
TEXARCH=$(uname -m | sed -e 's/i.86/i386/' -e 's/$/-linux/')

cat > /etc/profile.d/texlive.sh << EOF
# Begin texlive setup
TEXLIVE_PREFIX=/opt/texlive/2022
export TEXLIVE_PREFIX

pathappend \$TEXLIVE_PREFIX/texmf-dist/doc/man  MANPATH
pathappend \$TEXLIVE_PREFIX/texmf-dist/doc/info INFOPATH
pathappend \$TEXLIVE_PREFIX/bin/$TEXARCH

# End texlive setup
EOF

unset TEXARCH

cat >> /etc/ld.so.conf << EOF
# Begin texlive addition

$TEXLIVE_PREFIX/lib

# End texlive addition
EOF
source /etc/profile
