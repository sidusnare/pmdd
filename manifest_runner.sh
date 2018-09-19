#!/usr/bin/env bash
#Format: MD5Sum|iNode|Size in bytes|type|name
if [ -z "$TD" ]; then
	echo "Unable to find temporary directory"
fi
OUT=()
for x in "${@}";do
	if [ ! -f "${x}" ]; then
		continue
	fi
	MD=$(md5sum "${x}" | awk '{print($1)}' | head -n 1)
	FILE=$(file -z -N -F '' -0 "${x}" | tr '\000' '\n' | tail -n 1 | sed -e 's/^ a //' -e 's/^ //' -e 's/|//g')
	IN=$(stat '--format=%i|%s' "${x}")
	OUT+=( "${MD}|${IN}|${FILE}|${x}" ) 
done
printf "%s\n" "${OUT[@]}" >> "${TD}/${$}"
exit 0
