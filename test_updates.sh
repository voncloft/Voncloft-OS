sed -i -e "s/version=2.3.2/version=2.3.3/g" core/gnupg/spkgbuild
changelog "core/gnupg/spkgbuild" "Upgraded from version 2.3.2 to version 2.3.3"
sed -i -e "s/version=1.18.59/version=1.18.60/g" python/python-boto3/spkgbuild
changelog "python/python-boto3/spkgbuild" "Upgraded from version 1.18.59 to version 1.18.60"
sed -i -e "s/version=1.21.59/version=1.21.60/g" python/python-botocore/spkgbuild
changelog "python/python-botocore/spkgbuild" "Upgraded from version 1.21.59 to version 1.21.60"
sed -i -e "s,https://files.pythonhosted.org/packages/source/c/calmjs/calmjs-3.4.1.zip,https://files.pythonhosted.org/packages/source/c/calmjs/calmjs-3.4.2.zip,g" python/python-calmjs/spkgbuild
sed -i -e "s/version=3.4.1/version=3.4.2/g" python/python-calmjs/spkgbuild
changelog "python/python-calmjs/spkgbuild" "Upgraded from version 3.4.1 to version 3.4.2"
sed -i -e "s/version=0.0.22/version=0.0.23/g" python/python-pip-api/spkgbuild
changelog "python/python-pip-api/spkgbuild" "Upgraded from version 0.0.22 to version 0.0.23"
