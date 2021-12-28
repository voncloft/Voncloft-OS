sed -i -e "s/version=3.6.1/version=3.8.0/g" core/fortune-mod/spkgbuild
changelog "core/fortune-mod/spkgbuild" "Upgraded from version 3.6.1 to version 3.8.0"
sed -i -e "s,https://gitlab.freedesktop.org/upower/upower/uploads/93cfe7c8d66ed486001c4f3f55399b7a/upower-0.99.11.tar.xz,git+https://gitlab.freedesktop.org/upower/upower.git#commit=0787787f863fe34531ee2670a9277e2b327a3b42,g" core/upower/spkgbuild
sed -i -e "s/version=0.99.11/version=0.99.13/g" core/upower/spkgbuild
changelog "core/upower/spkgbuild" "Upgraded from version 0.99.11 to version 0.99.13"
sed -i -e "s/version=3.18/version=3.18.1/g" core/valgrind/spkgbuild
changelog "core/valgrind/spkgbuild" "Upgraded from version 3.18 to version 3.18.1"
sed -i -e "s/version=96.0b1/version=96.0b2/g" networking/thunderbird/spkgbuild
changelog "networking/thunderbird/spkgbuild" "Upgraded from version 96.0b1 to version 96.0b2"
sed -i -e "s/version=3.10.0/version=3.11.0/g" python/python/spkgbuild
changelog "python/python/spkgbuild" "Upgraded from version 3.10.0 to version 3.11.0"
sed -i -e "s/version=2.0.1/version=2.1.0/g" python/python-aiobotocore/spkgbuild
changelog "python/python-aiobotocore/spkgbuild" "Upgraded from version 2.0.1 to version 2.1.0"
sed -i -e "s/version=1.20.23/version=1.20.24/g" python/python-boto3/spkgbuild
changelog "python/python-boto3/spkgbuild" "Upgraded from version 1.20.23 to version 1.20.24"
sed -i -e "s/version=1.23.23/version=1.23.24/g" python/python-botocore/spkgbuild
changelog "python/python-botocore/spkgbuild" "Upgraded from version 1.23.23 to version 1.23.24"
sed -i -e "s/version=0.6.0/version=0.7.0/g" python/python-cmarkgfm/spkgbuild
changelog "python/python-cmarkgfm/spkgbuild" "Upgraded from version 0.6.0 to version 0.7.0"
sed -i -e "s/version=3.3.8/version=3.4.1/g" python/python-hunter/spkgbuild
changelog "python/python-hunter/spkgbuild" "Upgraded from version 3.3.8 to version 3.4.1"
sed -i -e "s/version=6.31.4/version=6.31.5/g" python/python-hypothesis/spkgbuild
changelog "python/python-hypothesis/spkgbuild" "Upgraded from version 6.31.4 to version 6.31.5"
sed -i -e "s,https://files.pythonhosted.org/packages/source/n/natsort/natsort-8.0.1.tar.gz,https://files.pythonhosted.org/packages/source/n/natsort/natsort-8.0.2.tar.gz,g" python/python-natsort/spkgbuild
sed -i -e "s/version=8.0.1/version=8.0.2/g" python/python-natsort/spkgbuild
changelog "python/python-natsort/spkgbuild" "Upgraded from version 8.0.1 to version 8.0.2"
