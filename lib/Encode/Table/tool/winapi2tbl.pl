#!/usr/bin/perl

=head1 NAME

winapi2tbl --- Mapping table generator (from Win32 API)

=head1 USAGE

 $ perl winapi2tbl.pl 932 > winapi-cp932.tbl

=cut

use strict;
require Win32::API;

my $CodePage = shift || 932;
my %S_range = (
	932	=> [0x40..0x7E,0x80..0xFC],
	936	=> [0x40..0x7E,0x80..0xFE],
	949	=> [0x41..0x5A,0x61..0x7A,0x81..0xFE],
	950	=> [0x40..0x7E,0xA1..0xFE],
	1361	=> [0x31..0xFE],
	20000	=> [0x21..0x7E,0xA1..0xFE],
	20932	=> [0xA1..0xFE],
	20936	=> [0xA1..0xFE],
	20949	=> [0xA1..0xFE],
);

{
my @name = split /\n/, require 'unicore/Name.pl';
my %name;
for (@name) {
if (/^(....)		([^\t]+)/) {
  $name{hex $1} = $2;
}
}
sub NAME ($) {
  $_[0] < 0x0020 ? '<control>' :
  $_[0] < 0x007F ? $name{$_[0]} :
  $_[0] < 0x00A0 ? '<control>' :
  $name{$_[0]} ? $name{$_[0]} :
  $_[0] < 0x00A0 ? '<control>' :
  $_[0] < 0x3400 ? '' :
  $_[0] < 0xA000 ? '<cjk>' :
  $_[0] < 0xE000 ? '<hangul>' :
  $_[0] < 0xF900 ? '<private>' :
  '';
}
}

my @hdr;
print STDERR "Checking system version...\n";
if (eval q{require Message::Field::UA}) {
  my $ua = new Message::Field::UA;
  $ua->add_our_name;
  $ua->replace_system_version ('ie', -prepend => 0);
  push @hdr, "#; Environment: $ua";
  print STDERR $hdr[$#hdr],"\n";
}

print STDERR "MultiByte -> WideChar...\n";
#int MultiByteToWideChar(
#  UINT CodePage,         // code page
#  DWORD dwFlags,         // mapping flag
#  LPCSTR lpMultiByteStr, // multibyte string (source)
#  int cchMultiByte,      // length of multibyte string
#  LPWSTR lpWideCharStr,  // wide string (result)
#  int cchWideChar        // length of wide string
#);
## <http://www.microsoft.com/japan/developer/library/jpwinpf/_win32_multibytetowidechar.htm>

my $M2W = new Win32::API (kernel32 => "MultiByteToWideChar", INPIPI => 'I');
my %M2U;
for my $F (0x00..0xFF) {	## one byte
  my $mb = pack 'C', $F;
  my $wc = "\x00" x 10;
  my $len = $M2W->Call ($CodePage, 0, $mb, length ($mb) => $wc, length ($wc));
  $wc = substr ($wc, 0, $len * 2);
  if (length ($wc) >= 2 && $wc ne "\x00\x00") {
    $wc =~ s/(.)(.)/$2$1/gs;
    $wc =~ s/(.)/sprintf '%02X', ord $1/ges;
    $M2U{ $F } = hex $wc;
  }
}
for my $F (0x80..0xFF) {	## two bytes
for my $S (@{$S_range{$CodePage} || [0x01..0xFF] }) {
  my $mb = pack 'CC', $F, $S;
  my $wc = "\x00" x 10;
  my $len = $M2W->Call ($CodePage, 0, $mb, length ($mb) => $wc, length ($wc));
  $wc = substr ($wc, 0, $len * 2);
  if (length ($wc) >= 2) {
    $wc =~ s/(.)(.)/$2$1/gs;
    $wc =~ s/(.)/sprintf '%02X', ord $1/ges;
    $M2U{ 0x100 * $F + $S } = hex ($wc) unless 0x10000 * $M2U{$F} + $M2U{$S} == hex ($wc);
  }
}}
$M2U{0x00} = 0x0000;

print STDERR "WideChar -> MultiByte...\n";
#int WideCharToMultiByte(
#  UINT CodePage,		// code page
#  DWORD dwFlags,		// mapping flag
#  LPCWSTR lpWideCharStr,	// wide string (source)
#  int cchWideChar,		// length of wide string
#  LPSTR lpMultiByteStr,	// multibyte string (result)
#  int cchMultiByte,		// length of multibyte
#  LPCSTR lpDefaultChar,	// substition char of unmappable one
#  LPBOOL lpUsedDefaultChar	// substition char is used?
#);
## <http://www.microsoft.com/japan/developer/library/jpwinpf/_win32_widechartomultibyte.htm>

my $W2M = new Win32::API (kernel32 => "WideCharToMultiByte", INPIPIPP => 'I');
my %U2M;
for my $R (0x00..0xFF) {
for my $C (0x00..0xFF) {
  my $wc = pack 'CC', $C, $R;	## UTF-16LE
  my $mb = "\x00" x 10;
  $W2M->Call ($CodePage, 0, $wc, length ($wc) / 2 => $mb, length ($mb), "\x00", 0);
  $mb =~ s/\x00.*$//;
  if (length $mb) {
    $mb =~ s/(.)/sprintf '%02X', ord $1/ges;
    $U2M{ 0x100 * $R + $C } = hex $mb;
  }
}}
$U2M{0x0000} = 0x00;

for my $R1 (0xD8..0xDB) { for my $C1 (0x00..0xFF) {
for my $R2 (0xDC..0xDF) { for my $C2 (0x00..0xFF) {
  my $wc = pack 'CC', $C1, $R1, $C2, $R2;	## UTF-16LE
  my $mb = "\x00" x 10;
  $W2M->Call ($CodePage, 0, $wc, length ($wc) / 2 => $mb, length ($mb), "\x00", 0);
  $mb =~ s/\x00.*$//;
  if (length $mb) {
    $mb =~ s/(.)/sprintf '%02X', ord $1/ges;
    $U2M{ 0x10000 + (0x100 * $R1 + $C1 - 0xD800) * 0x400
                  + (0x100 * $R2 + $C2 - 0xDC00) } = hex ($mb);
  }
}}}}

print STDERR "Creating table...\n";

my @t;
for my $U (keys %U2M) {
    if ($M2U{$U2M{$U}} == $U) {
      push @t, sprintf '0x%04X	U+%04X		# %s',
                       $U2M{$U}, $U, NAME ($U);
      delete $M2U{ $U2M{$U} };
    } else {
      push @t, sprintf '0x%04X	U+%04X	<-	# %s',
                       $U2M{$U}, $U, NAME ($U);
    }
}
for my $C (keys %M2U) {
  push @t, sprintf '0x%04X	U+%04X	->	# %s',
                       $C, $M2U{$C}, NAME ($M2U{$C});
}
for (@t) {
  s/^0x00(..)/0x$1/;
}

print "#; This file is auto-generated (at @{[ sprintf '%04d-%02d-%02dT%02d:%02d:%02dZ', (gmtime)[5]+1900, (gmtime)[4]+1, (gmtime)[3,2,1,0] ]}).\n";
print join "\n", @hdr, sort @t;
print "\n";

=head1 REQUIRES

L<Win32::API> (MUST), unicore/Name.pl (MUST; in perl 5.8.0),
L<Message::Field::UA> (SHOULD)

=head1 BUGS

0x00 or U+0000 can't be treated correctly so that
0x00 <-> U+0000 is hardcoded.  This may cause problem
if the code page does not have 0x00 <-> U+0000 mapping.

Mapping to 0x00 or U+0000 is also having problem.
For example, CP20127, Microsoft mapping of ASCII,
has an entry of 0x80 -> U+0000.  But this entry does
not occur in outputed table.

In other points, this script has a lot of "hardcoded"
code, so that making table of some unknown code page
can result incorrect mapping.

=head1 AUTHOR

Nanashi-san <nanashi@san.invalid>

=head1 LICENSE

Public Domain.

=cut

# $Date: 2002/12/12 07:47:19 $
