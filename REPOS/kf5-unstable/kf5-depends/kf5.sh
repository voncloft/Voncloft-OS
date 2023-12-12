        # Begin /etc/profile.d/kf5.sh
        if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
                export $(dbus-launch)
        fi

        export KF5_PREFIX=/usr

        # End /etc/profile.d/kf5.sh
