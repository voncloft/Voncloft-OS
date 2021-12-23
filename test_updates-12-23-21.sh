sed -i -e "s/version=0.60.2/version=0.60.3/g" compilers/meson/spkgbuild
changelog "compilers/meson/spkgbuild" "Upgraded from version 0.60.2 to version 0.60.3"
sed -i -e "s/version=0.91.0/version=0.91.1/g" core/hugo/spkgbuild
changelog "core/hugo/spkgbuild" "Upgraded from version 0.91.0 to version 0.91.1"
sed -i -e "s/version=3.2.6/version=3.2.7/g" extra/flexget/spkgbuild
changelog "extra/flexget/spkgbuild" "Upgraded from version 3.2.6 to version 3.2.7"
sed -i -e "s/version=1.5.0/version=1.5.1/g" media/chromaprint/spkgbuild
changelog "media/chromaprint/spkgbuild" "Upgraded from version 1.5.0 to version 1.5.1"
sed -i -e "s/version=96.0b7/version=96.0b8/g" networking/firefox/spkgbuild
changelog "networking/firefox/spkgbuild" "Upgraded from version 96.0b7 to version 96.0b8"
sed -i -e "s,https://search.cpan.org/CPAN/authors/id/O/OA/OALDERS/HTTP-Message-6.33.tar.gz,https://search.cpan.org/CPAN/authors/id/O/OA/OALDERS/HTTP-Message-6.34.tar.gz,g" perl/perl-http-message/spkgbuild
sed -i -e "s/version=6.33/version=6.34/g" perl/perl-http-message/spkgbuild
changelog "perl/perl-http-message/spkgbuild" "Upgraded from version 6.33 to version 6.34"
sed -i -e "s,https://pypi.io/packages/source/j/jupyterlab_server/jupyterlab_server-2.9.0.tar.gz,https://pypi.io/packages/source/j/jupyterlab_server/jupyterlab_server-2.10.1.tar.gz,g" python/python-jupyterlab_server/spkgbuild
sed -i -e "s/version=2.9.0/version=2.10.1/g" python/python-jupyterlab_server/spkgbuild
changelog "python/python-jupyterlab_server/spkgbuild" "Upgraded from version 2.9.0 to version 2.10.1"
sed -i -e "s/version=1.11.3/version=2.0.0/g" python/python-qtpy/spkgbuild
changelog "python/python-qtpy/spkgbuild" "Upgraded from version 1.11.3 to version 2.0.0"
sed -i -e "s/version=60.0.3/version=60.0.4/g" python/python-setuptools/spkgbuild
changelog "python/python-setuptools/spkgbuild" "Upgraded from version 60.0.3 to version 60.0.4"
sed -i -e "s/version=0.37.0/version=0.37.1/g" python/python-wheel/spkgbuild
changelog "python/python-wheel/spkgbuild" "Upgraded from version 0.37.0 to version 0.37.1"
