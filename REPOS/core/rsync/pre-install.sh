#1/bin/sh
groupadd -g 48 rsyncd
useradd -c "rsyncd Daemon" -d /home/rsync -g rsyncd -s /bin/false -u 48 rsyncd
