#!/bin/sh
groupadd -g 169 transmission
useradd -c "Transmission BitTorrent Daemon" -d /var/lib/transmission -u 169 -g transmission -s /bin/false transmission
