#!/usr/bin/python3
import sys
import os
import string 


##############################################################
#Config
separator='☯'
errlog='error.log'
filelist='a3'
##############################################################

#Inital values
md5=''
prime=''
errlog=open('error.log', 'a')
for line in open(filelist):
	dat=line.split(separator, 1)
	filename=dat[1].rstrip('\n')
	newmd5=dat[0]

	if newmd5 != md5:
		print('\nNew unique file, hash: ' + newmd5 + " prime: " + filename)
		md5 = newmd5
		prime = filename
	else:
		print("Same file: " + filename)
		try:
			os.rename(filename, filename + 'PYTHONDDUPTMPFILE')
			try:
				os.link(prime, filename)
				try:
					os.unlink(filename + 'PYTHONDDUPTMPFILE')
				except:
					print("ERROR -=- Unable to clean up after: " + separator + filename + separator + ' prime ' + separator + prime + separator + ' md5 ' + separator + md5 + separator)	
			except:
				try:
					os.rename(filename + 'PYTHONDDUPTMPFILE', filename)
				except:
					print("ERROR -=- Lost: " + separator + filename + separator + ' prime ' + separator + prime + separator + ' md5 ' + separator + md5 + separator)
					errlog.writelines("ERROR -=- Lost: " + separator + filename + separator + ' prime ' + separator + prime + separator + ' md5 ' + separator + md5 + separator + '\n')

					
		except:
			print('Skipping attempt for ' + filename + ', unable to move out of way.')
			errlog.writelines('Skipping attempt for ' + filename + ', unable to move out of way.')
	#ef it isnt, we will link the file to the old prime

		#move file to backup

		#hard link into place

		#if successful remove old


#loop

