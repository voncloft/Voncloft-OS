rm /etc/httpd/httpd.conf.spkgnew

scratch install -y httpd-boot
mv -v /usr/sbin/suexec /usr/lib/httpd/suexec
chgrp apache           /usr/lib/httpd/suexec
chmod 4754             /usr/lib/httpd/suexec
chown -v -R apache:apache /srv/www

