=head1 NAME

Encode::Unicode::UTF8 --- Encode/decode of UTF-8 related encodings

=head1 ENCODINGS

=over 4

=cut

require v5.7.3;
package Encode::Unicode::UTF8;
use strict;
use vars qw($VERSION);
$VERSION=do{my @r=(q$Revision: 1.1 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};

package Encode::Unicode::UTF8::CESU8;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/CESU-8 cesu8 csCESU-8/);

=item CESU-8

Compatibility Encoding Scheme for UTF-16: 8-Bit (CESU-8),
defined in UTR #26.  (Alias: csCESU-8 (IANA), cesu8)

=cut

my %_U2C;
sub encode ($$;$) {
  use integer;
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str =~ s{([\x{010000}-\x{10FFFF}])}{
    my $u = $1;
    unless ($_U2C{$u}) {
      $_U2C{$u} = chr ((ord ($u) - 0x10000) / 0x400 + 0xD800).
                  chr ((ord ($u) - 0x10000) % 0x400 + 0xDC00);
    }
    $_U2C{$u};
  }ge;
  Encode::_utf8_off ($str);
  $str;
}

my %_C2U;
sub decode ($$;$) {
  no warnings;
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  Encode::_utf8_on ($str);
  $str =~ s{([\x{D800}-\x{DBFF}])([\x{DC00}-\x{DFFF}])}{
    my ($u1,$u2) = ($1,$2);
    unless ($_C2U{$u1.$u2}) {
      $_C2U{$u1.$u2} = chr (0x10000+(ord($u1)-0xD800)*0x400+(ord($u2)-0xDC00));
    }
    $_C2U{$u1.$u2};
  }ge;
  return $str;
}

package Encode::Unicode::UTF8::UTF8Mod;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/utf-8-mod utf8-mod/);

=item utf-8-mod

Modified UTF-8 for UTF-EBCDIC, defined in UTR #16.
(Alias: utf8-mod)

=cut

my %_4to8m;
sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  my $r = '';
  for (split //, $str) {
    unless ($_4to8m{$_}) {
      my $U = ord $_;
      if ($U <= 0x9F) {
        $_4to8m{$_} = $_;
      } else {
        $_4to8m{$_} = _ucs4_to_utf8m ($U);
      }
    }
    $r .= $_4to8m{$_};
  }
  $_[1] = '' if $chk;
  return $r;
}

my %_8mto4;
sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $str =~ s{
     ([\xC0-\xDF][\xA0-\xFF])
    |([\xE0-\xEF][\xA0-\xFF][\xA0-\xFF])
    |([\xF0-\xF7][\xA0-\xFF][\xA0-\xFF][\xA0-\xFF])
    |([\xF8-\xFB][\xA0-\xFF][\xA0-\xFF][\xA0-\xFF][\xA0-\xFF])
    | ([\xFC\xFD][\xA0-\xFF][\xA0-\xFF][\xA0-\xFF][\xA0-\xFF][\xA0-\xFF])
    | ([\xFE\xFF][\xA0-\xFF][\xA0-\xFF][\xA0-\xFF][\xA0-\xFF][\xA0-\xFF][\xA0-\xFF])
  }{
    my ($o2,$o3,$o4,$o5,$o6,$o7) = ($1,$2,$3,$4,$5,$6);
    unless ($_8mto4{$o2.$o3.$o4.$o5.$o6.$o7}) {
      if ($o2) {
        my @o = split //, $o2;
        $_8mto4{$o2} =
          chr (((ord ($o[0]) & 0x1F) << 5) + (ord ($o[1]) & 0x1F));
      } elsif ($o3) {
        my @o = split //, $o3;
        $_8mto4{$o3} =
          chr (((ord ($o[0]) & 0x03) << 10) + ((ord ($o[1]) & 0x1F) << 5)
            + (ord ($o[2]) & 0x1F));
      } elsif ($o4) {
        my @o = split //, $o4;
        $_8mto4{$o4} =
          chr (((ord ($o[0]) & 0x07) << 15) + ((ord ($o[1]) & 0x1F) << 10)
          + ((ord ($o[2]) & 0x1F) << 5) + (ord ($o[3]) & 0x1F));
      } elsif ($o5) {
        my @o = split //, $o5;
        $_8mto4{$o5} =
          chr (((ord ($o[0]) & 0x03) << 20) + ((ord ($o[1]) & 0x1F) << 15)
          + ((ord ($o[2]) & 0x1F) << 10) + ((ord ($o[3]) & 0x1F) << 5)
          + (ord ($o[4]) & 0x1F));
      } elsif ($o6) {
        my @o = split //, $o6;
        $_8mto4{$o6} =
          chr (((ord ($o[0]) & 0x01) << 25) + ((ord ($o[1]) & 0x1F) << 20)
          + ((ord ($o[2]) & 0x1F) << 15) + ((ord ($o[3]) & 0x1F) << 10)
          + ((ord ($o[4]) & 0x1F) << 5) + (ord ($o[5]) & 0x1F));
      } else {
        my @o = split //, $o7;
        $_8mto4{$o7} =
          chr (((ord ($o[0]) & 0x01) << 30) + ((ord ($o[1]) & 0x1F) << 25)
          + ((ord ($o[2]) & 0x1F) << 20) + ((ord ($o[3]) & 0x1F) << 15)
          + ((ord ($o[4]) & 0x1F) << 10) + ((ord ($o[5]) & 0x1F) << 5)
          + (ord ($o[6]) & 0x1F));
      }
    }
    $_8mto4{$o2.$o3.$o4.$o5.$o6.$o7};
  }goex;
  $_[1] = '' if $chk;
  return $str;
}

sub _ucs4_to_utf8m ($) {
  my $U = shift;
  if ($U <= 0x009F) {
    return pack 'C', $U;
  } elsif ($U <= 0x03FF) {
    return pack 'C2', (0xC0 | ($U >> 5)), (0xA0 | ($U & 0x1F));
  } elsif ($U <= 0x3FFF) {
    return pack 'C3', (0xE0 | ($U >> 10)), (0xA0 | (($U >> 5) & 0x1F)),
                      (0xA0 | ($U & 0x4F));
  } elsif ($U <= 0x0003FFFF) {
    return pack 'C4', (0xF0 | ($U >> 15)), (0xA0 | (($U >> 10) & 0x1F)),
                      (0xA0 | (($U >> 5) & 0x1F)), (0xA0 | ($U & 0x1F));
  } elsif ($U <= 0x003FFFFF) {
    return pack 'C5', (0xF8 | ($U >> 20)),
                      (0xA0 | (($U >> 15) & 0x1F)), (0xA0 | (($U >> 10) & 0x1F)),
                      (0xA0 | (($U >> 5) & 0x1F)), (0xA0 | ($U & 0x1F));
  } elsif ($U <= 0x03FFFFFF) {
    return pack 'C6', (0xFC | ($U >> 25)), (0xA0 | (($U >> 20) & 0x1F)),
                      (0xA0 | (($U >> 15) & 0x1F)), (0xA0 | (($U >> 10) & 0x1F)),
                      (0xA0 | (($U >> 5) & 0x1F)), (0xA0 | ($U & 0x1F));
  } else {#if ($U <= 0x7FFFFFFF) {
    return pack 'C7', (0xFE | (($U >> 30) & 0x01)), (0xA0 | (($U >> 25) & 0x1F)),
                      (0xA0 | (($U >> 20) & 0x1F)), (0xA0 | (($U >> 15) & 0x1F)),
                      (0xA0 | (($U >> 10) & 0x1F)), (0xA0 | (($U >> 5) & 0x1F)),
                      (0xA0 | ($U & 0x1F));
  }
}

package Encode::Unicode::UTF8::UTFEBCDIC;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/utf-ebcdic ef-utf utf-ebcdic-without-bom/);

=item utf-ebcdic

UTF-EBCDIC, EBCDIC-friendly Unicode (or UCS) Transformation Format,
defined in UTR #16, without BOM. (Alias: ef-utf, utf-ebcdic-without-bom)

=cut

my $_tbl_u8m = q(\x00-\xFF);
my $_tbl_ue = q(\x00-\x03\x37\x2D\x2E\x2F\x16\x05\x15\x0B-\x0F\x10-\x13\x3C\x3D\x32\x26\x18\x19\x3F\x27\x1C-\x1F\x40\x5A\x7F\x7B\x5B\x6C\x50\x7D\x4D\x5D\x5C\x4E\x6B\x60\x4B\x61\xF0-\xF9\x7A\x5E\x4C\x7E\x6E\x6F\x7C\xC1-\xC9\xD1-\xD9\xE2-\xE9\xAD\xE0\xBD\x5F\x6D\x79\x81-\x89\x91-\x99\xA2-\xA9\xC0\x4F\xD0\xA1\x07\x20-\x25\x06\x17\x28-\x2C\x09\x0A\x1B\x30\x31\x1A\x33-\x36\x08\x38-\x3B\x04\x14\x3E\xFF\x41-\x49\x4A\x51-\x59\x62-\x6A\x70-\x78\x80\x8A-\x90\x9A-\xA0\xAA-\xAC\xAE-\xBC\xBE\xBF\xCA-\xCF\xDA-\xDF\xE1\xEA-\xEF\xFA-\xFE);
sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $str = Encode::encode ('utf-8-mod', $str);
  eval qq{\$str =~ tr/$_tbl_u8m/$_tbl_ue/} or die $@;
  $_[1] = '' if $chk;
  return $str;
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  eval qq{\$str =~ tr/$_tbl_ue/$_tbl_u8m/} or die $@;
  $_[1] = '' if $chk;
  return Encode::decode ('utf-8-mod', $str);
}

package Encode::Unicode::UTF8::UTFEBCDICwBOM;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/utf-ebcdic-with-bom/);

=item utf-ebcdic-with-bom

UTF-EBCDIC, EBCDIC-friendly Unicode (or UCS) Transformation Format,
defined in UTR #16, with BOM

=cut

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $str = Encode::encode ('utf-8-mod', "\x{FEFF}".$str);
  eval qq{\$str =~ tr/$_tbl_u8m/$_tbl_ue/} or die $@;
  $_[1] = '' if $chk;
  $str;
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  eval qq{\$str =~ tr/$_tbl_ue/$_tbl_u8m/} or die $@;
  $_[1] = '' if $chk;
  my $str = Encode::decode ('utf-8-mod', $str);
  $str =~ s/^\x{FEFF}//;
  $str;
}

1;

=back

Note that UTF-8-Mod and UTF-EBCDIC are supported by perl
for EBCDIC platforms.  If we can use that code (written in C),
convertion of those encodings will become faster.

Note also that UTF-8 -> CESU-8 could be implemented as
utf8_off(decode_ucs2(encode_utf16(utf8))) and CESU-8 -> UTF-8
could be implemented as decode_utf16(encode_ucs2(cesu8)),
if Encode::Unicode did not check malformed UTF-8 sequences.
It might make convertion faster when XS is used.

=head1 SEE ALSO

"UTF-EBCDIC", Unicode Technical Report #16,
<http://www.unicode.org/unicode/reports/tr16/>.

"Compatibility Encoding Scheme for UTF-16: 8-Bit (CESU-8)",
Unicode Technical Report #26, <http://www.unicode.org/unicode/reports/tr26/>.

=head1 LICENSE

Copyright 2002 Nanashi-san

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

## $Date: 2002/09/23 08:28:39 $
### UTF8.pm ends here
