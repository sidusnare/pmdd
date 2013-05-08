#!/usr/bin/python3
import argparse
import sys
import os
import string 

parser = argparse.ArgumentParser()
parser.add_argument("-v", "--verbose", help="Increase output verbosity.", action="store_true")
args = parser.parse_args()


##############################################################
#Config
separator='  '
errlogname='error.log'
filelist='sorted_file_list.txt'
##############################################################

#Inital values
md5=''
prime=''
#Write an error log
errlog=open(errlogname, 'a')
#loop over entire list
listsize = int(os.stat(filelist).st_size)
loc=0
oldper=0
if args.verbose:
	print("List is " + str(listsize) + " bytes in size\n")
fh=open(filelist)
while loc < listsize:
	line = fh.readline()
	#Line should be in format md5.separator.filename
	dat=line.split(separator, 1)
	filename=dat[1].rstrip('\n')
	newmd5=dat[0]
	#If the new sum isnt like the old sum its a new file
	loc=fh.tell()
	per= 100 * fh.tell() / listsize
	prettyper = int(per)
	if newmd5 != md5:
		if args.verbose:
			print('\nNew unique file, at ' + str(prettyper) +  '%, hash: ' + newmd5 + " prime: " + filename)
		else:
			if  oldper != prettyper:
				print (str(prettyper) + "%")
		md5 = newmd5
		prime = filename
	else:
		if args.verbose:
			print("Same file: " + filename)
		else:
			if  oldper != prettyper:
				print (str(prettyper) + "%")
		try:
			os.rename(filename, filename + 'PYTHONDDUPTMPFILE')
			try:
				os.link(prime, filename)
				try:
					os.unlink(filename + 'PYTHONDDUPTMPFILE')
				except:
					print("ERROR -=- Unable to clean up after: " + filename + ' prime: ' + prime + ' md5: ' + md5)	
					errlog.writelines("ERROR -=- Unable to clean up after: " + filename + ' prime ' + prime + ' md5 ' + md5 + '\n')
			except:
				try:
					os.rename(filename + 'PYTHONDDUPTMPFILE', filename)
				except:
					print("ERROR -=- Lost: " + filename + ' prime ' + prime + ' md5 ' + md5)
					errlog.writelines("ERROR -=- Lost: " + filename + ' prime ' + prime + ' md5 ' + md5 + '\n')

					
		except:
			print('ERROR -=- Skipping attempt for ' + filename + ', unable to move out of way.')
			errlog.writelines('Skipping attempt for ' + filename + ', unable to move out of way.\n')

