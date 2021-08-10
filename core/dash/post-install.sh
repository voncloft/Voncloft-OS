#/bin/sh
grep -qe '^/bin/dash$' etc/shells || echo '/bin/dash' >> etc/shells
