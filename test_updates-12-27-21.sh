sed -i -e "s/version=1.34.1/version=1.35.0/g" core/busybox/spkgbuild
changelog "core/busybox/spkgbuild" "Upgraded from version 1.34.1 to version 1.35.0"
sed -i -e "s/version=0.3.1/version=0.4.0/g" kf5/kalendar/spkgbuild
changelog "kf5/kalendar/spkgbuild" "Upgraded from version 0.3.1 to version 0.4.0"
sed -i -e "s/version=0.9.74/version=0.9.75/g" libs/libmicrohttpd/spkgbuild
changelog "libs/libmicrohttpd/spkgbuild" "Upgraded from version 0.9.74 to version 0.9.75"
sed -i -e "s,/j/jaraco.text/jaraco.text-.tar.gz,/j/jaraco.text/jaraco.text-.tar.gz,g" python/python-jaraco/spkgbuild
sed -i -e "s/version=2021.03.28/version=2021.12.20/g" python/python-jaraco/spkgbuild
changelog "python/python-jaraco/spkgbuild" "Upgraded from version 2021.03.28 to version 2021.12.20"
