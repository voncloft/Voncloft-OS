#!/bin/sh
groupadd -g 64 sddm
useradd -c "SDDM Daemon" -d /var/lib/sddm -u 64 -g sddm -s /bin/false sddm
