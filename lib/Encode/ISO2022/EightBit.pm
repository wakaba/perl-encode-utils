=head1 NAME

Encode::ISO2022::Eight --- Encode and decode of 8-bit ISO/IEC 2022
based encodings (most of them are also known as EUCs)

=head1 ENCODINGS

=over 4

=cut

require 5.7.3;
use strict;
package Encode::ISO2022::EightBit;
use vars qw($VERSION);
$VERSION=do{my @r=(q$Revision: 1.1 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
use base qw(Encode::Encoding);
require Encode::ISO2022;

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str = &Encode::ISO2022::internal_to_iso2022 ($str, $obj->__2022_encode);
  return $str;
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  return &Encode::ISO2022::iso2022_to_internal ($str, $obj->__2022_decode);
}

## prototype for EUCs

sub __2022__common ($) {
  my $C = Encode::ISO2022->new_object;
  $C->{bit} = 8;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{"\x40"} = 0;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{Ginvoke_by_single_shift} = [0,0,1,1];
  $C->{option}->{C1invoke_to_right} = 1;
  $C->{option}->{reset}->{Gdesignation} = 0;
  $C->{option}->{reset}->{Ginvoke} = 0;
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C;
}
sub __2022_decode ($) {
  my $C = shift->__2022__common;
  $C;
}

package Encode::ISO2022::EightBit::EUCJapanOld;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/ujis x-ujis   deckanji/);

=item ujis

EUC (ISO/IEC 2022 based 8-bit encoding) for Japanese,
old version (pre-1990).  (Alias: x-ujis)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{B};	## JIS X 0208-1983
  $C->{G2} = $Encode::ISO2022::CHARSET{G94}->{I};	## JIS X 0201 Katakana
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{' @'};	## Gaiji (undefined)
  $C;
}

package Encode::ISO2022::EightBit::EUCJapan;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-japan euc-japan-1990 euc-jp eucjp euc_jp x-euc-jp
  Extended_UNIX_Code_Packed_Format_for_Japanese csEUCPkdFmtJapanese
  japanese-iso-8bit cp51932 japanese_euc
      ajec eucjp-open  ibm-eucjp cp33722 33722  sdeckanji/);

=item euc-japan

EUC (ISO/IEC 2022 based 8-bit encoding) for Japanese.
(Alias: euc-japan-1990 (emacsen), euc-jp (IANA),
eucjp (locale), euc_jp, x-euc-jp, 
extended_unix_code_packed_format_for_japanese (IANA),
cseucpkdfmtjapanese (IANA), japanese-iso-8bit (emacsen),
cp51932 (M$), japanese_euc)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{'B@'};	## JIS X 0208-1990
  $C->{G2} = $Encode::ISO2022::CHARSET{G94}->{I};	## JIS X 0201 Katakana
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{D};	## JIS X 0212-1990
  $C;
}

package Encode::ISO2022::EightBit::EUCJISX0213;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-jisx0213 x-euc-jisx0213
      x-euc-jisx0213-packed  deckanji2000/);

=item euc-jisx0213

EUC (ISO/IEC 2022 based 8-bit encoding) for Japanese
with JIS X 0213:2000, defined by JIS X 0213:2000.
(Alias: x-euc-jisx0213)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{O};	## JIS X 0213:2000 plane 1
  $C->{G2} = $Encode::ISO2022::CHARSET{G94}->{I};	## JIS X 0201 Katakana
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{P};	## JIS X 0213:2000 plane 2
  $C;
}

package Encode::ISO2022::EightBit::EUCJISX0213Plane1;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-jisx0213-plane1/);

=item euc-jisx0213-plane1

EUC (ISO/IEC 2022 based 8-bit encoding) for Japanese
with JIS X 0213:2000 plane 1, defined by JIS X 0213:2000

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{"\x7E"};	## empty
  $C;
}

package Encode::ISO2022::EightBit::EUCCHINA;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-china euc-cn cn-gb cn-gb-2312 chinese-iso-8bit
 gb2312 csgb2312 x-euc-cn cp51936   ibm-euccn CP1383 1383/);

=item euc-china

EUC (ISO/IEC 2022 based 8-bit encoding) for Chinese.
(Alias: euc-cn (emacsen), cn-gb (RFC 1922), cn-gb-2312 (RFC 1922),
chinese-iso-8bit (emacsen), gb2312 (IANA), csgb2312 (IANA),
x-euc-cn, CP51936 (M$))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{A};	## GB 2312
  $C;
}

package Encode::ISO2022::EightBit::EUCCHINA165;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/cn-gb-isoir165/);

=item euc-china

EUC (ISO/IEC 2022 based 8-bit encoding) for Chinese
with ISO-IR 165. (Alias: cn-gb-isoir165 (RFC 1922))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{"\x45"};	## ISO-IR 165
  $C;
}

package Encode::ISO2022::EightBit::EUCKorea;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-korea euc-kr cp970 cp51949 ibm-euckr x-euc-kr
 cseuckr korean-iso-8bit/);

=item euc-korea

EUC (ISO/IEC 2022 based 8-bit encoding) for Korean
(Alias: euc-kr (IANA), cp970, cp51949 (M$), ibm-euckr,
x-euc-kr, cseuckr (IANA), korean-iso-8bit (emacsen))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{C};	## KS X 1001
  $C;
}

package Encode::ISO2022::EightBit::EUCTaiwan;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-taiwan euc-tw x-euc-tw cns11643  ibm-euctw cp964/);

=item euc-taiwan

EUC (ISO/IEC 2022 based 8-bit encoding) for Chinese
with CNS 11643.  (Alias: euc-tw, x-euc-tw, cns11643)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{G};	## plane 1
  $C->{G2} = $Encode::ISO2022::CHARSET{G94n}->{H};	## plane 2
  #$C->{G3} = 	## BUG: does not support plane 3-16 yet
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{' `'};	# 3byte DRCS (temporary)
  $C;
}

package Encode::ISO2022::EightBit::EUCKPS9566;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-kps9566/);

=item euc-kps9566

EUC (ISO/IEC 2022 based 8-bit encoding) for Korean
with KPS 9566-97

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{N};	## KPS 9566-97
  $C;
}

package Encode::ISO2022::EightBit::SS2;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/iso-2022-8bit-ss2/);

=item iso-2022-8bit-ss2

ISO/IEC 2022 based 8-bit encoding using SS2 for 96-charset

=cut

sub __2022__common ($) {
  my $C = Encode::ISO2022->new_object;
  $C->{option}->{designate_to}->{G96}->{default} = 2;
  $C->{option}->{designate_to}->{G96n}->{default} = 2;
  $C->{option}->{G94n_designate_long} = 1;
  $C->{option}->{Ginvoke_by_single_shift}->[2] = 1;
  $C->{option}->{Ginvoke_to_left}->[2] = 0;
  $C->{option}->{C1invoke_to_right} = 1;
  $C;
}

package Encode::ISO2022::EightBit::CompoundText;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/compound-text ctext x-ctext/);

=item compound-text

ISO/IEC 2022 based 8-bit encoding used in inter-client
communication of X Window System (Alias: ctext (emacsen), x-ctext (emacsen))

=cut

sub __2022__common ($) {
  my $C = Encode::ISO2022->new_object;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{I} = 1;
  $C->{option}->{designate_to}->{G96}->{default} = 1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  for my $t (qw/G94 G96 G94n/) {
    for (0x30..0x3F) {
      my $F = chr $_;
      $C->{option}->{designate_to}->{$t}->{$F} = -1;
      $C->{option}->{designate_to}->{$t}->{'!'.$F} = -1;
      $C->{option}->{designate_to}->{$t}->{'"'.$F} = -1;
      $C->{option}->{designate_to}->{$t}->{'#'.$F} = -1;
      $C->{option}->{designate_to}->{$t}->{' '.$F} = -1;
    }
    for (0x40..0x7E) {
      $C->{option}->{designate_to}->{$t}->{' '.chr $_} = -1;
    }
  }
  $C->{option}->{G94n_designate_long} = 1;
  $C->{option}->{Ginvoke_to_left}->[1] = 0;
  $C->{option}->{C1invoke_to_right} = 1;
  $C->{option}->{reset}->{Ginvoke} = 0;
  $C;
}


1;
__END__

=back

=head1 LICENSE

Copyright 2002 wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/09/16 02:17:48 $
### SevenBit.pm ends here