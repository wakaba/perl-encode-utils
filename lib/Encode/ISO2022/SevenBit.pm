=head1 NAME

Encode::ISO2022::SevenBit --- Encode and decode of 7-bit ISO/IEC 2022
based encodings

=head1 ENCODINGS

=over 4

=cut

require 5.7.3;
use strict;
package Encode::ISO2022::SevenBit;
use vars qw($VERSION);
$VERSION=do{my @r=(q$Revision: 1.9 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-7bit iso-2022-7 jis junet jis7
  7bit-jis/);
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

=item iso-2022-7bit

ISO/IEC 2022 based 7-bit encoding using only G0
(Alias: junet (emacsen), jis, jis7, iso-2022-7 (emacsen), 7bit-jis (perl))

=cut

sub __2022__common ($) {
  my $C = Encode::ISO2022->new_object;
  $C->{bit} = 7;
  $C->{option}->{designate_to}->{G96}->{default} = 0;
  $C->{option}->{designate_to}->{G96n}->{default} = 0;
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x7E"};	## empty set
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

package Encode::ISO2022::SevenBit::JP;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit';
__PACKAGE__->Define (qw/iso-2022-jp junet-code japanese-iso-7bit csiso2022jp
 iso2022jp/);

=item iso-2022-jp

ISO/IEC 2022 based 7-bit encoding for Japanese.
Defined by Junet no tebiki, RFC 1468 and JIS X 0208:1997 Appendix 2.
(Alias: junet-code, japanese-iso-7bit (emacsen), csISO2022JP (IANA))

=cut

sub __2022__common ($) {
  my $C = Encode::ISO2022->new_object;
  $C->{bit} = 7;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{"\x40"} = 0;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{"\x4A"} = 0;	## JIS X 0201 roman
  $C->{option}->{designate_to}->{G94n}->{"\x40"} = 0;	## JIS X 0208-1978
  $C->{option}->{designate_to}->{G94n}->{"\x42"} = 0;	## JIS X 0208-1983
  $C->{option}->{designate_to}->{G94n}->{"\x42\x40"} = 0;	## JIS X 0208-1990
  $C->{option}->{use_revision} = 0;
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C->{C1} = $Encode::ISO2022::CHARSET{C1}->{"\x7E"};	## empty set
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x7E"};	## empty set
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0208_1990 ucs_to_jisx0208_1978 ucs_to_jisx0201_latin/];
}
sub __decode_map ($) {
  [qw/jisx0208_1983_to_ucs jisx0208_1990_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs/];
}

package Encode::ISO2022::SevenBit::JP1978IRV;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit::JP';
__PACKAGE__->Define (qw/iso-2022-jp-1978-irv japanese-iso-7bit-1978-irv old-jis
  x-obsoleted-iso-2022-jp jis78/);

=item iso-2022-jp-1978-irv

ISO/IEC 2022 based 7-bit encoding for Japanese,
using JIS X 0208-1978.
(Alias: japanese-iso-7bit-1978-irv (emacsen), old-jis (emacsen),
jis78)

=cut

sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C->{option}->{designate_to}->{G94}->{"\x4A"} = -1;	## JIS X 0201 roman
  $C->{option}->{designate_to}->{G94n}->{"\x42"} = -1;	## JIS X 0208-1983
  $C->{option}->{designate_to}->{G94n}->{"\x42\x40"} = -1;	## JIS X 0208-1990
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0208_1978 ucs_to_jisx0208_1983 ucs_to_jisx0208_1990 ucs_to_jisx0201_latin/];
}
sub __decode_map ($) {
  [qw/jisx0208_1983_to_ucs jisx0208_1990_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs/];
}

package Encode::ISO2022::SevenBit::JP1;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit::JP';
__PACKAGE__->Define (qw/iso-2022-jp-1 iso2022jp-1/);

=item iso-2022-jp-1

ISO/IEC 2022 based 7-bit encoding for Japanese,
defined by RFC 2237.  (Alias: iso2022jp-1)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{option}->{designate_to}->{G94n}->{"\x44"} = 0;	## JIS X 0212-1990
  $C->{option}->{designate_to}->{G94n}->{"\x42\x40"} = -1;	## JIS X 0208-1990
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0212_1990 ucs_to_jisx0208_1978 ucs_to_jisx0201_latin/];
}
sub __decode_map ($) {
  [qw/jisx0208_1983_to_ucs jisx0212_1990_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs/];
}

package Encode::ISO2022::SevenBit::JP3;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit::JP';
__PACKAGE__->Define (qw/iso-2022-jp-3 x-iso-2022-jp-3 iso2022jp-3
 jis0213/);

=item iso-2022-jp-3

ISO/IEC 2022 based 7-bit encoding for Japanese,
defined by JIS X 0213:2000 Appendix 2.
(Alias: x-iso-2022-jp-3, iso2022jp-3, jis0213)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{option}->{designate_to}->{G94}->{"\x4A"} = -1;	## JIS X 0201 roman
  $C->{option}->{designate_to}->{G94n}->{"\x40"} = -1;	## JIS X 0208-1978
  $C->{option}->{designate_to}->{G94n}->{"\x42"} = 0;	## restricted JIS X 0213:2000 plane 1
  $C->{option}->{designate_to}->{G94n}->{"\x42\x40"} = -1;	## JIS X 0208-1990
  $C->{option}->{designate_to}->{G94n}->{"\x4F"} = 0;	## JIS X 0213:2000 plane 1
  $C->{option}->{designate_to}->{G94n}->{"\x50"} = 0;	## JIS X 0213:2000 plane 2
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2/];
}
sub __decode_map ($) {
  [qw/jisx0213_2000_1_to_ucs jisx0212_0213_to_ucs jisx0208_1983_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs/];
}

package Encode::ISO2022::SevenBit::JP3Strict;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit::JP3';
__PACKAGE__->Define (qw/iso-2022-jp-3-strict/);

=item iso-2022-jp-3-strict

ISO/IEC 2022 based 7-bit encoding for Japanese.
A subset of iso-2022-jp-3.
See <http://www.m17n.org/m17n2000_all_but_registration/proceedings/kawabata/jisx0213.html>.

=cut

sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0213_2000_1_esc_24_42 ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2/];
}

package Encode::ISO2022::SevenBit::JP3Compatible;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit::JP3';
__PACKAGE__->Define (qw/iso-2022-jp-3-compatible/);

=item iso-2022-jp-3-compatible

ISO/IEC 2022 based 7-bit encoding for Japanese.
See <http://www.m17n.org/m17n2000_all_but_registration/proceedings/kawabata/jisx0213.html>.

=cut

sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2/];
}

package Encode::ISO2022::SevenBit::JP3Plane1;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit::JP3';
__PACKAGE__->Define (qw/iso-2022-jp-3-plane1/);

=item iso-2022-jp-3-plane1

ISO/IEC 2022 based 7-bit encoding for Japanese,
defined by JIS X 0213:2000 Appendix 2.

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{option}->{designate_to}->{G94n}->{"\x50"} = -1;	## JIS X 0213:2000 plane 2
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0213_2000_1/];
}
sub __decode_map ($) {
  [qw/jisx0213_2000_1_to_ucs jisx0208_1983_to_ucs/];
}

package Encode::ISO2022::SevenBit::SS2;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit';
__PACKAGE__->Define (qw/iso-2022-7bit-ss2 x-iso-2022-jp-2 iso-2022-ss2-7
   jis_encoding csjisencoding/);

=item iso-2022-7bit-ss2

ISO/IEC 2022 based 7-bit encoding using SS2 for 96-charset
(Alias: x-iso-2022-jp-2, iso-2022-ss2-7 (emacsen))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{option}->{designate_to}->{G96}->{default} = 2;
  $C->{option}->{designate_to}->{G96n}->{default} = 2;
  $C->{option}->{Ginvoke_by_single_shift}->[2] = 1;
  $C;
}

package Encode::ISO2022::SevenBit::JP2;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit::SS2';
__PACKAGE__->Define (qw/iso-2022-jp-2 csiso2022jp2 iso2022jp-2/);

=item iso-2022-jp-2

ISO/IEC 2022 based 7-bit multilingual encoding, defined by
RFC 1554.  A subset of iso-2022-7bit-ss2.  (Alias: iso2022jp-2,
csISO2022JP2 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{"\x40"} = 0;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{C1} = $Encode::ISO2022::CHARSET{C1}->{"\x47"};	## Minimum C1
  $C->{option}->{designate_to}->{C1}->{"\x47"} = -1;
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{"\x4A"} = 0;	## JIS X 0201 roman
  for ("\x40", "\x41", "\x42", "\x43", "\x44") {
    $C->{option}->{designate_to}->{G94n}->{ $_ } = 0;
  }
  for ("\x41", "\x46") {
    $C->{option}->{designate_to}->{G96}->{ $_ } = 2;
  }
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C->{C1} = $Encode::ISO2022::CHARSET{C1}->{"\x7E"};	## empty set
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x7E"};	## empty set
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0212_1990 ucs_to_gb2312_1980 ucs_to_ksx1001_1992 ucs_to_jisx0208_1978 ucs_to_isoiec8859_1 ucs_to_isoiec8859_7 ucs_to_jisx0201_latin/];
}
sub __decode_map ($) {
  [qw/jisx0208_1983_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs gb2312_1980_to_ucs ksx1001_1992_to_ucs isoiec8859_7_to_ucs/];
}

package Encode::ISO2022::SevenBit::Lock;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit';
__PACKAGE__->Define (qw/iso-2022-7bit-lock/);

=item iso-2022-7bit-lock

ISO/IEC 2022 based 7-bit encoding using G1 and locking-shift for 96-charset

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{option}->{designate_to}->{G96}->{default} = 1;
  $C->{option}->{designate_to}->{G96n}->{default} = 1;
  $C;
}

package Encode::ISO2022::SevenBit::INT;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit';
__PACKAGE__->Define (qw/iso-2022-int iso-2022-int-*  iso-2022-int-2/);

=item iso-2022-int

ISO/IEC 2022 based 7-bit encoding using G1 and locking-shift for
KS X 1001 and 96-charset.  See draft-ohta-text-encoding.
(Alias: iso-2022-int-*)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{option}->{designate_to}->{G96}->{default} = 1;
  $C->{option}->{designate_to}->{G96n}->{default} = 1;
  $C->{option}->{designate_to}->{G94n}->{"\x43"} = 1;	## KS X 1001
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C->{C1} = $Encode::ISO2022::CHARSET{C1}->{"\x7E"};	## empty set
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x7E"};	## empty set
  $C;
}
sub __2022_decode ($) {
  my $C = shift->__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{"\x43"};	## KS X 1001
  $C;
}

package Encode::ISO2022::SevenBit::KR;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit';
__PACKAGE__->Define (qw/iso-2022-kr korean-iso-7bit csiso2022kr cp50225 kr2022/);

=item iso-2022-kr

An ISO/IEC 2022 based 7-bit encoding for Korean,
defined by RFC 1557 (Alias: korean-iso-7bit (emacsen),
csISO2022KR (IANA), CP50225 (M$), KR2022)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{"\x40"} = 0;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{"\x43"} = 1;	## KS X 1001
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C->{C1} = $Encode::ISO2022::CHARSET{C1}->{"\x7E"};	## empty set
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x7E"};	## empty set
  $C;
}
sub __2022_decode ($) {
  my $C = shift->__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{"\x43"};	## KS X 1001
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ksx1001_1992_to_ucs/];
}
sub __decode_map ($) {
  [qw/ksx1001_1992_to_ucs/];
}

package Encode::ISO2022::SevenBit::INT1;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit';
__PACKAGE__->Define (qw/iso-2022-int-1/);

=item iso-2022-int-1

An ISO/IEC 2022 based 7-bit multilingual encoding,
defined by draft-ohta-text-encoding

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{"\x40"} = 0;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{"\x4A"} = 0;	## JIS X 0201 roman
  for ("\x40", "\x41", "\x42", "\x44") {
    $C->{option}->{designate_to}->{G94n}->{ $_ } = 0;
  }
  $C->{option}->{designate_to}->{G94n}->{"\x43"} = 1;	## KS X 1001
  for ("\x41", "\x46") {	## ISO/IEC 8859-1,7
    $C->{option}->{designate_to}->{G96}->{ $_ } = 1;
  }
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C->{C1} = $Encode::ISO2022::CHARSET{C1}->{"\x7E"};	## empty set
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x7E"};	## empty set
  $C;
}
sub __2022_decode ($) {
  my $C = shift->__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{"\x43"};	## KS X 1001
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_isoiec8859_1 ucs_to_jisx0208_1983 ucs_to_jisx0212_1990 ucs_to_gb2312_1980 ucs_to_ksx1001_1992 ucs_to_isoiec8859_7 ucs_to_jisx0208_1978 ucs_to_jisx0201_latin/];
}
sub __decode_map ($) {
  [qw/jisx0208_1983_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs gb2312_1980_to_ucs ksx1001_1992_to_ucs isoiec8859_7_to_ucs/];
}

package Encode::ISO2022::SevenBit::LockSS2;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit';
__PACKAGE__->Define (qw/iso-2022-7bit-lock-ss2 iso-2022-cjk/);

=item iso-2022-7bit-lock-ss2

An ISO/IEC 2022 based 7-bit encoding.  Mixture of ISO-2022-JP,
ISO-2022-KR, ISO-2022-CN.  (Alias: iso-2022-cjk (emacsen))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{option}->{designate_to}->{G96}->{default} = 2;
  $C->{option}->{designate_to}->{G96n}->{default} = 2;
  $C->{option}->{designate_to}->{G94n}->{"\x41"} = 1;	## GB 2312
  $C->{option}->{designate_to}->{G94n}->{"\x43"} = 1;	## KS X 1001
  $C->{option}->{designate_to}->{G94n}->{"\x45"} = 1;	## ISO-IR 165
  $C->{option}->{designate_to}->{G94n}->{"\x47"} = 1;	## CNS 11643 plane 1
  $C->{option}->{designate_to}->{G94n}->{"\x48"} = 2;	## CNS 11643 plane 2
  $C->{option}->{designate_to}->{G94n}->{"\x49"} = 3;	## CNS 11643 plane 3
  $C->{option}->{designate_to}->{G94n}->{"\x4A"} = 3;	## CNS 11643 plane 4
  $C->{option}->{designate_to}->{G94n}->{"\x4B"} = 3;	## CNS 11643 plane 5
  $C->{option}->{designate_to}->{G94n}->{"\x4C"} = 3;	## CNS 11643 plane 6
  $C->{option}->{designate_to}->{G94n}->{"\x4D"} = 3;	## CNS 11643 plane 7
  $C->{option}->{designate_to}->{G94n}->{P0_0} = 1;	## GB 12345
  $C->{option}->{designate_to}->{G94n}->{P0_1} = 2;	## GB 7589
  $C->{option}->{designate_to}->{G94n}->{P0_2} = 2;	## GB 13131
  $C->{option}->{designate_to}->{G94n}->{P0_3} = 3;	## GB 7590
  $C->{option}->{designate_to}->{G94n}->{P0_4} = 3;	## GB 13132
  $C;
}
sub __2022_decode ($) {
  my $C = shift->__2022__common;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{"\x43"};	## KS X 1001
  $C;
}

package Encode::ISO2022::SevenBit::CN;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit';
__PACKAGE__->Define (qw/iso-2022-cn chinese-iso-7bit  iso2022cn-cns iso2022cn-gb/);

=item iso-2022-cn

An ISO/IEC 2022 based 7-bit encoding for Chinese,
defined by RFC 1922 (Alias: chinese-iso-7bit (emacsen))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{"\x40"} = 0;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{"\x41"} = 1;	## GB 2312
  $C->{option}->{designate_to}->{G94n}->{"\x47"} = 1;	## CNS 11643 plane 1
  $C->{option}->{designate_to}->{G94n}->{"\x48"} = 2;	## CNS 11643 plane 2
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C->{C1} = $Encode::ISO2022::CHARSET{C1}->{"\x7E"};	## empty set
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x7E"};	## empty set
  $C;
}

package Encode::ISO2022::SevenBit::CNExt;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::SevenBit::CN';
__PACKAGE__->Define (qw/iso-2022-cn-ext/);

=item iso-2022-cn-ext

An ISO/IEC 2022 based 7-bit encoding for Chinese,
defined by RFC 1922

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{option}->{designate_to}->{G94n}->{"\x45"} = 1;	## ISO-IR 165
  $C->{option}->{designate_to}->{G94n}->{"\x49"} = 3;	## CNS 11643 plane 3
  $C->{option}->{designate_to}->{G94n}->{"\x4A"} = 3;	## CNS 11643 plane 4
  $C->{option}->{designate_to}->{G94n}->{"\x4B"} = 3;	## CNS 11643 plane 5
  $C->{option}->{designate_to}->{G94n}->{"\x4C"} = 3;	## CNS 11643 plane 6
  $C->{option}->{designate_to}->{G94n}->{"\x4D"} = 3;	## CNS 11643 plane 7
  $C->{option}->{designate_to}->{G94n}->{P0_0} = 1;	## GB 12345
  $C->{option}->{designate_to}->{G94n}->{P0_1} = 2;	## GB 7589
  $C->{option}->{designate_to}->{G94n}->{P0_2} = 2;	## GB 13131
  $C->{option}->{designate_to}->{G94n}->{P0_3} = 3;	## GB 7590
  $C->{option}->{designate_to}->{G94n}->{P0_4} = 3;	## GB 13132
  $C->{option}->{designate_to}->{G94n}->{P1_0} = 3;	## CNS 11643 plane 8
  $C->{option}->{designate_to}->{G94n}->{P1_1} = 3;	## CNS 11643 plane 9
  $C->{option}->{designate_to}->{G94n}->{P1_2} = 3;	## CNS 11643 plane 10
  $C->{option}->{designate_to}->{G94n}->{P1_3} = 3;	## CNS 11643 plane 11
  $C->{option}->{designate_to}->{G94n}->{P1_4} = 3;	## CNS 11643 plane 12
  $C->{option}->{designate_to}->{G94n}->{P1_5} = 3;	## CNS 11643 plane 13
  $C->{option}->{designate_to}->{G94n}->{P1_6} = 3;	## CNS 11643 plane 14
  $C->{option}->{designate_to}->{G94n}->{P2_0} = 3;	## CNS 11643 plane 15
  $C->{option}->{designate_to}->{G94n}->{P2_1} = 3;	## CNS 11643 plane 16
  $C;
}

1;
__END__

=back

=head1 AUTHORS

Wakaba <w@suika.fam.cx>

Nanashi-san

=head1 LICENSE

Copyright 2002 AUTHORS

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/10/05 05:01:24 $
### SevenBit.pm ends here
