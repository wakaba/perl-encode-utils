require 5.7.3;
package Encode::Unicode::UTF1;
use strict;
use vars qw($VERSION);
$VERSION=do{my @r=(q$Revision: 1.5 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/ISO-10646-UTF-1 utf-1 utf1 csISO10646UTF1 iso-ir-178/);

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  my @str = split //, $str;
  $str = '';
  for (@str) {
    $str .= join '', map {chr} _ucs4toutf1 (ord $_);
  }
  $_[1] = '' if $chk;
  return $str;
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $str =~ s{([\xA0-\xF5].|[\xF6-\xFB]..|[\xFC-\xFF]....)}{
    chr (_utf1toucs4 (unpack 'C*', $1))
  }gex;
  $_[1] = '' if $chk;
  return $str;
}

 sub _ucs4toutf1 ($) {
   my $U = shift;
   return ($U) if $U <= 0x9F;
   return (0xA0, $U) if $U <= 0xFF;
   return (int (0xA1 + ( $U - 0x100 ) / 0xBE),
           T(     ( $U - 0x100 ) % 0xBE)) if $U <= 0x4015;
   return (int (0xF6 + ( $U - 0x4016 ) / ( 0xBE**2 )),
           T(     ( $U - 0x4016 ) / 0xBE % 0xBE),
           T(     ( $U - 0x4016 ) % 0xBE      )) if $U <= 0x38E2D;
   return (int (0xFC + ( $U - 0x38E2E ) / ( 0xBE**4 )),
           T(     ( $U - 0x38E2E ) / ( 0xBE**3 ) % 0xBE),
           T(     ( $U - 0x38E2E ) / ( 0xBE**2 ) % 0xBE),
           T(     ( $U - 0x38E2E ) /   0xBE      % 0xBE),
           T(     ( $U - 0x38E2E ) %   0xBE      ));
 }
 
 sub _utf1toucs4 (@) {
   my ($x, $y, $z, $v, $w) = @_;
   return $x if @_ == 1 && $x <= 0x9F;
   return $y if $x == 0xA0;
   return ($x - 0xA1) * 0xBE + U($y) + 0x100
     if 0xA1 <= $x && $x <= 0xF5;
   return ($x - 0xF6) * ( 0xBE**2 ) + U($y) * 0xBE + U($z) + 0x4016
     if 0xF6 <= $x && $x <= 0xFB;
   return ($x - 0xFC) * ( 0xBE**4 ) + U($y) * ( 0xBE**3 )
              + U($z) * ( 0xBE**2 ) + U($v) * 0xBE
              + U($w) + 0x38E2E;
 }


 sub T ($) {
   my $z = int (shift);
   return $z + 0x21 if $z <= 0x5D;
   return $z + 0x42 if $z <= 0xBD;
   return $z - 0xBE if $z <= 0xDE;
   return $z - 0x60;
 }


 sub U ($) {
   my $z = shift;
   return $z + 0xBE if $z <= 0x20;
   return $z - 0x21 if $z <= 0x7E;
   return $z + 0x60 if $z <= 0x9F;
   return $z - 0x42;
 }

1;
__END__

=head1 NAME

Encode::Unicode::UTF1 --- Encode/decode of UTF-1

=head1 EXAMPLE

  use Encode;
  my $s = "some string in utf-8 (to be converted to utf-\x{4E00})";
  print encode ('utf-1', $s);
  
  my $b = "\xE0\xC2\xE0\xC4\xE0\xC6\xE0\xC8\xE0\xCA";
  print decode ('utf-1', $b);

=head1 LICENSE

Copyright 2002 Wakaba E<lt>w@suika.fam.cxE<gt>.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; see the file COPYING.  If not, write to
the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
Boston, MA 02111-1307, USA.

=cut

# $Date: 2002/09/23 08:28:39 $
### UTF1.pm ends here
