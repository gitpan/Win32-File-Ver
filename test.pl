use strict;
use Data::Dumper;
use Win32::File::Ver;

my $windir = "C:\\WINDOWS";

die "Your windows system folder does not seem to be $windir\n" .
	"please edit test.pl accordingly.\n" unless -d $windir;

my @foo = (
	"${windir}\\system32\\notepad.exe",
	"${windir}\\system32\\kernel32.dll",
	"${windir}\\system32\\msxbde40.dll",
	"${windir}\\system\\KEYBOARD.DRV",
	"${windir}\\system32\\winspool.drv",
	"${windir}\\system32\\vga.drv",
	"${windir}\\system32\\mouse.drv",
	"${windir}\\system32\\lanman.drv",
	"${windir}\\system32\\sound.drv",
	"${windir}\\system32\\comm.drv",
	"${windir}\\Fonts\\COURE.FON",
	);

foreach ( @foo ) {
	print "\n$_\n";
	my $bar = GetFileVersion ( $_ );
	print Dumper ( $bar ), "\n"
}