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
$VERSION=do{my @r=(q$Revision: 1.5 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
use base qw(Encode::Encoding);
require Encode::ISO2022;

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  if (!defined $obj->{_encode_mapping} || $obj->{_encode_mapping}) {
    require Encode::Table;
    $str = Encode::Table::convert ($str, $obj->__encode_map,
      -autoload => defined $obj->{_encode_mapping_autoload} ?
                   $obj->{_encode_mapping_autoload} : 1);
  }
  $str = &Encode::ISO2022::internal_to_iso2022 ($str, $obj->__2022_encode);
  $str;
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str = &Encode::ISO2022::iso2022_to_internal ($str, $obj->__2022_decode);
  if (!defined $obj->{_decode_mapping} || $obj->{_decode_mapping}) {
    require Encode::Table;
    $str = Encode::Table::convert ($str, $obj->__decode_map,
      -autoload => defined $obj->{_decode_mapping_autoload} ?
                   $obj->{_decode_mapping_autoload} : 1);
  }
  $str;
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
sub __encode_map ($) {
  [];
}
sub __decode_map ($) {
  [];
}

sub __clone ($) {
  my $self = shift;
  bless {%$self}, ref $self;
};

package Encode::ISO2022::EightBit::EUCJapanOldDefinition;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/ujis x-ujis euc-jp-1983 euc-japan-1983   deckanji/);

=item ujis

EUC (ISO/IEC 2022 based 8-bit encoding) for Japanese
with JIS X 0208 (JIS C 6226)-1983
(obsoleted definition of pre-1990 days).  (Alias: x-ujis,
euc-japan-1983, euc-jp-1983)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{B};	## JIS X 0208-1983
  $C->{G2} = $Encode::ISO2022::CHARSET{G94}->{I};	## JIS X 0201 Katakana
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{' @'};	## Gaiji (undefined)
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0201_katakana/];
}
sub __decode_map ($) {
  [qw/jisx0208_1983_to_ucs jisx0201_katakana_to_ucs/];
}

package Encode::ISO2022::EightBit::EUCJapan;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-japan euc-japan-1990 euc-japan-1997 euc-jp euc-jp-1990
  euc-jp-1997 euc-j eucjp euc_jp x-euc-jp
  x-eucjp eucjis euc-jis eucj Extended_UNIX_Code_Packed_Format_for_Japanese
  csEUCPkdFmtJapanese eujis
  japanese-iso-8bit cp51932 japanese_euc
      ajec eucjp-open  ibm-eucjp cp33722 33722  sdeckanji/);

=item euc-japan

EUC (ISO/IEC 2022 based 8-bit encoding) for Japanese
with JIS X 0208-1990.
(Alias: euc-japan-1990 (emacsen), euc-japan-1997, euc-jp (IANA), euc-jp-1990,
euc-jp-1997, eujis (locale),
euc-j, eucjp (locale), euc_jp, eucj, x-eucjp, x-euc-jp, eucjis, euc-jis,
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
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0208_1990 ucs_to_jisx0212_1990 ucs_to_jisx0201_katakana/];
}
sub __decode_map ($) {
  [qw/jisx0208_1990_to_ucs jisx0212_1990_to_ucs jisx0201_katakana_to_ucs/];
}

package Encode::ISO2022::EightBit::EUCJapan1978;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-japan-1978 euc-jp-1978/);

=item euc-japan-1978

EUC (ISO/IEC 2022 based 8-bit encoding) for Japanese
with JIS X 0208 (JIS C 6226)-1978.  (Alias: euc-jp-1978)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{'@'};	## JIS X 0208-1978
  $C->{G2} = $Encode::ISO2022::CHARSET{G94}->{I};	## JIS X 0201 Katakana
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{D};	## JIS X 0212-1990
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0208_1978 ucs_to_jisx0212_1990 ucs_to_jisx0201_katakana/];
}
sub __decode_map ($) {
  [qw/jisx0208_1978_to_ucs jisx0212_1990_to_ucs jisx0201_katakana_to_ucs/];
}

package Encode::ISO2022::EightBit::EUCJISX0213;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-jisx0213 x-euc-jisx0213 euc_jisx0213 eucjp0213
 euc-jp-3 euc-japan-2000 euc-jp-2000     x-euc-jisx0213-packed  deckanji2000/);

=item euc-jisx0213

EUC (ISO/IEC 2022 based 8-bit encoding) for Japanese
with JIS X 0213:2000, defined by JIS X 0213:2000.
(Alias: x-euc-jisx0213, euc_jisx0213, eucjp0213, euc-jp-3,
euc-japan-2000, euc-jp-2000)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{O};	## JIS X 0213:2000 plane 1
  $C->{G2} = $Encode::ISO2022::CHARSET{G94}->{I};	## JIS X 0201 Katakana
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{P};	## JIS X 0213:2000 plane 2
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2 ucs_to_jisx0201_katakana/];
}
sub __decode_map ($) {
  [qw/jisx0213_2000_1_to_ucs jisx0212_0213_to_ucs jisx0201_katakana_to_ucs/];
}

package Encode::ISO2022::EightBit::EUCJISX0213Plane1;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-jisx0213-plane1/);

=item euc-jisx0213-plane1

EUC (ISO/IEC 2022 based 8-bit encoding) for Japanese
with JIS X 0213:2000 plane 1, defined by JIS X 0213:2000

=cut

sub __2022__encode ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{"\x7E"};	## empty
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0213_2000_1 ucs_to_jisx0201_katakana/];
}
sub __decode_map ($) {
  [qw/jisx0213_2000_1_to_ucs jisx0212_0213_to_ucs jisx0201_katakana_to_ucs/];
}

package Encode::ISO2022::EightBit::EUCCHINA;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-china euc-cn euccn euc-gb
 cn-gb cn-gb-2312 chinese-iso-8bit ugb
 gb2312 csgb2312 x-euc-cn cp51936   ibm-euccn CP1383 1383/);

=item euc-china

EUC (ISO/IEC 2022 based 8-bit encoding) for Chinese.
(Alias: euc-cn (emacsen), euccn, euc-gb, cn-gb (RFC 1922), cn-gb-2312 (RFC 1922),
chinese-iso-8bit (emacsen), ugb (locale), gb2312 (IANA), csgb2312 (IANA),
x-euc-cn, CP51936 (M$))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{A};	## GB 2312
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_gb2312_1980/];
}
sub __decode_map ($) {
  [qw/gb2312_1980_to_ucs/];
}

package Encode::ISO2022::EightBit::EUCCHINA165;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/cn-gb-isoir165 iso-ir-165/);

=item cn-gb-isoir165

EUC (ISO/IEC 2022 based 8-bit encoding) for Chinese
with ISO-IR 165. (Alias: cn-gb-isoir165 (RFC 1922),
ISO-IR-165)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{"\x45"};	## ISO-IR 165
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_iso_ir_165/];
}
sub __decode_map ($) {
  [qw/iso_ir_165_to_ucs/];
}

package Encode::ISO2022::EightBit::EUCcwnn;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-cwnn cwnn-iso-8bit/);

=item euc-cwnn

EUC (ISO/IEC 2022 based 8-bit encoding) for Chinese
with GB 2312, used by cwnn input system (Alias: cwnn-iso-8bit).
See <http://www.tomo.gr.jp/users/wnn/9912ml/msg00088.html>.

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{A};	## GB 2312
  $C->{G2} = $Encode::ISO2022::CHARSET{G94}->{'0'};	# omron_udc_zh (sisheng)
  	## TODO: Implement by private set support
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_gb2312_1980 ucs_to_omron_udc_zh/];
}
sub __decode_map ($) {
  [qw/gb2312_1980_to_ucs omron_udc_zh_to_ucs/];
}

## cn-gb-12345, gb12345, euc-gb12345

package Encode::ISO2022::EightBit::EUCKorea;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-korea euc-kr euckr cp970 cp51949 ibm-euckr x-euc-kr
 cseuckr korean-iso-8bit/);

=item euc-korea

EUC (ISO/IEC 2022 based 8-bit encoding) for Korean
(Alias: euc-kr (IANA), euckr, cp970, cp51949 (M$), ibm-euckr,
x-euc-kr, cseuckr (IANA), korean-iso-8bit (emacsen))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{C};	## KS X 1001
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ksx1001_1992_katakana/];
}
sub __decode_map ($) {
  [qw/ksx1001_1992_to_ucs/];
}

package Encode::ISO2022::EightBit::EUCTaiwan;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-taiwan euc-tw euctw x-euc-tw cns11643 cseuctw
    ibm-euctw cp964/);

=item euc-taiwan

EUC (ISO/IEC 2022 based 8-bit encoding) for Chinese
with CNS 11643.  (Alias: euc-tw, euctw, x-euc-tw, cseuctw, cns11643)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{G};	## plane 1
  #$C->{G2} = 	## BUG: does not support plane 2-16 yet
  $C->{G2} = $Encode::ISO2022::CHARSET{G94n}->{' `'};	# 3byte DRCS (temporary)
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_cns11643_1 ucs_to_cns11643_2 ucs_to_cns11643_3 ucs_to_cns11643_4 ucs_to_cns11643_5 ucs_to_cns11643_6 ucs_to_cns11643_7 ucs_to_cns11643_8 ucs_to_cns11643_9 ucs_to_cns11643_10 ucs_to_cns11643_11 ucs_to_cns11643_12 ucs_to_cns11643_13 ucs_to_cns11643_14 ucs_to_cns11643_15 ucs_to_cns11643_16/];
}
sub __decode_map ($) {
  [qw/cns11643_1_to_ucs cns11643_2_to_ucs cns11643_3_to_ucs cns11643_4_to_ucs cns11643_5_to_ucs cns11643_6_to_ucs cns11643_7_to_ucs cns11643_8_to_ucs cns11643_9_to_ucs cns11643_10_to_ucs cns11643_11_to_ucs cns11643_12_to_ucs cns11643_13_to_ucs cns11643_14_to_ucs cns11643_15_to_ucs cns11643_16_to_ucs/];
}

package Encode::ISO2022::EightBit::EUCtwnn;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::EightBit';
__PACKAGE__->Define (qw/euc-twnn twnn-iso-8bit/);

=item euc-twnn

EUC (ISO/IEC 2022 based 8-bit encoding) for Chinese
with CNS 11643, used by twnn input system (Alias: twnn-iso-8bit)
See <http://www.tomo.gr.jp/users/wnn/9912ml/msg00088.html>.

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{G};	## plane 1
  $C->{G2} = $Encode::ISO2022::CHARSET{G94}->{'0'};	# omron_udc_zh (sisheng)
  	## TODO: Implement by private set support
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{H};	## plane 2
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_cns11643_1 ucs_to_cns11643_2 ucs_to_omron_udc_zh/];
}
sub __decode_map ($) {
  [qw/cns11643_1_to_ucs cns11643_2_to_ucs omron_udc_zh_to_ucs/];
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
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_kps9566_1997/];
}
sub __decode_map ($) {
  [qw/kps9566_1997_to_ucs/];
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
__PACKAGE__->Define (qw/compound-text compound_text 
 x-compound-text ctext x-ctext ct/);

=item compound-text

ISO/IEC 2022 based 8-bit encoding used in inter-client
communication of X Window System (Alias: ctext (emacsen), x-ctext (emacsen),
compound_text, x-compound-text, ct (loacle))

Strictly, x-ctext, extended compound text (X Compound Text
based encoding for unknown ISO/IEC 2022 based encoding) is a
different coding system from X Compound Text.  See
[mule-jp:7455] <mid:rsqsoa5s2hr.fsf@crane.jaist.ac.jp> and
[mule-jp:7457] <mid:rsq4smlky85.fsf@crane.jaist.ac.jp>.
Mule's ctext allows private final bytes and 96^n sets.

XFree86 extended compound text allows to use UTF-8
with ESC 02/05 04/06.  See
<http://cvsweb.xfree86.org/cvsweb/xc/doc/specs/CTEXT/ctext.tbl.ms>.

=cut

## TODO: separate mule ctext and xfree86 ctext

sub __2022__common ($) {
  my $C = Encode::ISO2022->new_object;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{I} = 1;	## JIS X 0201 Katakana
  $C->{option}->{designate_to}->{G96}->{default} = 1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  for my $t (qw/G94 G96 G94n/) {
    for (0x30..0x3F) {
      my $F = chr $_;
      #$C->{option}->{designate_to}->{$t}->{$F} = -1;
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
  $C->{option}->{use_revision} = 0;
  ## XFree86 extension
  $C->{option}->{designate_to}->{G94n}->{"\x42\x40"} = 0;	## JIS X 0208-1990
  $C->{option}->{designate_to}->{coding_system}->{"\x40"} = 1;	## ISO/IEC 2022
  $C->{option}->{designate_to}->{coding_system}->{"\x47"} = 1;	## UTF-8
  $C;
}
sub __2022_decode ($) {
  my $C = shift->__2022__common;
  ## Emacsen's x-ctext
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{A};	## ISO/IEC 8859-1
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_isoiec8859_1 ucs_to_isoiec8859_2 ucs_to_isoiec8859_3 ucs_to_isoiec8859_4 ucs_to_isoiec8859_5 ucs_to_isoiec8859_6 ucs_to_isoiec8859_7 ucs_to_isoiec8859_8 ucs_to_isoiec8859_9 ucs_to_gb2312_1980 ucs_to_jisx0208_1983 ucs_to_ksx1001_1992 ucs_to_jisx0212_1990 ucs_to_jisx0201_latin ucs_to_jisx0201_katakana/];
}
sub __decode_map ($) {
  [qw/isoiec8859_2_to_ucs isoiec8859_3_to_ucs isoiec8859_4_to_ucs isoiec8859_5_to_ucs isoiec8859_6_to_ucs isoiec8859_7_to_ucs isoiec8859_8_to_ucs isoiec8859_9_to_ucs gb2312_1980_to_ucs jisx0208_1983_to_ucs ksx1001_1992_to_ucs jisx0212_1990_to_ucs/];
}


1;
__END__

=back

=head1 LICENSE

Copyright 2002 Wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/10/12 07:27:01 $
### SevenBit.pm ends here
