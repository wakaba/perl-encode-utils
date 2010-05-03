## This file is auto-generated (at 2010-05-03T06:14:51Z).
## Do not edit by hand!

=head1 NAME

Encode::ISO2022::JUNETCompatible --- An Encode module of 7-bit ISO/IEC 2022
based compatible coding systems for Japanese

=head1 DESCRIPTION

Due to the historical reason, some of current
implementions of JIS coded character sets support
pairs of same characters dupplicately, with
halfwidth/fullwidth property.

Although this situation is undesirable, we can't ignore
such historical implementions and latest JIS coded
character set standards admire such dupulicate
encoding to and only to "keep compatibility with
current practice."

This module provides encoder and decoder for such
coding systems that comform to JIS and that based
on 7-bit ISO/IEC 2022 structure.

Those coding systems SHOULD NOT be used for new
implemention NOR new data.  They may not comform
to future version of JIS or other standards.

=cut

package Encode::ISO2022::JUNETCompatible;
use 5.7.3;
use strict;
our $VERSION = q(2010.0503);

=head1 ENCODINGS

=over 8

=cut


package Encode::ISO2022::JUNETCompatible::iso_2022_jp_fullwidth;
our $VERSION = $Encode::ISO2022::JUNETCompatible::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-jp-fullwidth /);

=item iso-2022-jp-fullwidth

ISO/IEC 2022 based 7-bit encoding for Japanese,
ASCII + JIS X 0201 + JIS X 0208-1978 + JIS X 0208-1983.
Some characters defined in JIS X 0208 are mapped to FULLWIDTH
area of UCS as specified in JIS X 0208:1997.

This encoding is a "compatible" version of
C<iso-2022-jp> defined in Encode::ISO2022::JUNET.

When decoding, mapping tables from coded character
sets listed below to UCS are also loaded to restore
incorrectly labeled data.

	JIS X 0201 Katakana coded character set,
	JIS X 0212-1990, JIS X 0213:2000

Note that for Windows user, Encode::ISO2022::CP932
may be useful to try to restore broken "ISO-2022-JP"
data.

=cut

sub encode ($$;$) {
  my ($obj, $s, $chk) = @_;
  my %s;
  require Encode::ISO2022;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  $C->{option}->{fallback_from_ucs} = $obj->{_encode_fallback} ? $obj->{_encode_fallback} :
    $chk & Encode::DIE_ON_ERR ? 'croak' :
    $chk & Encode::RETURN_ON_ERR ? ($chk & Encode::WARN_ON_ERR ? 'quiet+warn' : 'quiet') :
    $chk & Encode::PERLQQ ? 'perl' :        $chk & Encode::HTMLCREF ? 'sgml' :
    $chk & Encode::XMLCREF ? 'sgml-hex' : 'replacement';
  require Encode::Table;
  my $tbl = defined $obj->{_encode_mapping} ? $obj->{_encode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_encode_mapping_autoload} ? $obj->{_encode_mapping_autoload} : 1);
  $C->{GR} = undef;
  $C->{C1} = $Encode::Charset::CHARSET{C1}->{'~'};
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'~'};
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983_irv ucs_to_jisx0208_1978_irv ucs_to_jisx0201_latin)], %tblopt) if $tbl;
  ($s, %s) = Encode::ISO2022::internal_to_iso2022 ($s, $C);
  if ($s{die}) {	## FB_CROAK
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  } elsif ($s{halfway}) {	## FB_QUIET, FB_WARNING
    $_[1] = substr ($_[1], $s{converted_length});
    if ($s{warn}) {
      if ($Carp::VERSION) { Carp::carp ('encode: '.$s{reason}) }
      else { warn ('encode: '.$s{reason}) }
    }
  } else {
    $_[1] = '' if $chk;
  }
  return $s;
}

sub _encode_internal ($$$) {
  my ($obj, $s, $C) = @_;
  my %s;
  require Encode::ISO2022;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_encode_mapping} ? $obj->{_encode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_encode_mapping_autoload} ? $obj->{_encode_mapping_autoload} : 1);
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983_irv ucs_to_jisx0208_1978_irv ucs_to_jisx0201_latin)], %tblopt) if $tbl;
  ($s, %s) = Encode::ISO2022::internal_to_iso2022 ($s, $C);
  if ($s{die}) {
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  }
  return $s;
}

sub decode ($$;$) {
  my ($obj, $s, $chk) = @_;
  require Encode::ISO2022;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_decode_mapping} ? $obj->{_decode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_decode_mapping_autoload} ? $obj->{_decode_mapping_autoload} : 1);
  
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(jisx0208_1983_irv_to_ucs jisx0208_1978_irv_to_ucs jisx0201_latin_to_ucs jisx0201_katakana_to_ucs jisx0212_1990_irv_to_ucs jisx0208_1997_irv_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 7;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{'B'} = 0;	## ASCII
  $C->{option}->{designate_to}->{G94}->{'J'} = 0;	## JIS X 0201 Roman
  $C->{option}->{designate_to}->{G94n}->{'@'} = 0;	## JIS X 0208-1978
  $C->{option}->{designate_to}->{G94n}->{'B'} = 0;	## JIS X 0208-1983
  $C->{option}->{designate_to}->{G94n}->{'B@'} = 0;	## JIS X 0208-1990
  $C->{option}->{use_revision} = 0;
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B'}];
  $C;
}

package Encode::ISO2022::JUNETCompatible::iso_2022_jp_3_fullwidth;
our $VERSION = $Encode::ISO2022::JUNETCompatible::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-jp-3-fullwidth /);

=item iso-2022-jp-3-fullwidth

ISO/IEC 2022 based 7-bit encoding for Japanese,
ISO/IEC 646 IRV + JIS X 0213:2000.  Some characters
defined in JIS X 0213 are mapped to FULLWIDTH
area of UCS as specified in JIS X 0213:2000.

This encoding is a "compatible" version of
C<iso-2022-jp-3> defined in Encode::ISO2022::JUNET.

=cut

sub encode ($$;$) {
  my ($obj, $s, $chk) = @_;
  my %s;
  require Encode::ISO2022;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  $C->{option}->{fallback_from_ucs} = $obj->{_encode_fallback} ? $obj->{_encode_fallback} :
    $chk & Encode::DIE_ON_ERR ? 'croak' :
    $chk & Encode::RETURN_ON_ERR ? ($chk & Encode::WARN_ON_ERR ? 'quiet+warn' : 'quiet') :
    $chk & Encode::PERLQQ ? 'perl' :        $chk & Encode::HTMLCREF ? 'sgml' :
    $chk & Encode::XMLCREF ? 'sgml-hex' : 'replacement';
  require Encode::Table;
  my $tbl = defined $obj->{_encode_mapping} ? $obj->{_encode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_encode_mapping_autoload} ? $obj->{_encode_mapping_autoload} : 1);
  $C->{GR} = undef;
  $C->{C1} = $Encode::Charset::CHARSET{C1}->{'~'};
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'~'};
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1_irv ucs_to_jisx0213_2000_2)], %tblopt) if $tbl;
  ($s, %s) = Encode::ISO2022::internal_to_iso2022 ($s, $C);
  if ($s{die}) {	## FB_CROAK
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  } elsif ($s{halfway}) {	## FB_QUIET, FB_WARNING
    $_[1] = substr ($_[1], $s{converted_length});
    if ($s{warn}) {
      if ($Carp::VERSION) { Carp::carp ('encode: '.$s{reason}) }
      else { warn ('encode: '.$s{reason}) }
    }
  } else {
    $_[1] = '' if $chk;
  }
  return $s;
}

sub _encode_internal ($$$) {
  my ($obj, $s, $C) = @_;
  my %s;
  require Encode::ISO2022;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_encode_mapping} ? $obj->{_encode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_encode_mapping_autoload} ? $obj->{_encode_mapping_autoload} : 1);
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1_irv ucs_to_jisx0213_2000_2)], %tblopt) if $tbl;
  ($s, %s) = Encode::ISO2022::internal_to_iso2022 ($s, $C);
  if ($s{die}) {
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  }
  return $s;
}

sub decode ($$;$) {
  my ($obj, $s, $chk) = @_;
  require Encode::ISO2022;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_decode_mapping} ? $obj->{_decode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_decode_mapping_autoload} ? $obj->{_decode_mapping_autoload} : 1);
  
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(jisx0213_2000_1_irv_to_ucs jisx0213_2000_2_to_ucs jisx0208_1997_irv_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 7;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{'B'} = 0;	## ASCII
  #C:designate:G94n:B=0	## JIS X 0213:2000 plane 1
  $C->{option}->{designate_to}->{G94n}->{'O'} = 0;	## JIS X 0213:2000 plane 1
  $C->{option}->{designate_to}->{G94n}->{'P'} = 0;	## JIS X 0213:2000 plane 2
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C;
}

=back

=cut


=head1 SEE ALSO



JIS X 0208:1997, "7-bit and 8-bit double byte coded Kanji
set for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 1997.

JIS X 0213:2000, "7-bit and 8-bit double byte coded extended Kanji
sets for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 2000.

RFC 1468, "Japanese Character Encoding for Internet Messages",
J. Murai, et al, IETF <http://www.ietf.org/>, June 1993.
<urn:ietf:rfc:1468>.

L<Encode::ISO2022::JUNET>

L<Encode::ISO2022::EightBit>, L<Encode::ISO2022::EUCJACompatible>,
L<Encode::SJIS::JISCompatible>

=head1 LICENSE

Copyright 2010 Wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1;
