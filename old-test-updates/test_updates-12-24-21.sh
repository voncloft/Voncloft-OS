sed -i -e "s/version=96.0b8/version=96.0b9/g" networking/firefox/spkgbuild
changelog "networking/firefox/spkgbuild" "Upgraded from version 96.0b8 to version 96.0b9"
sed -i -e "s,https://search.cpan.org/CPAN/authors/id/S/SH/SHLOMIF/IO-Socket-INET6-2.72.tar.gz,https://search.cpan.org/CPAN/authors/id/S/SH/SHLOMIF/IO-Socket-INET6-2.73.tar.gz,g" perl/perl-io-socket-inet6/spkgbuild
sed -i -e "s/version=2.72/version=2.73/g" perl/perl-io-socket-inet6/spkgbuild
changelog "perl/perl-io-socket-inet6/spkgbuild" "Upgraded from version 2.72 to version 2.73"
sed -i -e "s,https://search.cpan.org/CPAN/authors/id/I/IS/ISHIGAKI/JSON-4.03.tar.gz,https://search.cpan.org/CPAN/authors/id/I/IS/ISHIGAKI/JSON-4.04.tar.gz,g" perl/perl-json/spkgbuild
sed -i -e "s/version=4.03/version=4.04/g" perl/perl-json/spkgbuild
changelog "perl/perl-json/spkgbuild" "Upgraded from version 4.03 to version 4.04"
sed -i -e "s/version=3.0.0/version=3.1.0/g" python/python-mypy-protobuf/spkgbuild
changelog "python/python-mypy-protobuf/spkgbuild" "Upgraded from version 3.0.0 to version 3.1.0"
sed -i -e "s/version=2.8.1/version=2.9.1/g" python/python-paramiko/spkgbuild
changelog "python/python-paramiko/spkgbuild" "Upgraded from version 2.8.1 to version 2.9.1"
sed -i -e "s/version=0.4.1/version=0.5.0/g" python/python-pytest-socket/spkgbuild
changelog "python/python-pytest-socket/spkgbuild" "Upgraded from version 0.4.1 to version 0.5.0"
sed -i -e "s/version=60.0.5/version=60.1.0/g" python/python-setuptools/spkgbuild
changelog "python/python-setuptools/spkgbuild" "Upgraded from version 60.0.5 to version 60.1.0"
sed -i -e "s,https://files.pythonhosted.org/packages/source/t/tomlkit/tomlkit-0.7.2.tar.gz,https://files.pythonhosted.org/packages/source/t/tomlkit/tomlkit-0.8.0.tar.gz,g" python/python-tomlkit/spkgbuild
sed -i -e "s/version=0.7.2/version=0.8.0/g" python/python-tomlkit/spkgbuild
changelog "python/python-tomlkit/spkgbuild" "Upgraded from version 0.7.2 to version 0.8.0"
sed -i -e "s/version=0.37.0/version=0.38.1/g" python/python-zeroconf/spkgbuild
changelog "python/python-zeroconf/spkgbuild" "Upgraded from version 0.37.0 to version 0.38.1"
sed -i -e "s/version=2.3.1/version=2.3.3/g" ruby-gems/ruby-bundler/spkgbuild
changelog "ruby-gems/ruby-bundler/spkgbuild" "Upgraded from version 2.3.1 to version 2.3.3"
