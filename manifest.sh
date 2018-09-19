#!/usr/bin/env bash

CPUS=$( grep -c '^processor	' /proc/cpuinfo )
if ! [ "${CPUS}" -gt 0 ];then
	CPUS=2
else
	CPUS=$(( CPUS + 2 ))
fi

export TD="/tmp/manifest.${$}"
mkdir "${TD}"
trap 'rm -rf ${TD}' SIGHUP SIGINT SIGTERM
for x in "${@}";do
	if [ ! -d "${x}" ]; then
		echo "Missing path ${x}"
		continue
	fi
	find "${x}/" -xdev -type f -print0 | xargs -0 -n 1024 -P "${CPUS}" manifest_runner.sh
done
sort "${TD}/"*
