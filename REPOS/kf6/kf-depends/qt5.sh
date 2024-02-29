        QT5DIR=/usr

        pathappend /usr/lib/qt5/plugins    QT_PLUGIN_PATH
        pathappend $QT5DIR/lib/plugins     QT_PLUGIN_PATH

        pathappend /usr/lib/qt5/qml        QML2_IMPORT_PATH
        pathappend $QT5DIR/lib/qml         QML2_IMPORT_PATH


        # End Qt5 changes for KF5
