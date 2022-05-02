sed -i -e "s/version=3.2.0/version=4.0.1/g" core/streamlink/spkgbuild
changelog "core/streamlink/spkgbuild" "Upgraded from version 3.2.0 to version 4.0.1"
sed -i -e "s/version=3.2.0/version=3.2.2/g" python/python-bcrypt/spkgbuild
changelog "python/python-bcrypt/spkgbuild" "Upgraded from version 3.2.0 to version 3.2.2"
sed -i -e "s/version=6.45.3/version=6.46.1/g" python/python-hypothesis/spkgbuild
changelog "python/python-hypothesis/spkgbuild" "Upgraded from version 6.45.3 to version 6.46.1"
sed -i -e "s/version=2022.4.21/version=2022.4.30/g" python/python-pipenv/spkgbuild
changelog "python/python-pipenv/spkgbuild" "Upgraded from version 2022.4.21 to version 2022.4.30"
sed -i -e "s/version=0.38.4/version=0.38.5/g" python/python-zeroconf/spkgbuild
changelog "python/python-zeroconf/spkgbuild" "Upgraded from version 0.38.4 to version 0.38.5"
