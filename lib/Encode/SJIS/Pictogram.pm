## This file is auto-generated (at 2010-05-03T06:14:11Z).
## Do not edit by hand!

=head1 NAME

Encode::SJIS::Pictogram --- The Encode module for shift JIS coding systems


=cut

package Encode::SJIS::Pictogram;
use 5.7.3;
use strict;
our $VERSION = q(2010.0503);

=head1 ENCODINGS

=over 8

=cut


package Encode::SJIS::Pictogram::sjis_imode;
our $VERSION = $Encode::SJIS::Pictogram::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/sjis-imode x-sjis-imode/);

=item sjis-imode

Shift JIS with i-mode extended pictographs
(Alias: x-sjis-imode)

=cut

sub encode ($$;$) {
  my ($obj, $s, $chk) = @_;
  my %s;
  require Encode::SJIS;
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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0208_1997_latin ucs_to_jisx0201_katakana_hw ucs_to_imode)], %tblopt) if $tbl;
  ($s, %s) = Encode::SJIS::internal_to_sjis ($s, $C);
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
  require Encode::SJIS;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_encode_mapping} ? $obj->{_encode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_encode_mapping_autoload} ? $obj->{_encode_mapping_autoload} : 1);
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0208_1997_latin ucs_to_jisx0201_katakana_hw ucs_to_imode)], %tblopt) if $tbl;
  ($s, %s) = Encode::SJIS::internal_to_sjis ($s, $C);
  if ($s{die}) {
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  }
  return $s;
}

sub decode ($$;$) {
  my ($obj, $s, $chk) = @_;
  require Encode::SJIS;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_decode_mapping} ? $obj->{_decode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_decode_mapping_autoload} ? $obj->{_decode_mapping_autoload} : 1);
  
  $s = Encode::SJIS::sjis_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(jisx0201_latin_to_ucs jisx0208_1997_latin_to_ucs jisx0201_katakana_hw_to_ucs imode_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object_sjis;
  eval q(require Encode::Charset::Pictogram;
  eval q(Encode::Charset::Pictogram->import (qw(:all)));
  Encode::Charset::Pictogram::designate ($C));
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'J'};	## JIS X 0201:1997 Graphic character set for Latin letters
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201:1997 Graphic character set for Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G256n}->{'CSimode_g3'};	## i-mode pictograph set
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B', revision => '@'}];
  $C;
}

package Encode::SJIS::Pictogram::sjis_lmode;
our $VERSION = $Encode::SJIS::Pictogram::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/sjis-lmode x-sjis-lmode/);

=item sjis-lmode

Shift JIS with L-mode extended pictographs
(Alias: x-sjis-lmode)

=cut

sub encode ($$;$) {
  my ($obj, $s, $chk) = @_;
  my %s;
  require Encode::SJIS;
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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0208_1997_latin ucs_to_jisx0201_katakana_hw ucs_to_lmode)], %tblopt) if $tbl;
  ($s, %s) = Encode::SJIS::internal_to_sjis ($s, $C);
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
  require Encode::SJIS;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_encode_mapping} ? $obj->{_encode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_encode_mapping_autoload} ? $obj->{_encode_mapping_autoload} : 1);
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0208_1997_latin ucs_to_jisx0201_katakana_hw ucs_to_lmode)], %tblopt) if $tbl;
  ($s, %s) = Encode::SJIS::internal_to_sjis ($s, $C);
  if ($s{die}) {
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  }
  return $s;
}

sub decode ($$;$) {
  my ($obj, $s, $chk) = @_;
  require Encode::SJIS;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_decode_mapping} ? $obj->{_decode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_decode_mapping_autoload} ? $obj->{_decode_mapping_autoload} : 1);
  
  $s = Encode::SJIS::sjis_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(jisx0201_latin_to_ucs jisx0208_1997_latin_to_ucs jisx0201_katakana_hw_to_ucs lmode_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object_sjis;
  eval q(require Encode::Charset::Pictogram;
  eval q(Encode::Charset::Pictogram->import (qw(:all)));
  Encode::Charset::Pictogram::designate ($C));
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'J'};	## JIS X 0201:1997 Graphic character set for Latin letters
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201:1997 Graphic character set for Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G256n}->{'CSlmode_g3'};	## L-mode pictograph set
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B', revision => '@'}];
  $C;
}

package Encode::SJIS::Pictogram::sjis_doti;
our $VERSION = $Encode::SJIS::Pictogram::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/sjis-doti x-sjis-doti/);

=item sjis-doti

Shift JIS with dot-i extended pictographs
(Alias: x-sjis-doti)

=cut

sub encode ($$;$) {
  my ($obj, $s, $chk) = @_;
  my %s;
  require Encode::SJIS;
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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0208_1997_latin ucs_to_jisx0201_katakana_hw ucs_to_doti)], %tblopt) if $tbl;
  ($s, %s) = Encode::SJIS::internal_to_sjis ($s, $C);
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
  require Encode::SJIS;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_encode_mapping} ? $obj->{_encode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_encode_mapping_autoload} ? $obj->{_encode_mapping_autoload} : 1);
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0208_1997_latin ucs_to_jisx0201_katakana_hw ucs_to_doti)], %tblopt) if $tbl;
  ($s, %s) = Encode::SJIS::internal_to_sjis ($s, $C);
  if ($s{die}) {
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  }
  return $s;
}

sub decode ($$;$) {
  my ($obj, $s, $chk) = @_;
  require Encode::SJIS;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_decode_mapping} ? $obj->{_decode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_decode_mapping_autoload} ? $obj->{_decode_mapping_autoload} : 1);
  
  $s = Encode::SJIS::sjis_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(jisx0201_latin_to_ucs jisx0208_1997_latin_to_ucs jisx0201_katakana_hw_to_ucs doti_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object_sjis;
  eval q(require Encode::Charset::Pictogram;
  eval q(Encode::Charset::Pictogram->import (qw(:all)));
  Encode::Charset::Pictogram::designate ($C));
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'J'};	## JIS X 0201:1997 Graphic character set for Latin letters
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201:1997 Graphic character set for Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G256n}->{'CSdoti_g3'};	## dot-i pictograph set
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B', revision => '@'}];
  $C;
}

package Encode::SJIS::Pictogram::sjis_jphone;
our $VERSION = $Encode::SJIS::Pictogram::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/sjis-jphone x-sjis-jphone sjis-jsky x-sjis-jsky/);

=item sjis-jphone

Shift JIS with JPHONE extended pictographs

RESTRICTION: In current implemention, pictograms can't be outputed in
shortest form.  For example, C<0x1B 0x24 0x45 0x41 0x0F 0x1B 0x24 0x45 0x42 0x0F>
can be represented as C<0x1B 0x24 0x45 0x41 0x42 0x0F> but this encoder
always output former style.  (Although it is lengthy, it does not mean
invalid and decoder supprots both form.)
(Alias: x-sjis-jphone, sjis-jsky, x-sjis-jsky)

=cut

sub encode ($$;$) {
  my ($obj, $s, $chk) = @_;
  my %s;
  require Encode::SJIS;
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
  $C->{option}->{fallback_from_ucs_2} = $C->{option}->{fallback_from_ucs};
  $C->{option}->{fallback_from_ucs} = \&Encode::SJIS::_internal_to_page;
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii_yen ucs_to_jisx0208_1997_yen ucs_to_jisx0201_katakana_hw ucs_to_jphone)], %tblopt) if $tbl;
  ($s, %s) = Encode::SJIS::internal_to_sjis ($s, $C);
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
  require Encode::SJIS;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_encode_mapping} ? $obj->{_encode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_encode_mapping_autoload} ? $obj->{_encode_mapping_autoload} : 1);
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii_yen ucs_to_jisx0208_1997_yen ucs_to_jisx0201_katakana_hw ucs_to_jphone)], %tblopt) if $tbl;
  ($s, %s) = Encode::SJIS::internal_to_sjis ($s, $C);
  if ($s{die}) {
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  }
  return $s;
}

sub decode ($$;$) {
  my ($obj, $s, $chk) = @_;
  require Encode::SJIS;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_decode_mapping} ? $obj->{_decode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_decode_mapping_autoload} ? $obj->{_decode_mapping_autoload} : 1);
  
  $s = Encode::SJIS::page_to_internal ($C, $s);
  $s = Encode::SJIS::sjis_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(ascii_yen_to_ucs jisx0208_1997_yen_to_ucs jisx0201_katakana_hw_to_ucs jphone_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object_sjis;
  eval q(require Encode::Charset::Pictogram;
  eval q(Encode::Charset::Pictogram->import (qw(:all)));
  Encode::Charset::Pictogram::designate ($C));
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ASCII + YEN SIGN
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201:1997 Graphic character set for Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{'~'};	## undef
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B', revision => '@'}];
  $C;
}

=back

=cut


=head1 SEE ALSO

[ASTEL] "Astel Pictograms",
<http://www.yozan.co.jp/asteltokyo/doti/siyou/emoji.htm>.

[JGUIDE] "HTML Contents for J-Sky Service Development Guide", J-Phone Co., LTD,
2002-01-15, <http://www.dp.j-phone.com/file/JSkyHTMLGuide_20020115.pdf>.
See also <http://www.dp.j-phone.com/jsky/tech.html>.
(Note that J-PHONE and J-SKY is the trademarks or registered trademarks
of J-PHONE Corporation.)

[LSPEC] "'L-mode' Technical Specification for Contents Providers, Version 2.2",
Nippon Telegraph and Telephone East Corporation,
Nippon Telegraph and Telephone West Corportation, 2002-11.
Available from <http://www.ntt-east.co.jp/Lmode/06_contents/02_tsukuri.html>.
(Note that L-mode is the trade mark of NTT EAST and WEST.)

SuikaWiki:"Extention to Shift JIS on portable phones"
<http://suika.fam.cx/~wakaba/-temp/wiki/wiki?%B7%C8%C2%D3%C5%C5%CF%C3%A4%CE%A5%B7%A5%D5%A5%C8JIS%B3%C8%C4%A5>

L<Encode::SJIS>

=head1 LICENSE

Copyright 2010 Nanashi-san <nanashi-san@nanashi.invalid>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1;
