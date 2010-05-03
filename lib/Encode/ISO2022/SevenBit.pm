## This file is auto-generated (at 2010-05-03T06:14:51Z).
## Do not edit by hand!

=head1 NAME

Encode::ISO2022::SevenBit --- Encode and decode of 7-bit ISO/IEC 2022 based encodings


=cut

package Encode::ISO2022::SevenBit;
use 5.7.3;
use strict;
our $VERSION = q(2010.0503);

=head1 ENCODINGS

=over 8

=cut


package Encode::ISO2022::SevenBit::iso_2022_7bit_ss2;
our $VERSION = $Encode::ISO2022::SevenBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-7bit-ss2 x-iso-2022-jp-2 iso-2022-ss2-7 jis_encoding csjisencoding/);

=item iso-2022-7bit-ss2

ISO/IEC 2022 based 7-bit encoding using SS2 for 96-charset.
(Alias: x-iso-2022-jp-2, iso-2022-ss2-7, jis_encoding, csjisencoding)

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
  $C->{GR} = undef;
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'~'};
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
  
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 7;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};
  $C->{option}->{designate_to}->{C0}->{'default'} = 0;
  $C->{option}->{designate_to}->{C1}->{'default'} = 1;
  $C->{option}->{designate_to}->{G94}->{'default'} = 0;
  $C->{option}->{designate_to}->{G96}->{'default'} = 2;
  $C->{option}->{designate_to}->{G94n}->{'default'} = 0;
  $C->{option}->{designate_to}->{G96n}->{'default'} = 2;
  $C->{option}->{designate_to}->{coding_system}->{'default'} = 0;
  $C->{option}->{Ginvoked_by_single_shift}->[2] = 1;
  $C;
}

package Encode::ISO2022::SevenBit::iso_2022_jp_2;
our $VERSION = $Encode::ISO2022::SevenBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-jp-2 csiso2022jp2 iso2022jp-2/);

=item iso-2022-jp-2

ISO/IEC 2022 based 7-bit multilingual encoding, defined by
RFC 1554.  A profiled subset of iso-2022-7bit-ss2.
(Alias: csiso2022jp2, iso2022jp-2)

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
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'~'};
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0212_1990 ucs_to_gb2312_1980 ucs_to_ksx1001_1992 ucs_to_jisx0208_1978 ucs_to_isoiec8859_1 ucs_to_isoiec8859_7 ucs_to_jisx0201_latin)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0212_1990 ucs_to_gb2312_1980 ucs_to_ksx1001_1992 ucs_to_jisx0208_1978 ucs_to_isoiec8859_1 ucs_to_isoiec8859_7 ucs_to_jisx0201_latin)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0208_1983_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs gb2312_1980_to_ucs ksx1001_1992_to_ucs isoiec8859_7_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 7;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};
  $C->{C1} = $Encode::Charset::CHARSET{C1}->{'G'};	## Minimum C1
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{'B'} = 0;	## ASCII
  $C->{option}->{designate_to}->{G94}->{'J'} = 0;	## JIS X 0201 Latin
  $C->{option}->{designate_to}->{G94n}->{'@'} = 0;	## JIS X 0208-1978
  $C->{option}->{designate_to}->{G94n}->{'A'} = 0;	## GB 2312-80
  $C->{option}->{designate_to}->{G94n}->{'B'} = 0;	## JIS X 0208-1983
  $C->{option}->{designate_to}->{G94n}->{'C'} = 0;	## KS X 1001
  $C->{option}->{designate_to}->{G94n}->{'D'} = 0;	## JIS X 0212-1990
  $C->{option}->{designate_to}->{G96}->{'A'} = 2;	## ISO/IEC 8859-1 GR
  $C->{option}->{designate_to}->{G96}->{'F'} = 2;	## ISO/IEC 8859-7 GR
  $C->{option}->{Ginvoked_by_single_shift}->[2] = 1;
  $C;
}

package Encode::ISO2022::SevenBit::iso_2022_7bit_lock;
our $VERSION = $Encode::ISO2022::SevenBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-7bit-lock iso7/);

=item iso-2022-7bit-lock

ISO/IEC 2022 based 7-bit encoding using G1 and
locking-shift for 96-charset
(Alias: iso7)

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
  $C->{GR} = undef;
  $C->{C1} = $Encode::Charset::CHARSET{C1}->{'~'};
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'~'};
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
  
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 7;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};
  $C->{option}->{designate_to}->{C0}->{'default'} = 0;
  $C->{option}->{designate_to}->{C1}->{'default'} = 1;
  $C->{option}->{designate_to}->{G94}->{'default'} = 0;
  $C->{option}->{designate_to}->{G96}->{'default'} = 1;
  $C->{option}->{designate_to}->{G94n}->{'default'} = 0;
  $C->{option}->{designate_to}->{G96n}->{'default'} = 1;
  $C->{option}->{designate_to}->{coding_system}->{'default'} = 0;
  $C;
}

package Encode::ISO2022::SevenBit::iso_2022_int;
our $VERSION = $Encode::ISO2022::SevenBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-int iso-2022-int-* iso-2022-int-2/);

=item iso-2022-int

ISO/IEC 2022 based 7-bit encoding using G1 and locking-shift for
KS X 1001 and 96-charset.

See draft-ohta-text-encoding (expired Internet Drafts)
for more information.
(Alias: iso-2022-int-*, iso-2022-int-2)

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
  $C->{GR} = undef;
  $C->{C1} = $Encode::Charset::CHARSET{C1}->{'~'};
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'~'};
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
  
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 7;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};
  $C->{option}->{designate_to}->{G94}->{'default'} = 0;
  $C->{option}->{designate_to}->{G96}->{'default'} = 1;
  $C->{option}->{designate_to}->{G94n}->{'default'} = 0;
  $C->{option}->{designate_to}->{G94n}->{'C'} = 1;	## KS X 1001
  $C->{option}->{designate_to}->{G96n}->{'default'} = 1;
  $C;
}

package Encode::ISO2022::SevenBit::iso_2022_kr;
our $VERSION = $Encode::ISO2022::SevenBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-kr korean-iso-7bit csiso2022kr cp50225 kr2022 korean-mail/);

=item iso-2022-kr

An ISO/IEC 2022 based 7-bit encoding for Korean,
defined by RFC 1557.
(Alias: korean-iso-7bit, csiso2022kr, cp50225, kr2022, korean-mail)

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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ksx1001_1992_to_ucs)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ksx1001_1992_to_ucs)], %tblopt) if $tbl;
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
  
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'C'};	## KS X 1001
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(ksx1001_1992_to_ucs)], %tblopt) if $tbl;
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
  $C->{option}->{designate_to}->{G94n}->{'C'} = 1;	## KS X 1001
  $C;
}

package Encode::ISO2022::SevenBit::iso_2022_int_1;
our $VERSION = $Encode::ISO2022::SevenBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-int-1 /);

=item iso-2022-int-1

An ISO/IEC 2022 based 7-bit multilingual encoding,
defined by draft-ohta-text-encoding.

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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_gb2312_1980 ucs_to_ksx1001_1992 ucs_to_isoiec8859_1 ucs_to_isoiec8859_7 ucs_to_jisx0212_1990 ucs_to_jisx0208_1978 ucs_to_jisx0201_latin)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_gb2312_1980 ucs_to_ksx1001_1992 ucs_to_isoiec8859_1 ucs_to_isoiec8859_7 ucs_to_jisx0212_1990 ucs_to_jisx0208_1978 ucs_to_jisx0201_latin)], %tblopt) if $tbl;
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
  
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'C'};	## KS X 1001
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(jisx0208_1983_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs gb2312_1980_to_ucs ksx1001_1992_to_ucs isoiec8859_7_to_ucs)], %tblopt) if $tbl;
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
  $C->{option}->{designate_to}->{G94}->{'J'} = 0;	## JIS X 0201 Latin
  $C->{option}->{designate_to}->{G94n}->{'@'} = 0;	## JIS X 0208-1978
  $C->{option}->{designate_to}->{G94n}->{'A'} = 0;	## GB 2312-80
  $C->{option}->{designate_to}->{G94n}->{'B'} = 0;	## JIS X 0208-1983
  $C->{option}->{designate_to}->{G94n}->{'C'} = 1;	## KS X 1001
  $C->{option}->{designate_to}->{G94n}->{'D'} = 0;	## JIS X 0212-1990
  $C->{option}->{designate_to}->{G96}->{'A'} = 1;	## ISO/IEC 8859-1 GR
  $C->{option}->{designate_to}->{G96}->{'F'} = 0;	## ISO/IEC 8859-7 GR
  $C;
}

package Encode::ISO2022::SevenBit::iso_2022_7bit_lock_ss2;
our $VERSION = $Encode::ISO2022::SevenBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-7bit-lock-ss2 iso-2022-cjk/);

=item iso-2022-7bit-lock-ss2

An ISO/IEC 2022 based 7-bit encoding.  Mixture of ISO-2022-JP,
ISO-2022-KR, ISO-2022-CN.
(Alias: iso-2022-cjk)

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
  $C->{GR} = undef;
  $C->{C1} = $Encode::Charset::CHARSET{C1}->{'~'};
  $C->{G1} = $Encode::Charset::CHARSET{G96}->{'~'};
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
  
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'C'};
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  eval q(use Encode::Charset::Private q(:gb)) or die $@;
  eval q(use Encode::Charset::Private q(:cns)) or die $@;
  eval q(use Encode::Charset::Private q(:mule)) or die $@;
  $C->{bit} = 7;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};
  $C->{option}->{designate_to}->{C0}->{'default'} = 0;
  $C->{option}->{designate_to}->{C1}->{'default'} = 1;
  $C->{option}->{designate_to}->{G94}->{'default'} = 0;
  $C->{option}->{designate_to}->{G94n}->{'default'} = 0;
  $C->{option}->{designate_to}->{G94n}->{'A'} = 1;	## GB 2312-80
  $C->{option}->{designate_to}->{G94n}->{'C'} = 1;	## KS X 1001
  $C->{option}->{designate_to}->{G94n}->{'E'} = 1;	## ISO-IR 165
  $C->{option}->{designate_to}->{G94n}->{'G'} = 1;	## CNS 11643 plane 1
  $C->{option}->{designate_to}->{G94n}->{'CSgb12345'} = 1;	## GB 12345-90
  $C->{option}->{designate_to}->{G96}->{'default'} = 2;
  $C->{option}->{designate_to}->{G96n}->{'default'} = 2;
  $C->{option}->{designate_to}->{G94n}->{'CSgb7589'} = 2;	## GB 7589-87
  $C->{option}->{designate_to}->{G94n}->{'CSgb13131'} = 2;	## GB 13131-91
  $C->{option}->{designate_to}->{G94n}->{'H'} = 2;	## CNS 11643 plane 2
  $C->{option}->{designate_to}->{G94n}->{'CSgb7590'} = 3;	## GB 7590-87
  $C->{option}->{designate_to}->{G94n}->{'CSgb13132'} = 3;	## GB 13131-91
  $C->{option}->{designate_to}->{G94n}->{'I'} = 3;	## CNS 11643 plane 3
  $C->{option}->{designate_to}->{G94n}->{'J'} = 3;	## CNS 11643 plane 4
  $C->{option}->{designate_to}->{G94n}->{'K'} = 3;	## CNS 11643 plane 5
  $C->{option}->{designate_to}->{G94n}->{'L'} = 3;	## CNS 11643 plane 6
  $C->{option}->{designate_to}->{G94n}->{'M'} = 3;	## CNS 11643 plane 7
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_8'} = 3;	## CNS 11643 plane 8
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_9'} = 3;	## CNS 11643 plane 9
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_10'} = 3;	## CNS 11643 plane 10
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_11'} = 3;	## CNS 11643 plane 11
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_12'} = 3;	## CNS 11643 plane 12
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_13'} = 3;	## CNS 11643 plane 13
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_14'} = 3;	## CNS 11643 plane 14
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_15'} = 3;	## CNS 11643 plane 15
  $C->{option}->{designate_to}->{coding_system}->{'default'} = 0;
  $C;
}

package Encode::ISO2022::SevenBit::iso_2022_cn;
our $VERSION = $Encode::ISO2022::SevenBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-cn chinese-iso-7bit  iso2022cn-gb/);

=item iso-2022-cn

An ISO/IEC 2022 based 7-bit encoding for Chinese,
defined by RFC 1922.

This coding system prefers GB 2312-80 (Some people
names this as C<iso2022cn-gb>.) when encoding, because
Taiwan people mainly use C<Big5>, not CNS 11643.
CNS 11643-preferred version is named as C<iso2022cn-cns>.
(Alias: chinese-iso-7bit, iso2022cn-gb)

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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_gb2312_1980 ucs_to_cns11643_1 ucs_to_cns11643_2)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_gb2312_1980 ucs_to_cns11643_1 ucs_to_cns11643_2)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(gb2312_1980_to_ucs cns11643_1_to_ucs cns11643_2_to_ucs)], %tblopt) if $tbl;
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
  $C->{option}->{designate_to}->{G94n}->{'A'} = 1;	## GB 2312-80
  $C->{option}->{designate_to}->{G94n}->{'G'} = 1;	## CNS 11643 plane 1
  $C->{option}->{designate_to}->{G94n}->{'H'} = 2;	## CNS 11643 plane 2
  $C;
}

package Encode::ISO2022::SevenBit::iso2022cn_cns;
our $VERSION = $Encode::ISO2022::SevenBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso2022cn-cns /);

=item iso2022cn-cns

An ISO/IEC 2022 based 7-bit encoding for Chinese,
defined by RFC 1922.

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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_cns11643_1 ucs_to_cns11643_2 ucs_to_gb2312_1980)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_cns11643_1 ucs_to_cns11643_2 ucs_to_gb2312_1980)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(cns11643_1_to_ucs cns11643_2_to_ucs gb2312_1980_to_ucs)], %tblopt) if $tbl;
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
  $C->{option}->{designate_to}->{G94n}->{'A'} = 1;	## GB 2312-80
  $C->{option}->{designate_to}->{G94n}->{'G'} = 1;	## CNS 11643 plane 1
  $C->{option}->{designate_to}->{G94n}->{'H'} = 2;	## CNS 11643 plane 2
  $C;
}

package Encode::ISO2022::SevenBit::iso_2022_cn_ext;
our $VERSION = $Encode::ISO2022::SevenBit::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-cn-ext /);

=item iso-2022-cn-ext

An ISO/IEC 2022 based 7-bit encoding for Chinese,
defined by RFC 1922.

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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_gb2312_1980 ucs_to_iso_ir_165 ucs_to_cns11643_1 ucs_to_cns11643_2 ucs_to_cns11643_3 ucs_to_cns11643_4 ucs_to_cns11643_5 ucs_to_cns11643_6 ucs_to_cns11643_7)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_gb2312_1980 ucs_to_iso_ir_165 ucs_to_cns11643_1 ucs_to_cns11643_2 ucs_to_cns11643_3 ucs_to_cns11643_4 ucs_to_cns11643_5 ucs_to_cns11643_6 ucs_to_cns11643_7)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(gb2312_1980_to_ucs iso_ir_165_to_ucs cns11643_1_to_ucs cns11643_2_to_ucs cns11643_3_to_ucs cns11643_4_to_ucs cns11643_5_to_ucs cns11643_6_to_ucs cns11643_7_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  eval q(use Encode::Charset::Private q(:gb)) or die $@;
  eval q(use Encode::Charset::Private q(:cns)) or die $@;
  $C->{bit} = 7;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{'A'} = 1;	## GB 2312-80
  $C->{option}->{designate_to}->{G94n}->{'E'} = 1;	## ISO-IR 165
  $C->{option}->{designate_to}->{G94n}->{'G'} = 1;	## CNS 11643 plane 1
  $C->{option}->{designate_to}->{G94n}->{'CSgb12345'} = 1;	## GB 12345-90
  $C->{option}->{designate_to}->{G94n}->{'CSgb7589'} = 2;	## GB 7589-87
  $C->{option}->{designate_to}->{G94n}->{'CSgb13131'} = 2;	## GB 13131-91
  $C->{option}->{designate_to}->{G94n}->{'H'} = 2;	## CNS 11643 plane 2
  $C->{option}->{designate_to}->{G94n}->{'CSgb7590'} = 3;	## GB 7590-87
  $C->{option}->{designate_to}->{G94n}->{'CSgb13132'} = 3;	## GB 13131-91
  $C->{option}->{designate_to}->{G94n}->{'I'} = 3;	## CNS 11643 plane 3
  $C->{option}->{designate_to}->{G94n}->{'J'} = 3;	## CNS 11643 plane 4
  $C->{option}->{designate_to}->{G94n}->{'K'} = 3;	## CNS 11643 plane 5
  $C->{option}->{designate_to}->{G94n}->{'L'} = 3;	## CNS 11643 plane 6
  $C->{option}->{designate_to}->{G94n}->{'M'} = 3;	## CNS 11643 plane 7
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_8'} = 3;	## CNS 11643 plane 8
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_9'} = 3;	## CNS 11643 plane 9
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_10'} = 3;	## CNS 11643 plane 10
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_11'} = 3;	## CNS 11643 plane 11
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_12'} = 3;	## CNS 11643 plane 12
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_13'} = 3;	## CNS 11643 plane 13
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_14'} = 3;	## CNS 11643 plane 14
  $C->{option}->{designate_to}->{G94n}->{'CScns11643_15'} = 3;	## CNS 11643 plane 15
  $C;
}

=back

=cut


=head1 SEE ALSO

L<Encode::ISO2022::JUNET>, L<Encode::ISO2022::JUNETCompatible>

=head1 LICENSE

Copyright 2010 Wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1;
