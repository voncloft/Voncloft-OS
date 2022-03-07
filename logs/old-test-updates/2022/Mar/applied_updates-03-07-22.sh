sed -i -e "s/version=1.17.0/version=1.17.1/g" libs/gpgme/spkgbuild
changelog "libs/gpgme/spkgbuild" "Upgraded from version 1.17.0 to version 1.17.1"
sed -i -e "s/version=5.0.9/version=5.1.0/g" python/python-amqp/spkgbuild
changelog "python/python-amqp/spkgbuild" "Upgraded from version 5.0.9 to version 5.1.0"
sed -i -e "s/version=5.2.3/version=5.2.4/g" python/python-kombu/spkgbuild
changelog "python/python-kombu/spkgbuild" "Upgraded from version 5.2.3 to version 5.2.4"
sed -i -e "s/version=5.15.2/version=5.15.3/g" qt/qt5-multimedia/spkgbuild
changelog "qt/qt5-multimedia/spkgbuild" "Upgraded from version 5.15.2 to version 5.15.3"
sed -i -e "s/version=5.15.2/version=5.15.3/g" qt/qt5-speech/spkgbuild
changelog "qt/qt5-speech/spkgbuild" "Upgraded from version 5.15.2 to version 5.15.3"
