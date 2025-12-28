sed -i -e "s/version=0.153.2/version=0.153.3/g" core/hugo/spkgbuild
changelog "core/hugo/spkgbuild" "Upgraded from version 0.153.2 to version 0.153.3"
sed -i -e "s/version=1.42.16/version=1.42.17/g" python/python-boto3/spkgbuild
changelog "python/python-boto3/spkgbuild" "Upgraded from version 1.42.16 to version 1.42.17"
sed -i -e "s/version=1.42.16/version=1.42.17/g" python/python-botocore/spkgbuild
changelog "python/python-botocore/spkgbuild" "Upgraded from version 1.42.16 to version 1.42.17"
sed -i -e "s/version=0.127.0/version=0.128.0/g" python/python-fastapi/spkgbuild
changelog "python/python-fastapi/spkgbuild" "Upgraded from version 0.127.0 to version 0.128.0"
sed -i -e "s/version=2.13.0/version=2.14.0/g" python/python-pytest-checkdocs/spkgbuild
changelog "python/python-pytest-checkdocs/spkgbuild" "Upgraded from version 2.13.0 to version 2.14.0"
