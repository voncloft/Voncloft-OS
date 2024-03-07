    chown -R cool:cool /var/lib/coolwsd
    chown -R cool:cool /usr/share/coolwsd
    chown -R cool:cool /etc/coolwsd
    setcap cap_fowner,cap_chown,cap_mknod,cap_sys_chroot=ep /usr/bin/coolforkit
    setcap cap_sys_admin=ep /usr/bin/coolmount
    sudo -u cool coolwsd-systemplate-setup /var/lib/coolwsd/systemplate /usr/share/coolwsd/instdir 1>/dev/null
