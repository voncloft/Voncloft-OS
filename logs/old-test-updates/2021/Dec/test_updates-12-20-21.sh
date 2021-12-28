sed -i -e "s/version=0.4.32/version=0.4.34/g" core/gegl/spkgbuild
changelog "core/gegl/spkgbuild" "Upgraded from version 0.4.32 to version 0.4.34"
sed -i -e "s/version=0.9.73/version=0.9.74/g" libs/libmicrohttpd/spkgbuild
changelog "libs/libmicrohttpd/spkgbuild" "Upgraded from version 0.9.73 to version 0.9.74"
sed -i -e "s/version=5.0.7/version=5.0.8/g" python/python-amqp/spkgbuild
changelog "python/python-amqp/spkgbuild" "Upgraded from version 5.0.7 to version 5.0.8"
sed -i -e "s,https://files.pythonhosted.org/packages/source/d/django_compressor/django_compressor-3.0.tar.gz,https://files.pythonhosted.org/packages/source/d/django_compressor/django_compressor-3.1.tar.gz,g" python/python-django-compressor/spkgbuild
sed -i -e "s/version=3.0/version=3.1/g" python/python-django-compressor/spkgbuild
changelog "python/python-django-compressor/spkgbuild" "Upgraded from version 3.0 to version 3.1"
sed -i -e "s/version=4.28.4/version=4.28.5/g" python/python-fonttools/spkgbuild
changelog "python/python-fonttools/spkgbuild" "Upgraded from version 4.28.4 to version 4.28.5"
sed -i -e "s/version=1.8.2/version=1.9.0/g" python/python-pydantic/spkgbuild
changelog "python/python-pydantic/spkgbuild" "Upgraded from version 1.8.2 to version 1.9.0"
