#!/bin/sh
groupadd -g 65 lightdm
useradd -c "Lightdm Daemon" -d /var/lib/lightdm -u 65 -g lightdm -s /bin/false lightdm
