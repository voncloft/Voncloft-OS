sed -i -e "s/version=100.0b1/version=100.0b2/g" networking/firefox/spkgbuild
changelog "networking/firefox/spkgbuild" "Upgraded from version 100.0b1 to version 100.0b2"
sed -i -e "s/version=99.0b2/version=100.0b1/g" networking/thunderbird/spkgbuild
changelog "networking/thunderbird/spkgbuild" "Upgraded from version 99.0b2 to version 100.0b1"
sed -i -e "s/version=1.44.0/version=1.45.0/g" python/python-aws-sam-translator/spkgbuild
changelog "python/python-aws-sam-translator/spkgbuild" "Upgraded from version 1.44.0 to version 1.45.0"
sed -i -e "s/version=1.21.34/version=1.21.35/g" python/python-boto3/spkgbuild
changelog "python/python-boto3/spkgbuild" "Upgraded from version 1.21.34 to version 1.21.35"
sed -i -e "s/version=1.24.34/version=1.24.35/g" python/python-botocore/spkgbuild
changelog "python/python-botocore/spkgbuild" "Upgraded from version 1.24.34 to version 1.24.35"
sed -i -e "s/version=3.9.1/version=3.10.0/g" python/python-chameleon/spkgbuild
changelog "python/python-chameleon/spkgbuild" "Upgraded from version 3.9.1 to version 3.10.0"
sed -i -e "s/version=10.0.4/version=11.0.0/g" python/python-pdoc/spkgbuild
changelog "python/python-pdoc/spkgbuild" "Upgraded from version 10.0.4 to version 11.0.0"
sed -i -e "s/version=0.13.1/version=0.14.0/g" python/python-prometheus_client/spkgbuild
changelog "python/python-prometheus_client/spkgbuild" "Upgraded from version 0.13.1 to version 0.14.0"
sed -i -e "s/version=2.3.1/version=2.3.2/g" python/python-soupsieve/spkgbuild
changelog "python/python-soupsieve/spkgbuild" "Upgraded from version 2.3.1 to version 2.3.2"
sed -i -e "s/version=5.1.0/version=5.2.0/g" python/python-ujson/spkgbuild
changelog "python/python-ujson/spkgbuild" "Upgraded from version 5.1.0 to version 5.2.0"
