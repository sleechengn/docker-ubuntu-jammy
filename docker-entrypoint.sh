#!/usr/bin/bash

if [ -e "/chrootpw.sh" ] ; then 
	/chrootpw.sh
	rm -rf /chrootpw.sh
fi

/usr/sbin/sshd
/usr/bin/tail -f /dev/null
