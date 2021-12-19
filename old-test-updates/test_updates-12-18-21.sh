sed -i -e "s/version=1.0.2/version=1.0.3/g" python/python-linkify-it-py/spkgbuild
changelog "python/python-linkify-it-py/spkgbuild" "Upgraded from version 1.0.2 to version 1.0.3"
sed -i -e "s/version=0.59/version=0.60/g" python/python-memory-profiler/spkgbuild
changelog "python/python-memory-profiler/spkgbuild" "Upgraded from version 0.59 to version 0.60"
sed -i -e "s/version=2021.2/version=2021.2.2/g" python/python-pudb/spkgbuild
changelog "python/python-pudb/spkgbuild" "Upgraded from version 2021.2 to version 2021.2.2"
sed -i -e "s/version=59.6.0/version=59.7.0/g" python/python-setuptools/spkgbuild
changelog "python/python-setuptools/spkgbuild" "Upgraded from version 59.6.0 to version 59.7.0"
sed -i -e "s,https://pypi.io/packages/source/t/testflo/testflo-1.4.6.tar.gz,https://pypi.io/packages/source/t/testflo/testflo-1.4.7.tar.gz,g" python/python-testflo/spkgbuild
sed -i -e "s/version=1.4.6/version=1.4.7/g" python/python-testflo/spkgbuild
changelog "python/python-testflo/spkgbuild" "Upgraded from version 1.4.6 to version 1.4.7"
sed -i -e "s,https://pypi.org/packages/source/p/python-utils/python-utils-2.6.0.tar.gz,https://pypi.org/packages/source/p/python-utils/python-utils-2.6.3.tar.gz,g" python/python-utils/spkgbuild
sed -i -e "s/version=2.6.0/version=2.6.3/g" python/python-utils/spkgbuild
changelog "python/python-utils/spkgbuild" "Upgraded from version 2.6.0 to version 2.6.3"
