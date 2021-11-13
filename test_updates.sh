sed -i -e "s,,,g" beta/plasma-meta/spkgbuild
sed -i -e "s/version=5.21.1/version=5.23/g" beta/plasma-meta/spkgbuild
changelog "beta/plasma-meta/spkgbuild" "Upgraded from version 5.21.1 to version 5.23"
