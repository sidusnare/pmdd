pmdd
====

Poor Mans Data Deduplicator

Warnings
==
This script deletes files. It may delete files you are fond of. Have a backup.
Only you are responsible for any losses that arise from the use of these scripts. 
Read the scripts, understand the scrips.
It's probably best if you just use these as inspiration for your own scripts.

This script deletes your files.

This script deletes your files.

This script deletes your files.

This script deletes your files.

This script deletes your files.

This script deletes your files.

This script deletes your files.

This script deletes your files.

This script deletes your files.

This script deletes your files.

This script deletes your files.

The linker is parallel bash via xargs, it will run the number of CPU cores presented to Linux + two.
To Do
==
* Compare logs to detect changed data / bitrot
* Excludes for linking script

Objective
==
* Keep track of data changes to detect bitrot and anything unexpected tampering with files.
* De-Duplicate data on the file level by hard linking equivocal files.

Use Case
==
Large store of static read only data files. Perhaps multiple whole-system dump style backups you don't really want to delete, but aren't really that important. Perhaps your media server's file layout is so messy you don't know whats in how many different places.

Do-Not-Use Case
==
* Shared network dive with write access. 
* Any set of data someone else might use, especially write to.
* If you don't know what hard links are and/or an inode is, you need to find out, and understand the full ramifications of what a hard link is.
* Enterprise grade users have better solutions



License / Disclaimer
==
pmdd - Poor Mans Data Deduplicator
Copyright (C) 2013 Fred Dinkler IV

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License 
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
