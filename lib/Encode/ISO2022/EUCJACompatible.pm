## This file is auto-generated (at 2010-05-03T06:14:51Z).
## Do not edit by hand!

=head1 NAME

Encode::ISO2022::EUCJACompatible --- An Encode module of EUC (8-bit ISO/IEC 2022
based compatible coding system) for Japanese

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
on EUC (an 8-bit ISO/IEC 2022) structure.

Those coding systems SHOULD not be used for new
implemention or new data.  They may not comform
to future version of JIS or other standards.

=cut

package Encode::ISO2022::EUCJACompatible;
use 5.7.3;
use strict;
our $VERSION = q(2010.0503);

=head1 ENCODINGS

=over 8

=cut


package Encode::ISO2022::EUCJACompatible::euc_japan_1990_fullwidth;
our $VERSION = $Encode::ISO2022::EUCJACompatible::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/euc-japan-1990-fullwidth euc-jp-1990-fullwidth ajec/);

=item euc-japan-1990-fullwidth

EUC (ISO/IEC 2022 based 8-bit encoding) for Japanese,
ISO/IEC 646 IRV + JIS X 0208-1990 + JIS X 0212-1990
+ JIS X 0201-1990 Katakana.  Some characters defined
in JIS X 0208 and all characters defined in JIS X 0201
are mapped to FULLWIDTH or HALFWIDTH characters of UCS
as specified by JIS X 0221-1995 and JIS X 0208:1997.

This encoding is same as C<euc-japan-1997-fullwidth>
except that this encoding has private use areas as
described in JIS X 0208-1990 and JIS X 0212-1990
(as the "free area") and defined in AJEC.  (See "UI-OSF
Application Platform Profile for Japanese Environment".)
Its mapping to UCS private use area is defined by
CDE/Motif WG.

Even 1990 version of JIS coded character set standards
allows "free area", current version of JIS does not.
It should not be used without compatibility purpose.

This encoding is a "compatible" version of
C<euc-japan-1990> defined in Encode::ISO2022::EUCJA.
(Alias: euc-jp-1990-fullwidth, ajec)

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1990_open_ascii ucs_to_jisx0212_1990_irv ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1990_open_ascii ucs_to_jisx0212_1990_irv ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0208_1990_open_ascii_to_ucs jisx0212_1990_irv_to_ucs jisx0201_katakana_hw_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ASCII
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'B@'};	## JIS X 0208-1990
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201 Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{'D'};	## JIS X 0212-1990
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{Ginvoke_by_single_shift} = [0,0,1,1];
  $C->{option}->{C1invoke_to_right} = 1;
  $C->{option}->{reset}->{Gdesignation} = 0;
  $C->{option}->{reset}->{Ginvoke} = 0;
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B@'}];
  $C;
}

package Encode::ISO2022::EUCJACompatible::eucJP_open;
our $VERSION = $Encode::ISO2022::EUCJACompatible::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/eucJP-open eucJP-ascii/);

=item eucJP-open

EUC (ISO/IEC 2022 based 8-bit encoding) for Japanese.

This encoding is same as C<euc-japan-1990-fullwidth>
except that this encoding has IBM extended characters
as defined by CDE/Motif WG.

Even 1990 version of JIS coded character set standards
allows "free area", current version of JIS does not.
It should not be used without compatibility purpose.
(Alias: eucJP-ascii)

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1990_open_ascii ucs_to_jisx0212_1990_open_ascii ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1990_open_ascii ucs_to_jisx0212_1990_open_ascii ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0208_1990_open_ascii_to_ucs jisx0212_1990_open_ascii_to_ucs jisx0201_katakana_hw_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ASCII
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'B@'};	## JIS X 0208-1990
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201 Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{'D'};	## JIS X 0212-1990
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{Ginvoke_by_single_shift} = [0,0,1,1];
  $C->{option}->{C1invoke_to_right} = 1;
  $C->{option}->{reset}->{Gdesignation} = 0;
  $C->{option}->{reset}->{Ginvoke} = 0;
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B@'}];
  $C;
}

package Encode::ISO2022::EUCJACompatible::eucJP_0201;
our $VERSION = $Encode::ISO2022::EUCJACompatible::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/eucJP-0201 /);

=item eucJP-0201

ISO/IEC 2022 based 8-bit encoding for Japanese.

This encoding is same as C<eucJP-ascii> but use JIS X 0201
roman set instead of ASCII, as defined by CDE/Motif WG.

EUC is defined to use ASCII but this coding system use
JIS X 0201 roman, so this coding system SHOULD NOT be
used without compatibility purpose.

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0208_1990_open_0201 ucs_to_jisx0212_1990_open_0201 ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0208_1990_open_0201 ucs_to_jisx0212_1990_open_0201 ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0201_latin_to_ucs jisx0208_1990_open_02101_to_ucs jisx0212_1990_open_0201_to_ucs jisx0201_katakana_hw_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'J'};	## JIS X 0201 Roman
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'B@'};	## JIS X 0208-1990
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201 Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{'D'};	## JIS X 0212-1990
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{Ginvoke_by_single_shift} = [0,0,1,1];
  $C->{option}->{C1invoke_to_right} = 1;
  $C->{option}->{reset}->{Gdesignation} = 0;
  $C->{option}->{reset}->{Ginvoke} = 0;
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B@'}];
  $C;
}

package Encode::ISO2022::EUCJACompatible::euc_japan_1997_fullwidth;
our $VERSION = $Encode::ISO2022::EUCJACompatible::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/euc-japan-1997-fullwidth euc-jp-1997-fullwidth/);

=item euc-japan-1997-fullwidth

EUC (ISO/IEC 2022 based 8-bit encoding) for Japanese,
ISO/IEC 646 IRV + JIS X 0208:1997 + JIS X 0212-1990
+ JIS X 0201:1997 Katakana.  Some characters defined
in JIS X 0208 and all characters defined in JIS X 0201
are mapped to FULLWIDTH or HALFWIDTH characters of UCS
as specified by JIS X 0221-1995 and JIS X 0208:1997.

This encoding is a "compatible" version of
C<euc-japan-1997> defined in Encode::ISO2022::EUCJA.
(Alias: euc-jp-1997-fullwidth)

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1997_irv ucs_to_jisx0212_1990_irv ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1997_irv ucs_to_jisx0212_1990_irv ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0208_1997_irv_to_ucs jisx0212_1990_irv_to_ucs jisx0201_katakana_hw_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ASCII
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201 Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{'D'};	## JIS X 0212-1990
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{Ginvoke_by_single_shift} = [0,0,1,1];
  $C->{option}->{C1invoke_to_right} = 1;
  $C->{option}->{reset}->{Gdesignation} = 0;
  $C->{option}->{reset}->{Ginvoke} = 0;
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B@'}];
  $C;
}

package Encode::ISO2022::EUCJACompatible::euc_jisx0213_fullwidth;
our $VERSION = $Encode::ISO2022::EUCJACompatible::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/euc-jisx0213-fullwidth euc-japan-2000-fullwidth euc-jp-2000-fullwidth/);

=item euc-jisx0213-fullwidth

EUC (ISO/IEC 2022 based 8-bit encoding) for Japanese,
ISO/IEC 646 IRV + JIS X 0213:2000 + JIS X 0201:1997
Katakana.  Some characters defined in JIS X 0213 and
all characters defined in JIS X 0201 are mapped to
FULLWIDTH or HALFWIDTH characters of UCS as specified
by JIS X 0213:2000.

This encoding is a "compatible" version of
C<euc-jisx0213> defined in Encode::ISO2022::EUCJA.
(Alias: euc-japan-2000-fullwidth, euc-jp-2000-fullwidth)

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1_irv ucs_to_jisx0213_2000_2 ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1_irv ucs_to_jisx0213_2000_2 ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0213_2000_1_irv_to_ucs jisx0213_2000_2_to_ucs jisx0201_katakana_hw_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ASCII
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'O'};	## JIS X 0213:2000 plane 1
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201 Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{'P'};	## JIS X 0213:2000 plane 2
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{Ginvoke_by_single_shift} = [0,0,1,1];
  $C->{option}->{C1invoke_to_right} = 1;
  $C->{option}->{reset}->{Gdesignation} = 0;
  $C->{option}->{reset}->{Ginvoke} = 0;
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C;
}

=back

=cut


=head1 EXAMPLE

  use Encode::ISO2022::EUCJACompatible;
  while (<>) {
    print "FW->  : ". Encode::encode ('euc-jp-1997', Encode::decode ('euc-jp-1997-fullwidth', $_));
    print "FW->FW: ". Encode::encode ('euc-jp-1997-fullwidth', Encode::decode ('euc-jp-1997-fullwidth', $_));
    print "  ->FW: ". Encode::encode ('euc-jp-1997-fullwidth', Encode::decode ('euc-jp-1997', $_));
    print "  ->  : ". Encode::encode ('euc-jp-1997', Encode::decode ('euc-jp-1997', $_));
  }

=head1 SEE ALSO



JIS X 0208:1997, "7-bit and 8-bit double byte coded Kanji
set for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 1997.

JIS X 0213:2000, "7-bit and 8-bit double byte coded extended Kanji
sets for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 2000.

L<Encode::ISO2022::EUCJA>

"UI-OSF Application Platform Profile for Japanese Environment
Version 1.1", UI-OSF Japanese Localization Group, 1993-05-21.
<http://www.li18nux.org/~numa/uocjle-a4.pdf> (In Japanese)
or <http://www.li18nux.org/~numa/uocjleE.pdf> (In English).

"OSF/JVC Recommended Code Set Conversion Specification
between Japanese EUC and Shift-JIS, and
Survey on Actual Situation of Japanese Code Sets",
OSF/JVC CDE/Motif Technical WG, 1996-01-19.
<http://www.opengroup.or.jp/jvc/cde/sjis-euc.html> (In Japanese)
or <http://www.opengroup.or.jp/jvc/cde/sjis-euc-e.html> (In English).

"Problems and Solutions for Unicode and User/Vendor Defined Characters",
TOG/JVC CDE/Motif Technical WG, 1996-10-25.
<http://www.opengroup.or.jp/jvc/cde/ucs-conv.html> (In Japanese)
or <http://www.opengroup.or.jp/jvc/cde/ucs-conv-e.html> (In English).

=head1 LICENSE

Copyright 2010 Wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1;
