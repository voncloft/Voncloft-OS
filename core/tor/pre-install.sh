#!/bin/sh
groupadd -g 43 tor
useradd -c "Anonymizing Overlay Network" -d /var/lib/tor -u 43 -g tor -s /bin/false tor
