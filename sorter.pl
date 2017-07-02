#!C:\Strawberry\perl\bin 

use strict;
use File::Copy;

#Declare variables for the destination directory and file extensions
my $SORTING_dir;
my $download_dir;
my @extension = ('jpg', 'png', 'gif', 'webm'); 

if ($^O == "linux") {
	$download_dir = '/home/myacer/Downloads';
	$SORTING_dir = "$download_dir\/SORTING";
} else {
	print "do nothing\n";
}

#Check directory exists - if not, create
if (-e $SORTING_dir && -x $SORTING_dir && -d $SORTING_dir) {
	print "Directory is there\n";
} else {
	mkdir "$SORTING_dir";
	print "Directory $SORTING_dir was created!\n";
}

#Open directories
opendir (S_DIR, $download_dir) or die $!;
opendir (D_DIR, $SORTING_dir) or die $!;

if ($^O == "linux") {
	#Read files from linux-directory
	while(my $fname = readdir S_DIR) {
    		my $path_to_file = "$download_dir\/$fname";
		#Parse files by extension
		for (my $i = 0; $i <= $#extension; $i++) {
			if ($fname =~ /$\.$extension[$i]/) {
				#If directory is directory && available && exist
				if (-e "$SORTING_dir\/$extension[$i]" && -x "$SORTING_dir\/$extension[$i]" && -d "$SORTING_dir\/$extension[$i]") {
					copy("$download_dir\/$fname", "$SORTING_dir\/$extension[$i]");
					if (-e "$SORTING_dir\/$extension[$i]\/$fname") {
						unlink ("$download_dir\/$fname");
					} else {
						print "Can't copy $fname\n $!\n";
					}
					print "Move $fname to $extension[$i]-folder\n";
				} else {
					mkdir "$SORTING_dir\/$extension[$i]";
					print "Directory $SORTING_dir\/$extension[$i] was created!\n";
				}
			}
		}
	}
} else {
	print "do_nothing\n";
}

#Close all folders
closedir D_DIR;
closedir S_DIR;
