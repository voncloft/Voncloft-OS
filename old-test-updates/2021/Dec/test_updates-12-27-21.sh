sed -i -e "s/version=1.34.1/version=1.35.0/g" core/busybox/spkgbuild
changelog "core/busybox/spkgbuild" "Upgraded from version 1.34.1 to version 1.35.0"
sed -i -e "s,https://downloads.sourceforge.net/w3m/$name-$version.tar.gz,git+https://salsa.debian.org/debian/w3m.git#commit=,g" core/w3m/spkgbuild
sed -i -e "s/version=0.5.3/version=0.5.3.git20210102_6/g" core/w3m/spkgbuild
changelog "core/w3m/spkgbuild" "Upgraded from version 0.5.3 to version 0.5.3.git20210102_6"
sed -i -e "s/version=0.9.74/version=0.9.75/g" libs/libmicrohttpd/spkgbuild
changelog "libs/libmicrohttpd/spkgbuild" "Upgraded from version 0.9.74 to version 0.9.75"
sed -i -e "s/version=4.17.2/version=4.17.3/g" libs/libxfce4ui/spkgbuild
changelog "libs/libxfce4ui/spkgbuild" "Upgraded from version 4.17.2 to version 4.17.3"
sed -i -e "s/version=2021.12.25/version=2021.12.27/g" networking/yt-dlp/spkgbuild
changelog "networking/yt-dlp/spkgbuild" "Upgraded from version 2021.12.25 to version 2021.12.27"
sed -i -e "s/version=2.1.0rc1/version=2.1.1/g" python/python-gmpy2/spkgbuild
changelog "python/python-gmpy2/spkgbuild" "Upgraded from version 2.1.0rc1 to version 2.1.1"
sed -i -e "s,/j/jaraco.text/jaraco.text-.tar.gz,/j/jaraco.text/jaraco.text-.tar.gz,g" python/python-jaraco/spkgbuild
sed -i -e "s/version=2021.03.28/version=2021.12.20/g" python/python-jaraco/spkgbuild
changelog "python/python-jaraco/spkgbuild" "Upgraded from version 2021.03.28 to version 2021.12.20"
sed -i -e "s/version=1.29.1/version=1.30.0/g" ruby-gems/ruby-tins/spkgbuild
changelog "ruby-gems/ruby-tins/spkgbuild" "Upgraded from version 1.29.1 to version 1.30.0"
sed -i -e "s/version=0.3.1/version=0.4.0/g" kf5/kalendar/spkgbuild
changelog "kf5/kalendar/spkgbuild" "Upgraded from version 0.3.1 to version 0.4.0"
sed -i -e "s/version=2.2.6/version=2.2.7/g" libs/xapp/spkgbuild
changelog "libs/xapp/spkgbuild" "Upgraded from version 2.2.6 to version 2.2.7"
sed -i -e "s/version=10.0.0/version=11.0.0/g" python/python-faker/spkgbuild
changelog "python/python-faker/spkgbuild" "Upgraded from version 10.0.0 to version 11.0.0"
sed -i -e "s/version=0.7/version=1.0.0/g" python/python-kikit/spkgbuild
changelog "python/python-kikit/spkgbuild" "Upgraded from version 0.7 to version 1.0.0"
