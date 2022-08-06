#!/bin/sh


for F in /opt/texlive/2022/texmf-dist/scripts/latex-make/*.py ; do
  test -f $F && sed -i 's%/usr/bin/env python%/usr/bin/python3%' $F || true
done

