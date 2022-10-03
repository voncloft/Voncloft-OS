sed -i -e "s/version=2.27/version=2.28/g" core/links/spkgbuild
changelog "core/links/spkgbuild" "Upgraded from version 2.27 to version 2.28"
sed -i -e "s/version=0.4.0/version=0.4.1/g" libs/libgusb/spkgbuild
changelog "libs/libgusb/spkgbuild" "Upgraded from version 0.4.0 to version 0.4.1"
sed -i -e "s/version=1.7.0/version=1.7.1/g" libs/libmaxminddb/spkgbuild
changelog "libs/libmaxminddb/spkgbuild" "Upgraded from version 1.7.0 to version 1.7.1"
sed -i -e "s/version=4.12.0/version=4.13.0/g" python/python-importlib-metadata/spkgbuild
changelog "python/python-importlib-metadata/spkgbuild" "Upgraded from version 4.12.0 to version 4.13.0"
sed -i -e "s/version=2.1.0/version=2.1.1/g" python/python-xmlschema/spkgbuild
changelog "python/python-xmlschema/spkgbuild" "Upgraded from version 2.1.0 to version 2.1.1"
