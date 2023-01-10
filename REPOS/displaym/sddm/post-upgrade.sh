sed -e '/ServerPath/ s|usr|opt/xorg|' \
    -i.orig /etc/sddm.conf

sed -e 's/-nolisten tcp//'\
    -i /etc/sddm.conf

sed -e 's/\"none\"/\"on\"/' \
    -i /etc/sddm.conf

cp -v /etc/inittab{,-orig} &&
sed -i '/initdefault/ s/3/5/' /etc/inittab
/etc/init.d/sddm restart
