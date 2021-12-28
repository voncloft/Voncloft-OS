#!/bin/sh
ssh-keygen
sed 's@d/login@d/sshd@g' /etc/pam.d/login > /etc/pam.d/sshd &&
chmod 644 /etc/pam.d/sshd &&
echo "UsePAM yes" >> /etc/ssh/sshd_config
scratch install -y openssh-boot
rm rf /etc/ssh/sshd_config.spkgnew
