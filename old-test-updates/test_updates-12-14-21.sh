sed -i -e "s/version=0.3.40/version=0.3.41/g" core/pipewire/spkgbuild
changelog "core/pipewire/spkgbuild" "Upgraded from version 0.3.40 to version 0.3.41"
sed -i -e "s/version=3.00/version=3.01/g" core/sysvinit/spkgbuild
changelog "core/sysvinit/spkgbuild" "Upgraded from version 3.00 to version 3.01"
sed -i -e "s,git+https://gitlab.gnome.org/GNOME/gnome-themes-extra.git#commit=b3e935355afcfb5240bac5a99707ffecc35772a2,git+https://gitlab.gnome.org/GNOME/gnome-themes-extra.git#commit=b3e935355afcfb5240bac5a99707ffecc35772a2,g" gnome/gnome-themes-extra/spkgbuild
sed -i -e "s/version=3.28/version=3.28+r6+g45b1d457/g" gnome/gnome-themes-extra/spkgbuild
changelog "gnome/gnome-themes-extra/spkgbuild" "Upgraded from version 3.28 to version 3.28+r6+g45b1d457"
sed -i -e "s/version=1.19.2/version=1.19.3/g" libs/libinput/spkgbuild
changelog "libs/libinput/spkgbuild" "Upgraded from version 1.19.2 to version 1.19.3"
sed -i -e "s/version=1.12/version=1.99.1/g" libs/libwacom/spkgbuild
changelog "libs/libwacom/spkgbuild" "Upgraded from version 1.12 to version 1.99.1"
sed -i -e "s,https://wayland.freedesktop.org/releases/wayland-1.19.0.tar.xz,https://wayland.freedesktop.org/releases/wayland-1.20.0.tar.xz{,.sig},g" libs/wayland/spkgbuild
sed -i -e "s/version=1.19.0/version=1.20.0/g" libs/wayland/spkgbuild
changelog "libs/wayland/spkgbuild" "Upgraded from version 1.19.0 to version 1.20.0"
sed -i -e "s/version=96.0b3/version=96.0b4/g" networking/firefox/spkgbuild
changelog "networking/firefox/spkgbuild" "Upgraded from version 96.0b3 to version 96.0b4"
sed -i -e "s,http://us.download.nvidia.com/XFree86/Linux-x86_64/$version/NVIDIA-Linux-x86_64-$version.run,http://us.download.nvidia.com/XFree86/Linux-x86_64/495.44/NVIDIA-Linux-x86_64-495.44.run nvidia-drm-outputclass.conf,g" nonfree/nvidia/spkgbuild
sed -i -e "s/version=495.44/version=495.46/g" nonfree/nvidia/spkgbuild
changelog "nonfree/nvidia/spkgbuild" "Upgraded from version 495.44 to version 495.46"
sed -i -e "s,https://cpan.metacpan.org/authors/id/P/PL/PLICEASE/Alien-Build-2.42.tar.gz,https://cpan.metacpan.org/authors/id/P/PL/PLICEASE/Alien-Build-2.44.tar.gz,g" perl/perl-alien-build/spkgbuild
sed -i -e "s/version=2.42/version=2.44/g" perl/perl-alien-build/spkgbuild
changelog "perl/perl-alien-build/spkgbuild" "Upgraded from version 2.42 to version 2.44"
sed -i -e "s,https://cpan.metacpan.org/authors/id/M/MA/MAUKE/Return-MultiLevel-0.05.tar.gz,https://cpan.metacpan.org/authors/id/P/PL/PLICEASE/Return-MultiLevel-0.06.tar.gz,g" perl/perl-return-multilevel/spkgbuild
sed -i -e "s/version=0.05/version=0.06/g" perl/perl-return-multilevel/spkgbuild
changelog "perl/perl-return-multilevel/spkgbuild" "Upgraded from version 0.05 to version 0.06"
sed -i -e "s/version=5.0.6/version=5.0.7/g" python/python-amqp/spkgbuild
changelog "python/python-amqp/spkgbuild" "Upgraded from version 5.0.6 to version 5.0.7"
sed -i -e "s,https://files.pythonhosted.org/packages/source/d/django_compressor/django_compressor-2.4.1.tar.gz,https://files.pythonhosted.org/packages/source/d/django_compressor/django_compressor-3.0.tar.gz,g" python/python-django-compressor/spkgbuild
sed -i -e "s/version=2.4.1/version=3.0/g" python/python-django-compressor/spkgbuild
changelog "python/python-django-compressor/spkgbuild" "Upgraded from version 2.4.1 to version 3.0"
sed -i -e "s/version=3.12.4/version=3.13.0/g" python/python-django-rest-framework/spkgbuild
changelog "python/python-django-rest-framework/spkgbuild" "Upgraded from version 3.12.4 to version 3.13.0"
sed -i -e "s,https://files.pythonhosted.org/packages/source/g/google-api-core/google-api-core-2.2.2.tar.gz,https://files.pythonhosted.org/packages/source/g/google-api-core/google-api-core-2.3.0.tar.gz,g" python/python-google-api-core/spkgbuild
sed -i -e "s/version=2.2.2/version=2.3.0/g" python/python-google-api-core/spkgbuild
changelog "python/python-google-api-core/spkgbuild" "Upgraded from version 2.2.2 to version 2.3.0"
sed -i -e "s,https://pypi.io/packages/source/j/jupyterlab_server/jupyterlab_server-2.8.2.tar.gz,https://pypi.io/packages/source/j/jupyterlab_server/jupyterlab_server-2.9.0.tar.gz,g" python/python-jupyterlab_server/spkgbuild
sed -i -e "s/version=2.8.2/version=2.9.0/g" python/python-jupyterlab_server/spkgbuild
changelog "python/python-jupyterlab_server/spkgbuild" "Upgraded from version 2.8.2 to version 2.9.0"
sed -i -e "s/version=4.7.0/version=4.7.1/g" python/python-lxml/spkgbuild
changelog "python/python-lxml/spkgbuild" "Upgraded from version 4.7.0 to version 4.7.1"
sed -i -e "s,https://files.pythonhosted.org/packages/source/p/prompt_toolkit/prompt_toolkit-3.0.22.tar.gz,https://files.pythonhosted.org/packages/source/p/prompt_toolkit/prompt_toolkit-3.0.24.tar.gz,g" python/python-prompt_toolkit/spkgbuild
sed -i -e "s/version=3.0.22/version=3.0.24/g" python/python-prompt_toolkit/spkgbuild
changelog "python/python-prompt_toolkit/spkgbuild" "Upgraded from version 3.0.22 to version 3.0.24"
sed -i -e "s/version=2.0.1/version=2.0.2/g" python/python-pytest-timeout/spkgbuild
changelog "python/python-pytest-timeout/spkgbuild" "Upgraded from version 2.0.1 to version 2.0.2"
sed -i -e "s/version=5.2.1/version=5.2.2/g" python/python-qtconsole/spkgbuild
changelog "python/python-qtconsole/spkgbuild" "Upgraded from version 5.2.1 to version 5.2.2"
sed -i -e "s/version=31.0/version=32.0/g" python/python-readme-renderer/spkgbuild
changelog "python/python-readme-renderer/spkgbuild" "Upgraded from version 31.0 to version 32.0"
sed -i -e "s,https://files.pythonhosted.org/packages/source/r/reportlab/reportlab-3.6.2.tar.gz,https://files.pythonhosted.org/packages/source/r/reportlab/reportlab-3.6.3.tar.gz,g" python/python-reportlab/spkgbuild
sed -i -e "s/version=3.6.2/version=3.6.3/g" python/python-reportlab/spkgbuild
changelog "python/python-reportlab/spkgbuild" "Upgraded from version 3.6.2 to version 3.6.3"
sed -i -e "s,https://pypi.io/packages/source/t/tinycss2/tinycss2-1.1.0.tar.gz,https://pypi.io/packages/source/t/tinycss2/tinycss2-1.1.1.tar.gz,g" python/python-tinycss2/spkgbuild
sed -i -e "s/version=1.1.0/version=1.1.1/g" python/python-tinycss2/spkgbuild
changelog "python/python-tinycss2/spkgbuild" "Upgraded from version 1.1.0 to version 1.1.1"
sed -i -e "s,https://invent.kde.org/qt/qt/qtsvg/-/archive/v$version/qtsvg-v$version.tar.gz,git+https://invent.kde.org/qt/qt/qtspeech-everywhere-src-5.15.2#commit=b3e935355afcfb5240bac5a99707ffecc35772a2,g" qt/qt5-svg/spkgbuild
sed -i -e "s/version=5.12.12/version=5.15.2+kde+r13/g" qt/qt5-svg/spkgbuild
changelog "qt/qt5-svg/spkgbuild" "Upgraded from version 5.12.12 to version 5.15.2+kde+r13"
sed -i -e "s/version=20211207/version=20211214/g" core/scratchpkg/spkgbuild
changelog "core/scratchpkg/spkgbuild" "Upgraded from version 20211207 to version 20211214"
