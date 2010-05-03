## This file is auto-generated (at 2010-05-03T06:14:51Z).
## Do not edit by hand!

=head1 NAME

Encode::ISO2022::JUNET --- An Encode module of 7-bit ISO/IEC 2022
based coding systems, developed in JUNET


=cut

package Encode::ISO2022::JUNET;
use 5.7.3;
use strict;
our $VERSION = q(2010.0503);

=head1 ENCODINGS

=over 8

=cut


package Encode::ISO2022::JUNET::junet;
our $VERSION = $Encode::ISO2022::JUNET::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/junet iso-2022-7bit iso-2022-7 jis jis7 7bit-jis/);

=item junet

ISO/IEC 2022 based 7-bit encoding using only G0
(Alias: iso-2022-7bit, iso-2022-7, jis, jis7, 7bit-jis)

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
  #=>ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0213_2000_1 ucs_to_gb2312_1980 ucs_to_ksx1001_1992 ucs_to_cns11643_1 ucs_to_jisx0213_2000_2 ucs_to_iso_ir_165 ucs_to_jisx0212_1990 ucs_to_cns11643_2 ucs_to_jisx0208_1978 ucs_to_cns11643_3 ucs_to_jisx0201_latin ucs_to_jisx0201_katakana ucs_to_cns11643_4 ucs_to_cns11643_5 ucs_to_cns11643_6 ucs_to_cns11643_7 ucs_to_kps9566_1997
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
  #=>ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0213_2000_1 ucs_to_gb2312_1980 ucs_to_ksx1001_1992 ucs_to_cns11643_1 ucs_to_jisx0213_2000_2 ucs_to_iso_ir_165 ucs_to_jisx0212_1990 ucs_to_cns11643_2 ucs_to_jisx0208_1978 ucs_to_cns11643_3 ucs_to_jisx0201_latin ucs_to_jisx0201_katakana ucs_to_cns11643_4 ucs_to_cns11643_5 ucs_to_cns11643_6 ucs_to_cns11643_7 ucs_to_kps9566_1997
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
  $C->{option}->{designate_to}->{G94}->{default} = 0;
  $C->{option}->{designate_to}->{G96}->{default} = 0;
  $C->{option}->{designate_to}->{G94n}->{default} = 0;
  $C->{option}->{designate_to}->{G96n}->{default} = 0;
  $C->{option}->{designate_to}->{C0}->{default} = 0;
  $C->{option}->{designate_to}->{C1}->{default} = 0;
  $C->{option}->{designate_to}->{coding_system}->{'default'} = 0;
  $C;
}

package Encode::ISO2022::JUNET::iso_2022_jp;
our $VERSION = $Encode::ISO2022::JUNET::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-jp junet-code japanese-iso-7bit csiso2022jp iso2022jp rfc1468/);

=item iso-2022-jp

ISO/IEC 2022 based 7-bit encoding for Japanese.

This coding system is defined by Junet no tebiki,
RFC 1468, JIS X 0208:1997 Appendix 2 and bis1468
(an expired Internet Draft).
(Alias: junet-code, japanese-iso-7bit, csiso2022jp, iso2022jp, rfc1468)

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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0208_1978 ucs_to_jisx0201_latin)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0208_1978 ucs_to_jisx0201_latin)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0208_1983_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs)], %tblopt) if $tbl;
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

package Encode::ISO2022::JUNET::iso_2022_jp_1978_irv;
our $VERSION = $Encode::ISO2022::JUNET::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-jp-1978-irv japanese-iso-7bit-1978-irv old-jis x-obsoleted-iso-2022-jp jis78/);

=item iso-2022-jp-1978-irv

ISO/IEC 2022 based 7-bit encoding for Japanese,
using JIS X 0208-1978.

This coding system is same as C<iso-2022-jp>,
but this preferrs JIS X 0208-1978 to -1983.
(Alias: japanese-iso-7bit-1978-irv, old-jis, x-obsoleted-iso-2022-jp, jis78)

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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1978 ucs_to_jisx0208_1983 ucs_to_jisx0201_latin)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1978 ucs_to_jisx0208_1983 ucs_to_jisx0201_latin)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0208_1978_to_ucs jisx0208_1983_to_ucs jisx0201_latin_to_ucs)], %tblopt) if $tbl;
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
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => '@'}];
  $C;
}

package Encode::ISO2022::JUNET::less_jis;
our $VERSION = $Encode::ISO2022::JUNET::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/less-jis /);

=item less-jis

ISO/IEC 2022 based 7-bit encoding for Japanese.

For more information, see
<http://www.io.com/~kazushi/less/README.iso.jp> (in Japanese)
or <http://www.io.com/~kazushi/less/README.iso> (In English).

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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0201_latin ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0201_latin ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0208_1983_to_ucs jisx0208_1978_to_ucs jisx0213_2000_1_to_ucs jisx0212_0213_to_ucs jisx0208_1997_to_ucs jisx0201_latin_to_ucs jisx0201_katakana_to_ucs)], %tblopt) if $tbl;
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
  $C->{option}->{designate_to}->{G94}->{'I'} = 0;	## JIS X 0201 Katakana
  $C->{option}->{designate_to}->{G94}->{'J'} = 0;	## JIS X 0201 Roman
  $C->{option}->{designate_to}->{G94n}->{'B'} = 0;	## JIS X 0208-1983
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B'}];
  $C;
}

package Encode::ISO2022::JUNET::iso_2022_jp_1;
our $VERSION = $Encode::ISO2022::JUNET::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-jp-1 iso2022jp-1 iso-2022-jp1/);

=item iso-2022-jp-1

ISO/IEC 2022 based 7-bit encoding for Japanese,
defined by RFC 2237.

You should note that this coding system is not so widely
supported.  C<iso-2022-jp-2>, a superset of this coding
system, is even more widely supported.
(Alias: iso2022jp-1, iso-2022-jp1)

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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0212_1990 ucs_to_jisx0208_1978 ucs_to_jisx0201_latin)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0212_1990 ucs_to_jisx0208_1978 ucs_to_jisx0201_latin)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0208_1983_to_ucs jisx0212_1990_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs)], %tblopt) if $tbl;
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
  $C->{option}->{designate_to}->{G94n}->{'D'} = 0;	## JIS X 0212-1990
  $C->{option}->{use_revision} = 0;
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B'}];
  $C;
}

package Encode::ISO2022::JUNET::iso_2022_jp_3;
our $VERSION = $Encode::ISO2022::JUNET::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-jp-3 x-iso-2022-jp-3 iso2022jp-3 iso-2022-jp3
jisx0213 jis0213/);

=item iso-2022-jp-3

ISO/IEC 2022 based 7-bit encoding for Japanese,
defined by JIS X 0213:2000 Appendix 2.
(Alias: x-iso-2022-jp-3, iso2022jp-3, iso-2022-jp3, jisx0213, jis0213)

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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0213_2000_1_to_ucs jisx0212_0213_to_ucs jisx0208_1983_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs)], %tblopt) if $tbl;
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
  $C->{option}->{designate_to}->{G94n}->{'B'} = 0;	## subset of JIS X 0213:2000 plane 1
  $C->{option}->{designate_to}->{G94n}->{'O'} = 0;	## JIS X 0213:2000 plane 1
  $C->{option}->{designate_to}->{G94n}->{'P'} = 0;	## JIS X 0213:2000 plane 2
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C;
}

package Encode::ISO2022::JUNET::iso_2022_jp_3_strict;
our $VERSION = $Encode::ISO2022::JUNET::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-jp-3-strict /);

=item iso-2022-jp-3-strict

ISO/IEC 2022 based 7-bit encoding for Japanese.

This coding system is a subset of C<iso-2022-jp-3>.
See <http://www.m17n.org/m17n2000_all_but_registration/proceedings/kawabata/jisx0213.html>
for more information.

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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1_esc_24_42 ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1_esc_24_42 ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0213_2000_1_to_ucs jisx0212_0213_to_ucs jisx0208_1983_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs)], %tblopt) if $tbl;
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
  $C->{option}->{designate_to}->{G94n}->{'B'} = 0;	## subset of JIS X 0213:2000 plane 1
  $C->{option}->{designate_to}->{G94n}->{'O'} = 0;	## JIS X 0213:2000 plane 1
  $C->{option}->{designate_to}->{G94n}->{'P'} = 0;	## JIS X 0213:2000 plane 2
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C;
}

package Encode::ISO2022::JUNET::iso_2022_jp_3_compatible;
our $VERSION = $Encode::ISO2022::JUNET::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-jp-3-compatible /);

=item iso-2022-jp-3-compatible

ISO/IEC 2022 based 7-bit encoding for Japanese.

See <http://www.m17n.org/m17n2000_all_but_registration/proceedings/kawabata/jisx0213.html>
for more information.

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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1983 ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0213_2000_1_to_ucs jisx0212_0213_to_ucs jisx0208_1983_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs)], %tblopt) if $tbl;
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
  $C->{option}->{designate_to}->{G94n}->{'B'} = 0;	## subset of JIS X 0213:2000 plane 1
  $C->{option}->{designate_to}->{G94n}->{'O'} = 0;	## JIS X 0213:2000 plane 1
  $C->{option}->{designate_to}->{G94n}->{'P'} = 0;	## JIS X 0213:2000 plane 2
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C;
}

package Encode::ISO2022::JUNET::iso_2022_jp_3_plane1;
our $VERSION = $Encode::ISO2022::JUNET::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022-jp-3-plane1 /);

=item iso-2022-jp-3-plane1

ISO/IEC 2022 based 7-bit encoding for Japanese,
defined by JIS X 0213:2000 Appendix 2.

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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0213_2000_1_to_ucs jisx0212_0213_to_ucs jisx0208_1983_to_ucs jisx0208_1978_to_ucs jisx0201_latin_to_ucs)], %tblopt) if $tbl;
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
  $C->{option}->{designate_to}->{G94n}->{'B'} = 0;	## subset of JIS X 0213:2000 plane 1
  $C->{option}->{designate_to}->{G94n}->{'O'} = 0;	## JIS X 0213:2000 plane 1
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

L<Encode::ISO2022::SevenBit>
(C<iso-2022-jp-2> and C<iso-2022-int> are defined in
this module.)

=head1 LICENSE

Copyright 2010 Wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1;
