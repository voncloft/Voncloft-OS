        # Begin /etc/profile.d/k65.sh
        if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
                export $(dbus-launch)
        fi

        export KF6_PREFIX=/usr

        # End /etc/profile.d/kf6.sh
