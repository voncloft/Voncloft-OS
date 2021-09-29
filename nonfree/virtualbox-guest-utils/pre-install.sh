#!/bin/sh
groupadd -r vboxsf
useradd -d /var/run/vboxadd -g 1 -r -s /bin/false vboxadd 
