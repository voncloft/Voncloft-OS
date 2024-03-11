        QT6DIR=/usr
# Begin kf6 extension for /etc/profile.d/qt6.sh

pathappend /usr/lib/plugins        QT_PLUGIN_PATH
pathappend $QT6DIR/lib/plugins     QT_PLUGIN_PATH

pathappend /usr/lib/qt6/qml        QML2_IMPORT_PATH
pathappend $QT6DIR/lib/qml         QML2_IMPORT_PATH

# End extension for /etc/profile.d/qt6.sh

