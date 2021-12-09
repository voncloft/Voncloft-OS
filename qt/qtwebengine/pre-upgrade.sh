QT5DIR=/usr
if [ -e ${QT5DIR}/lib/libQt5WebEngineCore.so ]; then
  mv -v ${QT5DIR}/lib/libQt5WebEngineCore.so{,.old}
fi
