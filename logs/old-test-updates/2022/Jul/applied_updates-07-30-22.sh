sed -i -e "s/version=0.9.4/version=0.9.5/g" core/herbstluftwm/spkgbuild
changelog "core/herbstluftwm/spkgbuild" "Upgraded from version 0.9.4 to version 0.9.5"
sed -i -e "s/version=1.17.4/version=1.17.6/g" libs/cairo/spkgbuild
changelog "libs/cairo/spkgbuild" "Upgraded from version 1.17.4 to version 1.17.6"
sed -i -e "s/version=5.0.3/version=6.0.0/g" python/python-docker/spkgbuild
changelog "python/python-docker/spkgbuild" "Upgraded from version 5.0.3 to version 6.0.0"
sed -i -e "s/version=2.0.0/version=2.0.1/g" python/python-flask-caching/spkgbuild
changelog "python/python-flask-caching/spkgbuild" "Upgraded from version 2.0.0 to version 2.0.1"
sed -i -e "s/version=3.7.8/version=3.7.10/g" python/python-orjson/spkgbuild
changelog "python/python-orjson/spkgbuild" "Upgraded from version 3.7.8 to version 3.7.10"
