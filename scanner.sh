#!/bin/bash

for x in iconv grep sed find sort;do
	if ! which $x 2>&1 >> /dev/null; then
		echo "Please install $x"
	fi
done

if [ -d "$1" ];then
	find "$1" -xdev -type f -exec md5sum '{}' \; | grep -v d41d8cd98f00b204e9800998ecf8427e | sed -e 's/  /☯/g' | iconv -c -t UTF-8 > file_list.txt
else
	echo "You need to specify a directory"
fi
sort file_list.txt > sorted_file_list.txt
