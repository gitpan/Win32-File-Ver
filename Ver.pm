package Win32::File::Ver;

use strict;
use warnings;

require Exporter;
require XSLoader;

our @ISA = qw(Exporter);

our @EXPORT = qw( GetFileVersion );
our @EXPORT_OK = qw(  );

our $VERSION = '0.04';
XSLoader::load('Win32::File::Ver', $VERSION);

1;

__END__

=head1 NAME

Win32::File::Ver - Read program version information on Win32

=head1 SYNOPSIS

  use Win32::File::Ver;
  my $foo = GetFileVersion ( "C:\\path\\to\\file.dll" );
  if ( $foo ) {
	print $foo->{FileVersion};
	...
  }

=head1 ABSTRACT

Name changed to Win32::File::VersionInfo. Please use that instead!

Win32::File::Ver - Perl extension for reading the version information resource 
from files in the Microsoft Portable Executable (PE) format ( including
programs, DLLs, fonts, drivers, etc. ).  

=head1 DESCRIPTION

This module only has one function and it exports it by default. 

GetFileVersion takes a path as it's only argument. If for any reason that path 
cannot be read or the file does not contain a version information resource,
then GetFileVersion will return undef. Otherwise it will return a reference to
a hash containing the following:

=over

=item FileVersion

Contains a 4-part dot-separated version string (i.e. 4.0.4331.6).
In Windows Explorer, this appears at the top of the Version tab of the
Properties dialog.

=item ProductVersion

Contains a 4-part dot-separated version string (i.e. 4.0.4331.6).

=item Flags

A hash with an element set to true for each flag that is set. Flags that
are not set have no corresponding element (and so should evaluate to false).
Possible flags are:

=over

=item Debug

=item Prerelease

=item Patched

=item InfoInferred

=item PrivateBuild

=item SpecialBuild

=back

=item OS

A two part string separated by a slash (e.g. "NT/Win32"). The first part
can be one of:

=over

=item DOS

=item OS/2 16

=item OS/2 32

=item NT

=item WINCE

=item Unknown

=back

Note: the WINCE value is not defined in older version of winver.h. If you
compiled the XS against an older header, then what should be WINCE may
instead show up as Unknown. Unknown is a catchall category for anything not
defined in winver.h. For best results use the winver.h from the newest 
Platform SDK. 

The second part can be one of:

=over

=item Win16

=item PM16

=item PM32

=item Win32

=item Unknown

=back

PM is the OS/2 Presentation Manager. Unknown is a catchall category for 
anything not defined in winver.h.

=item Type

Indicates the type of file that contains the Version Information resource.
May be one of:

=over

=item Application

=item DLL

=item One of the following driver types:

=over

=item Printer Driver

=item Keyboard Driver

=item Language Driver

=item Display Driver

=item Mouse Driver

=item Network Driver

=item System Driver

=item Installable Driver

=item Sound Driver

=item Communications Driver

=item Input Method Driver

=item Versioned Printer Driver

=item Unknown Driver

=back

=item One of the following font types:

=over

=item Raster Font

=item Vector Font

=item TrueType Font

=item Unknown Font

=back

=item Virtual Device Driver

=item Static Library

=item Unknown

=back

Note that "Versioned Printer Driver" is not defined in older versions of
winver.h. See the note for WINCE above. The Unknowns are catchall categories 
for anything not defined in winver.h.

=item Date

A 64-bit hex string. I've never seen this set to anything but 0. It's not well
documented in the SDK.

=item Raw

This contains all of the above as raw hex strings. It's here if you want to
do something unusual, and for debugging purposes. See the code and the Platform
SDK documentation for more info.

=item Lang

This contains the language-dependant variable part. It is a hash with an entry
for each language-encoding pair in the Version Information resource. Each
language entry is also a hash that may contain any or all of the following as
strings (presumably UTF-8, but the SDK is not specific on this point):

=over

=item Comments

=item CompanyName

=item FileDescription

=item FileVersion

=item InternalName

=item Copyright

=item Trademarks

=item OriginalFilename

=item ProductName

=item ProductVersion

=item PrivateBuild

=item SpecialBuild

=back

These are the bulk of what appears in the Version tab in Windows Explorer.

Note that the values of FileVersion and ProductVersion here are strings, where
above they were stringified representations of 64-bit unsigned integers.

Usually only one language will appear, and usually that will be 
S<"English (United States)">.

=back

Realistically, almost nothing ever uses this information, and the only thing that
writes it is the linker that created the PE file in the first place. The only
reason you'd want this information is if you're terminaly curious or you're writing
an installer. Guess which I was?

=head1 SEE ALSO

Look up "GetFileVersionInfo" in the Microsoft Platform SDK, and browse from there.

=head1 AUTHOR

Alexey Toptygin E<lt>alexeyt@cpan.orgE<gt> L<http://alexeyt.freeshell.org/>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Alexey Toptygin

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
