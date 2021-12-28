#!/bin/bash
/usr/sbin/make-ca -g --force >> /var/log/old/certs.txt
cp /etc/ssl/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt
EOF
