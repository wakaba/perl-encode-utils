## This file is auto-generated (at 2010-05-03T06:14:51Z).
## Do not edit by hand!

=head1 NAME

Encode::ISO2022::Pictogram --- ISO/IEC 2022-like coding systems with pictogram character sets


=cut

package Encode::ISO2022::Pictogram;
use 5.7.3;
use strict;
our $VERSION = q(2010.0503);

=head1 ENCODINGS

=over 8

=cut


package Encode::ISO2022::Pictogram::jphone_iso_2022_jp;
our $VERSION = $Encode::ISO2022::Pictogram::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/jphone-iso-2022-jp jphone-iso2022-jp/);

=item jphone-iso-2022-jp

ISO-2022-JP for J-SKY defined by [JGUIDE].

Note that this coding system does NOT comform to ISO/ISO 2022 NOR to RFC 1468.
(Alias: jphone-iso2022-jp)

=cut

sub encode ($$;$) {
  my ($obj, $s, $chk) = @_;
  my %s;
  require Encode::SJIS;
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
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{'B'} = 0;	## ASCII + YEN SIGN
  $C->{option}->{designate_to}->{G94n}->{'B'} = 0;	## JIS X 0208:1997
  $C->{option}->{designate_to}->{G94n}->{'B@'} = 0;	## JIS X 0208:1997
  $C->{option}->{use_revision} = 0;
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B', revision => '@'}];
  $C->{option}->{fallback_from_ucs_2} = $C->{option}->{fallback_from_ucs};
  $C->{option}->{fallback_from_ucs} = \&Encode::SJIS::_internal_to_page;
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii_yen ucs_to_jisx0208_1997_yen ucs_to_jisx0208_to_katakana_hw ucs_to_jphone)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii_yen ucs_to_jisx0208_1997_yen ucs_to_jisx0208_to_katakana_hw ucs_to_jphone)], %tblopt) if $tbl;
  ($s, %s) = Encode::ISO2022::internal_to_iso2022 ($s, $C);
  if ($s{die}) {
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  }
  return $s;
}

sub decode ($$;$) {
  my ($obj, $s, $chk) = @_;
  require Encode::SJIS;
  require Encode::ISO2022;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_decode_mapping} ? $obj->{_decode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_decode_mapping_autoload} ? $obj->{_decode_mapping_autoload} : 1);
  $C->{option}->{final_to_set}->{G94n}->{B} = 'B@';
  $s = Encode::SJIS::page_to_internal ($C, $s);
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(ascii_yen_to_ucs jisx0208_1997_to_ucs jphone_to_ucs jisx0208_1978_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::SJIS;
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  eval q(require Encode::Charset::Pictogram;
  eval q(Encode::Charset::Pictogram->import (qw(:all)));
  Encode::Charset::Pictogram::designate ($C));
  eval q(use Encode::SJIS) unless $Encode::SJIS::VERSION;
  $C->{bit} = 7;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};
  $C;
}

package Encode::ISO2022::Pictogram::jphone_euc_jp;
our $VERSION = $Encode::ISO2022::Pictogram::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/jphone-euc-jp /);

=item jphone-euc-jp

EUC-JP for J-SKY defined by [JGUIDE].

Note that this coding system does NOT comform to ISO/ISO 2022, Japanese EUC
specification NOR JIS X 0208:1997.

=cut

sub encode ($$;$) {
  my ($obj, $s, $chk) = @_;
  my %s;
  require Encode::SJIS;
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
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B', revision => '@'}];
  $C->{option}->{fallback_from_ucs_2} = $C->{option}->{fallback_from_ucs};
  $C->{option}->{fallback_from_ucs} = \&Encode::SJIS::_internal_to_page;
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii_yen ucs_to_jisx0208_1997_yen ucs_to_jisx0201_katakana_hw ucs_to_jphone)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii_yen ucs_to_jisx0208_1997_yen ucs_to_jisx0201_katakana_hw ucs_to_jphone)], %tblopt) if $tbl;
  ($s, %s) = Encode::ISO2022::internal_to_iso2022 ($s, $C);
  if ($s{die}) {
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  }
  return $s;
}

sub decode ($$;$) {
  my ($obj, $s, $chk) = @_;
  require Encode::SJIS;
  require Encode::ISO2022;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_decode_mapping} ? $obj->{_decode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_decode_mapping_autoload} ? $obj->{_decode_mapping_autoload} : 1);
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{'D'};	## JIS X 0212-1990
  $s = Encode::SJIS::page_to_internal ($C, $s);
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(ascii_yen_to_ucs jisx0208_1997_to_ucs jisx0201_katakana_hw_to_ucs jphone_to_ucs jisx0212_1990_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::SJIS;
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  eval q(require Encode::Charset::Pictogram;
  eval q(Encode::Charset::Pictogram->import (qw(:all)));
  Encode::Charset::Pictogram::designate ($C));
  eval q(use Encode::SJIS) unless $Encode::SJIS::VERSION;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ASCII + YEN SIGN
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201 Katakana
  $C;
}

=back

=cut


=head1 SEE ALSO

L<Encode::SJIS::Pictogram>, L<Encode::JIS::JUNET>, L<Encode::JIS::EUCJA>

=head1 LICENSE

Copyright 2010 Wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1;
