require 5.7.3;
package Encode::ISO2022::CP932;
use strict;
use vars qw(%DEFAULT $VERSION);
$VERSION=do{my @r=(q$Revision: 1.2 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/x-iso2022jp-cp932/);

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  ## TODO: implement this!
  $str = Encode::encode ('iso-2022-jp', $str);	## temporary
  return $str;
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  _jis7_to_sjis (\$str);
  return Encode::decode ('cp932', $str);
}

my %_L2S;
sub _jis7_to_sjis (\$) {
  my $s = shift;
  $$s =~ s(
  	(\x1B\x24\x28?[\x40\x42]|\x1B\x28[BHIJ])
  	([^\x00-\x20]*)
  ){
    my ($esc, $str) = ($1, $2);
    if ($esc =~ /\x1B\x28I/o) {
      $str =~ tr/\x21-\x7E/\xA1-\xDF???????????????????????????????/;
    } elsif ($esc !~ /\x1B\x28/o) {
      $str =~ s{ ([\x21-\xFF][\x21-\x7E]) }{
        my $s = $1;
        unless ($_L2S{$s}){
          my ($c1, $c2) = unpack 'CC', $s;
          $c2 += ($c1 & 1) ? ($c2 < 0x60 ? 0x1F : 0x20) : 0x7E;
          $c1 = (($c1 - 1) >> 1) + ($c1 < 0x5F ? 0x71 : 0xB1);
          $_L2S{$s} = pack 'CC', $c1, $c2;
        }
        $_L2S{$s};
      }goex;
    }
    $str;
  }goex;
  $$s =~ s{ \x0E([\xA1-\xDF]+)\x0F }{
    $1;
  }goex;
}

1;
__END__

=head1 NAME

Encode::ISO2022::CP932 --- Encode module for ISO/IEC 2022 like
encoding of Microsoft CP932 (Shift JIS)

=head1 DESCRIPTION

Windows Code Page 932, Microsoft version of shift JIS,
is widely used in Japanese PC community.  It is the combination
of JIS character set with non-standard extended characters (CCS)
and "shift JIS" encoding scheme (CES).

Non-PC communities such as un*x users' or Internet mail/news'
use standard JIS character set for CCS and EUC or 7bit 
ISO/IEC 2022 for CES.

This situation makes such stupid converters that
output the charset consist of non-standard CCS and EUC
or 7bit ISO/IEC 2022 CES.

This module supports two such charsets.  One is
C<x-iso2022jp-cp932>, 

=head1 LICENSE

Copyright 2002 wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=head1 CHANGE

See F<ChangeLog>.
$Date: 2002/09/15 04:15:11 $

=cut
