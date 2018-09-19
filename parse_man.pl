#!/usr/bin/perl

#use strict;
#use warnings;

#This script deletes your data. Read it and understand it before use. 
#It relies on a sorted manifest

my $minsize = 600000;
my $filename = '/var/log/manifest.log';
my $lastfive = '';
my $lastinode = '';
my $lastsize = '';
my $firstname = '';
my $can = 0;
open(my $fh, '<:encoding(UTF-8)', $filename) or die "Could not open file '$filename' $!";
open(my $cmdfile, '>', "/tmp/link.$$.sh") or die "Could not open file '$cmdfile' $!";
print "Writing to /tmp/link.$$.sh\n";
while (my $row = <$fh>) {
	chomp $row;
	my ($five, $type, $inode, $size, $name) = split('\|', $row);
	if ( $size > $minsize ) {
		if ( -f $name ) {
			if ( $five ne $lastfive ) {
				#New file
				$lastfive = $five;
				$lastinode = $inode;
				$lastsize = $size;
				$firstname = $name;
				$can = 1;
			} else {
				if ( $inode ne $lastinode ) {
					if ( $can > 0 ) {
						print "Working on new file: " . $lastfive . "@" . $lastinode . "\t$firstname\n";
						$can = 0;
					}
					if ( $lastsize == $size ) {
						print "\t" . $five . "@" . $inode . "\t$name\n";
						print $cmdfile "ls -lani \"$firstname\" \"$name\"\ncp -lfv \"$firstname\" \"$name\"\nls -lani \"$firstname\" \"$name\"\necho\n";
					} else {
						print "\tSanity check failure on size for $name ($inode) and $firstname ($lastinode) $lastsize != $size \n";
					}
				}
			}
			#print "$row\n\tMD5Sum: $five\n\tFile Type: $type\n\tInode: $inode\n\tSize: $size\n\tName: $name\n";
		} else{
			#print "\tFile dissapeared.\t$name\n"
		}
	}
}
close $cmdfile;
