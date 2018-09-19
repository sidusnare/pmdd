#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:/usr/x86_64-pc-linux-gnu/gcc-bin/4.9.3"
FILE="/var/log/manifest.$(date -I).$(date +%s).log"
if [ -e "${FILE}" ]; then
	exit 1
fi

touch "${FILE}"
time /usr/local/bin/manifest.sh /mnt/Tome/  > "${FILE}"
if [ -e /var/log/manifest.log ]; then
	mv /var/log/manifest.log /var/log/manifest.last.log
else
	echo "Missing last manifest" >&2
fi
ln -sf "${FILE}" /var/log/manifest.log
chmod 0600 "${FILE}" "${FILE}.old"
