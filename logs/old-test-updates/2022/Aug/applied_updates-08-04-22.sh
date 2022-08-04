sed -i -e "s/version=2.37.4/version=2.38/g" core/util-linux/spkgbuild
changelog "core/util-linux/spkgbuild" "Upgraded from version 2.37.4 to version 2.38"
sed -i -e "s/version=2.38/version=2.38.1/g" core/util-linux/spkgbuild
changelog "core/util-linux/spkgbuild" "Upgraded from version 2.38 to version 2.38.1"
sed -i -e "s/version=8.1.8/version=8.1.9/g" server/php/spkgbuild
changelog "server/php/spkgbuild" "Upgraded from version 8.1.8 to version 8.1.9"
sed -i -e "s/version=21.1.4/version=22.1.5/g" hardware/mesa/spkgbuild
changelog "hardware/mesa/spkgbuild" "Upgraded from version 21.1.4 to version 22.1.5"
