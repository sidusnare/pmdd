#!/bin/bash

<<<<<<< Updated upstream
#If you do this often on large data sets, you might want to use nsort instead of sort, its got stupid fast sorting http://www.ordinal.com/

=======
#Make sure we have all the programs we need
>>>>>>> Stashed changes
for x in iconv grep sed find sort;do
	if ! which $x 2>&1 >> /dev/null; then
		echo "Please install $x"
		exit
	fi
done

if [ -d "$1" ];then
	find "$1" -xdev -type f -exec md5sum '{}' \; | grep -v d41d8cd98f00b204e9800998ecf8427e | iconv -c -t UTF-8 > file_list.txt
else
	echo "You need to specify a directory"
	exit
fi
sort -o sorted_file_list.txt file_list.txt
