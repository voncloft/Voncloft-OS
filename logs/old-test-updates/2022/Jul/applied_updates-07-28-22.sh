sed -i -e "s/version=104.0b1/version=104.0b2/g" networking/firefox/spkgbuild
changelog "networking/firefox/spkgbuild" "Upgraded from version 104.0b1 to version 104.0b2"
sed -i -e "s/version=22.2/version=22.2.1/g" python/python-pip/spkgbuild
changelog "python/python-pip/spkgbuild" "Upgraded from version 22.2 to version 22.2.1"
sed -i -e "s/version=20.16.0/version=20.16.1/g" python/python-virtualenv/spkgbuild
changelog "python/python-virtualenv/spkgbuild" "Upgraded from version 20.16.0 to version 20.16.1"
sed -i -e "s/version=2.3.18/version=2.3.19/g" ruby-gems/ruby-bundler/spkgbuild
changelog "ruby-gems/ruby-bundler/spkgbuild" "Upgraded from version 2.3.18 to version 2.3.19"
sed -i -e "s/version=2022.7.7/version=2022.8.0/g" server/homeassistant/spkgbuild
changelog "server/homeassistant/spkgbuild" "Upgraded from version 2022.7.7 to version 2022.8.0"
sed -i -e "s/version=4.16.3/version=4.16.4/g" server/samba/spkgbuild
changelog "server/samba/spkgbuild" "Upgraded from version 4.16.3 to version 4.16.4"
