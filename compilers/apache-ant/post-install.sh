cat <<-EOF > $PKG/etc/profile.d/ant.sh
pathappend /opt/ant/bin
export ANT_HOME=/opt/ant
EOF
