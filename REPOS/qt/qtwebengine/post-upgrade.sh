QT5DIR=/usr
find $QT5DIR/ -name \*.prl \
   -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' {} \;
ln -svf /usr/bin/python{3,}

