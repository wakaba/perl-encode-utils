=head1 NAME

Encode::Unicode::UTF9 --- Encode/decode of UTF-9

=head1 ENCODINGS

=over 4

=item utf-9

UTF-9, defined in draft-abela-utf9-00.  (Alias: utf9)

=back

=cut

require v5.7.3;
package Encode::Unicode::UTF9;
use strict;
use vars qw($VERSION);
$VERSION=do{my @r=(q$Revision: 1.1 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/utf-9 utf9/);

my %_4to9;
sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  my $r = '';
  for (split //, $str) {
    unless ($_4to9{$_}) {
      my $U = ord $_;
      if ($U <= 0x7F) {
        $_4to9{$_} = $_;
      } else {
        $_4to9{$_} = _ucs4_to_utf9 ($U);
      }
    }
    $r .= $_4to9{$_};
  }
  $_[1] = '' if $chk;
  return $r;
}

my %_9to4;
sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $str =~ s{
     ([\x80-\x8F][\x80-\xFF])
    |([\x90-\x93][\x80-\xFF][\x80-\xFF])
    |([\x94-\x97][\x80-\xFF][\x80-\xFF][\x80-\xFF])
    |([\x98-\x9F][\x80-\xFF][\x80-\xFF][\x80-\xFF][\x80-\xFF])
    |([\x80-\xFF])
  }{
    my ($o2,$o3,$o4,$o5,$o1) = ($1,$2,$3,$4,$5);
    unless ($_9to4{$o2.$o3.$o4.$o5.$o1}) {
      if ($o1) {
        $_9to4{$o1} = $o1;
      } elsif ($o2) {
        my @o = split //, $o2;
        $_9to4{$o2} =
          chr (((ord ($o[0]) & 0x7F) << 7) + (ord ($o[1]) & 0x7F));
      } elsif ($o3) {
        my @o = split //, $o3;
        $_9to4{$o3} =
          chr (((ord ($o[0]) & 0x03) << 14) + ((ord ($o[1]) & 0x7F) << 7)
            + (ord ($o[2]) & 0x7F));
      } elsif ($o4) {
        my @o = split //, $o4;
        $_9to4{$o4} =
          chr (((ord ($o[0]) & 0x03) << 21) + ((ord ($o[1]) & 0x7F) << 14)
          + ((ord ($o[2]) & 0x7F) << 7) + (ord ($o[3]) & 0x7F));
      } else {
        my @o = split //, $o5;
        $_9to4{$o5} =
          chr (((ord ($o[0]) & 0x07) << 28) + ((ord ($o[1]) & 0x7F) << 21)
          + ((ord ($o[2]) & 0x7F) << 14) + ((ord ($o[3]) & 0x7F) << 7)
          + (ord ($o[4]) & 0x7F));
      }
    }
    $_9to4{$o2.$o3.$o4.$o5.$o1};
  }goex;
  $_[1] = '' if $chk;
  return $str;
}

sub _ucs4_to_utf9 ($) {
  my $U = shift;
  if ($U <= 0x007F || (0x00A0 <= $U && $U <= 0x00FF)) {
    return pack 'C', $U;
  } elsif ($U <= 0x07FF) {
    return pack 'C2', (0x80 | ($U >> 7)), (0x80 | ($U & 0x7F));
  } elsif ($U <= 0xFFFF) {
    return pack 'C3', (0x90 | ($U >> 14)), (0x80 | (($U >> 7) & 0x7F)),
                      (0x80 | ($U & 0x7F));
  } elsif ($U <= 0x7FFFFF) {
    return pack 'C4', (0x94 | ($U >> 21)), (0x80 | (($U >> 14) & 0x7F)),
                      (0x80 | (($U >> 7) & 0x7F)), (0x80 | ($U & 0x7F));
  } else {#if ($U <= 0x7FFFFFFF) {
    return pack 'C5', (0x98 | (($U >> 28) & 0x07)),
                      (0x80 | (($U >> 21) & 0x7F)), (0x80 | (($U >> 14) & 0x7F)),
                      (0x80 | (($U >> 7) & 0x7F)), (0x80 | ($U & 0x7F));
  }
}

1;

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
### UTF9.pm ends here
