## This file is auto-generated (at 2010-05-03T06:14:51Z).
## Do not edit by hand!

=head1 NAME

Encode::ISO2022::EightBit --- Encode and decode of 8-bit ISO/IEC 2022 based encodings
(except EUCs)


=cut

package Encode::ISO2022::EightBit;
use 5.7.3;
use strict;
our $VERSION = q(2010.0503);

=head1 ENCODINGS

=over 8

=cut


package Encode::ISO2022::EightBit::iso_2022_8bit_ss2;
our $VERSION = $Encode::ISO2022::EightBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-8bit-ss2 /);

=item iso-2022-8bit-ss2

ISO/IEC 2022 based 8-bit encoding using SS2 for 96-charset.

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
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'~'};	## empty
  $C->{G2} = $Encode::Charset::CHARSET{G96}->{'~'};	## empty
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
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'A'};	## ISO/IEC 8859-1
  $C->{G2} = $Encode::Charset::CHARSET{G96}->{'A'};	## ISO/IEC 8859-1
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  eval q(use Encode::Charset::Private q(:mule)) or die $@;
  eval q(Encode::Charset::Private::designate_mule ($C));
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ASCII
  $C->{option}->{designate_to}->{G96}->{'default'} = 2;
  $C->{option}->{designate_to}->{G96n}->{'default'} = 2;
  $C->{option}->{G94n_designate_long} = 1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{Ginvoke_by_single_shift} = [0,0,1,1];
  $C->{option}->{C1invoke_to_right} = 1;
  $C;
}

package Encode::ISO2022::EightBit::compound_text;
our $VERSION = $Encode::ISO2022::EightBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/compound-text compound_text x-compound-text ctext x-ctext ct iso8/);

=item compound-text

ISO/IEC 2022 based 8-bit encoding used in inter-client
communication of X Window System.
(Alias: compound_text, x-compound-text, ctext, x-ctext, ct, iso8)

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
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'~'};	## empty
  $C->{G2} = $Encode::Charset::CHARSET{G96}->{'~'};	## empty
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_isoiec8859_1 ucs_to_isoiec8859_2 ucs_to_isoiec8859_3 ucs_to_isoiec8859_4 ucs_to_isoiec8859_5 ucs_to_isoiec8859_6 ucs_to_isoiec8859_7 ucs_to_isoiec8859_8 ucs_to_isoiec8859_9 ucs_to_gb2312_1980 ucs_to_jisx0208_1983 ucs_to_ksx1001_1992 ucs_to_jisx0212_1990 ucs_to_jisx0201_latin ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_isoiec8859_1 ucs_to_isoiec8859_2 ucs_to_isoiec8859_3 ucs_to_isoiec8859_4 ucs_to_isoiec8859_5 ucs_to_isoiec8859_6 ucs_to_isoiec8859_7 ucs_to_isoiec8859_8 ucs_to_isoiec8859_9 ucs_to_gb2312_1980 ucs_to_jisx0208_1983 ucs_to_ksx1001_1992 ucs_to_jisx0212_1990 ucs_to_jisx0201_latin ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'A'};	## ISO/IEC 8859-1
  $C->{G2} = $Encode::Charset::CHARSET{G96}->{'A'};	## ISO/IEC 8859-1
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(isoiec8859_2_to_ucs isoiec8859_3_to_ucs isoiec8859_4_to_ucs isoiec8859_5_to_ucs isoiec8859_6_to_ucs isoiec8859_7_to_ucs isoiec8859_8_to_ucs isoiec8859_9_to_ucs gb2312_1980_to_ucs jisx0208_1983_to_ucs ksx1001_1992_to_ucs jisx0212_1990_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ASCII
  $C->{option}->{designate_to}->{C0}->{'default'} = -1;
  $C->{option}->{designate_to}->{C1}->{'default'} = -1;
  for (0x30..0x7E) {
  my $F = chr $_;
    $C->{option}->{designate_to}->{G94}->{$F} = -1;
    $C->{option}->{designate_to}->{G96}->{$F} = -1;
    $C->{option}->{designate_to}->{G94n}->{$F} = -1;
    $C->{option}->{designate_to}->{G96n}->{$F} = -1;
  }
  for (0x30..0x3F) {
    my $F = chr $_;
    for my $c (qw/G94 G96 G94n G96n C0 C1/) {
      $C->{option}->{designate_to}->{$c}->{$F} = -1;
      $C->{option}->{designate_to}->{$c}->{'!'.$F} = -1;
      $C->{option}->{designate_to}->{$c}->{'"'.$F} = -1;
      $C->{option}->{designate_to}->{$c}->{'#'.$F} = -1;
    }
  }
  $C->{option}->{designate_to}->{G94}->{'I'} = 1;	## JIS X 0201 Katakana
  $C->{option}->{designate_to}->{G94n}->{'B@'} = -1;	## JIS X 0208-1990
  $C->{option}->{designate_to}->{G96}->{'default'} = 1;
  $C->{option}->{designate_to}->{G96n}->{'default'} = -1;
  $C->{option}->{designate_to}->{coding_system}->{'0'} = 0;
  $C->{option}->{designate_to}->{coding_system}->{'1'} = 0;
  $C->{option}->{designate_to}->{coding_system}->{'2'} = 0;
  $C->{option}->{designate_to}->{coding_system}->{'3'} = 0;
  $C->{option}->{G94n_designate_long} = 1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{C1invoke_to_right} = 1;
  $C->{option}->{reset}->{Ginvoke} = 0;
  $C->{option}->{use_revision} = 0;
  $C;
}

package Encode::ISO2022::EightBit::compound_text_xfree86;
our $VERSION = $Encode::ISO2022::EightBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/compound-text-xfree86 /);

=item compound-text-xfree86

ISO/IEC 2022 based 8-bit encoding used in inter-client
communication of XFree86.

This coding system is upper-compatible version of X
Window System (original)'s Compound Text.  It allows
UTF-8 embeding.  See
<http://cvsweb.xfree86.org/cvsweb/xc/doc/specs/CTEXT/ctext.tbl.ms>.

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
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'~'};	## empty
  $C->{G2} = $Encode::Charset::CHARSET{G96}->{'~'};	## empty
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_isoiec8859_1 ucs_to_isoiec8859_2 ucs_to_isoiec8859_3 ucs_to_isoiec8859_4 ucs_to_isoiec8859_5 ucs_to_isoiec8859_6 ucs_to_isoiec8859_7 ucs_to_isoiec8859_8 ucs_to_isoiec8859_9 ucs_to_gb2312_1980 ucs_to_jisx0208_1983 ucs_to_ksx1001_1992 ucs_to_jisx0212_1990 ucs_to_jisx0201_latin ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_isoiec8859_1 ucs_to_isoiec8859_2 ucs_to_isoiec8859_3 ucs_to_isoiec8859_4 ucs_to_isoiec8859_5 ucs_to_isoiec8859_6 ucs_to_isoiec8859_7 ucs_to_isoiec8859_8 ucs_to_isoiec8859_9 ucs_to_gb2312_1980 ucs_to_jisx0208_1983 ucs_to_ksx1001_1992 ucs_to_jisx0212_1990 ucs_to_jisx0201_latin ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'A'};	## ISO/IEC 8859-1
  $C->{G2} = $Encode::Charset::CHARSET{G96}->{'A'};	## ISO/IEC 8859-1
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(isoiec8859_2_to_ucs isoiec8859_3_to_ucs isoiec8859_4_to_ucs isoiec8859_5_to_ucs isoiec8859_6_to_ucs isoiec8859_7_to_ucs isoiec8859_8_to_ucs isoiec8859_9_to_ucs gb2312_1980_to_ucs jisx0208_1983_to_ucs ksx1001_1992_to_ucs jisx0212_1990_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ASCII
  $C->{option}->{designate_to}->{C0}->{'default'} = -1;
  $C->{option}->{designate_to}->{C1}->{'default'} = -1;
  for (0x30..0x7E) {
  my $F = chr $_;
    $C->{option}->{designate_to}->{G94}->{$F} = -1;
    $C->{option}->{designate_to}->{G96}->{$F} = -1;
    $C->{option}->{designate_to}->{G94n}->{$F} = -1;
    $C->{option}->{designate_to}->{G96n}->{$F} = -1;
  }
  for (0x30..0x3F) {
    my $F = chr $_;
    for my $c (qw/G94 G96 G94n G96n C0 C1/) {
      $C->{option}->{designate_to}->{$c}->{$F} = -1;
      $C->{option}->{designate_to}->{$c}->{'!'.$F} = -1;
      $C->{option}->{designate_to}->{$c}->{'"'.$F} = -1;
      $C->{option}->{designate_to}->{$c}->{'#'.$F} = -1;
    }
  }
  $C->{option}->{designate_to}->{G94}->{'I'} = 1;	## JIS X 0201 Katakana
  $C->{option}->{designate_to}->{G94n}->{'B@'} = 0;	## JIS X 0208-1990
  $C->{option}->{designate_to}->{G96}->{'default'} = 1;
  $C->{option}->{designate_to}->{G96n}->{'default'} = -1;
  $C->{option}->{designate_to}->{coding_system}->{'0'} = 0;
  $C->{option}->{designate_to}->{coding_system}->{'1'} = 0;
  $C->{option}->{designate_to}->{coding_system}->{'2'} = 0;
  $C->{option}->{designate_to}->{coding_system}->{'3'} = 0;
  $C->{option}->{designate_to}->{coding_system}->{'@'} = 0;	## ISO/IEC 2022
  $C->{option}->{designate_to}->{coding_system}->{'G'} = 0;	## UTF-8
  $C->{option}->{G94n_designate_long} = 1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{C1invoke_to_right} = 1;
  $C->{option}->{reset}->{Ginvoke} = 0;
  $C->{option}->{use_revision} = 0;
  $C;
}

package Encode::ISO2022::EightBit::x_ctext;
our $VERSION = $Encode::ISO2022::EightBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/x-ctext /);

=item x-ctext

ISO/IEC 2022 based 8-bit encoding used in emacsen community.
This coding system is almost compatible with X Window System's
Compound Text but it allows private coded character sets
and 96^n coded character sets.

See [mule-jp:7455] <mid:rsqsoa5s2hr.fsf@crane.jaist.ac.jp> and
[mule-jp:7457] <mid:rsq4smlky85.fsf@crane.jaist.ac.jp>.

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
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'~'};	## empty
  $C->{G2} = $Encode::Charset::CHARSET{G96}->{'~'};	## empty
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_isoiec8859_1 ucs_to_isoiec8859_2 ucs_to_isoiec8859_3 ucs_to_isoiec8859_4 ucs_to_isoiec8859_5 ucs_to_isoiec8859_6 ucs_to_isoiec8859_7 ucs_to_isoiec8859_8 ucs_to_isoiec8859_9 ucs_to_gb2312_1980 ucs_to_jisx0208_1983 ucs_to_ksx1001_1992 ucs_to_jisx0212_1990 ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2 ucs_to_jisx0208_1990 ucs_to_jisx0208_1978 ucs_to_jisx0201_latin ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_isoiec8859_1 ucs_to_isoiec8859_2 ucs_to_isoiec8859_3 ucs_to_isoiec8859_4 ucs_to_isoiec8859_5 ucs_to_isoiec8859_6 ucs_to_isoiec8859_7 ucs_to_isoiec8859_8 ucs_to_isoiec8859_9 ucs_to_gb2312_1980 ucs_to_jisx0208_1983 ucs_to_ksx1001_1992 ucs_to_jisx0212_1990 ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2 ucs_to_jisx0208_1990 ucs_to_jisx0208_1978 ucs_to_jisx0201_latin ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'A'};	## ISO/IEC 8859-1
  $C->{G2} = $Encode::Charset::CHARSET{G96}->{'A'};	## ISO/IEC 8859-1
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(isoiec8859_2_to_ucs isoiec8859_3_to_ucs isoiec8859_4_to_ucs isoiec8859_5_to_ucs isoiec8859_6_to_ucs isoiec8859_7_to_ucs isoiec8859_8_to_ucs isoiec8859_9_to_ucs gb2312_1980_to_ucs jisx0208_1983_to_ucs ksx1001_1992_to_ucs jisx0212_1990_to_ucs jisx0208_1990_to_ucs jisx0213_2000_1_to_ucs jisx0213_2000_2_to_ucs jisx0208_1978_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ASCII
  $C->{option}->{designate_to}->{C0}->{'default'} = -1;
  $C->{option}->{designate_to}->{C1}->{'default'} = -1;
  for (0x30..0x7E) {
  my $F = chr $_;
    $C->{option}->{designate_to}->{G94}->{$F} = -1;
    $C->{option}->{designate_to}->{G96}->{$F} = -1;
    $C->{option}->{designate_to}->{G94n}->{$F} = -1;
    $C->{option}->{designate_to}->{G96n}->{$F} = -1;
  }
  $C->{option}->{designate_to}->{G94}->{'I'} = 1;	## JIS X 0201 Katakana
  $C->{option}->{designate_to}->{G96}->{'default'} = 1;
  $C->{option}->{designate_to}->{G96n}->{'default'} = -1;
  $C->{option}->{G94n_designate_long} = 1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{C1invoke_to_right} = 1;
  $C->{option}->{reset}->{Ginvoke} = 0;
  $C;
}

=back

=cut


=head1 SEE ALSO

L<Encode::ISO2022>, L<Encode::ISO2022::EUCJA>,
L<Encode::ISO2022::EUCKR>, L<Encode::ISO2022::EUCZH>.

=head1 LICENSE

Copyright 2010 Wakaba <w@suika.fam.cx>.

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1;
