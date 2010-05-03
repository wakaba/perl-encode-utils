## This file is auto-generated (at 2010-05-03T06:14:11Z).
## Do not edit by hand!

=head1 NAME

Encode::SJIS::JISCompatible --- The Encode module for shift JIS compatible coding systems


=cut

package Encode::SJIS::JISCompatible;
use 5.7.3;
use strict;
our $VERSION = q(2010.0503);

=head1 ENCODINGS

=over 8

=cut


package Encode::SJIS::JISCompatible::shift_jis_1997_fullwidth;
our $VERSION = $Encode::SJIS::JISCompatible::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/shift-jis-1997-fullwidth /);

=item shift-jis-1997-fullwidth

Shift coded representation defined by JIS X 0208:1997 Appendix 1,
with "compatible" mapping table as defined in JIS X 0208:1997.

This coding system is the "compatible" version of C<shift-jis-1997>
defined in L<Encode::SJIS::JIS>.

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0208_1997_latin ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0208_1997_latin ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0201_latin_to_ucs jisx0208_1997_latin_to_ucs jisx0201_katakana_hw_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object_sjis;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'J'};	## JIS X 0201:1997 Graphic character set for Latin letters
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201:1997 Graphic character set for Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{'~'};	## undefined
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B', revision => '@'}];
  $C;
}

package Encode::SJIS::JISCompatible::shift_jis_1997_ascii_fullwidth;
our $VERSION = $Encode::SJIS::JISCompatible::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/shift-jis-1997-ascii-fullwidth /);

=item shift-jis-1997-ascii-fullwidth

Same as shift-jis-1997-fullwidth but ASCII (ISO/IEC 646 IRV)
instead of JIS X 0201:1997 Latin character set.

Note that this coding system DOES NOT comform to
JIS X 0208:1997 Appendix 1.

This coding system is the "compatible" version of C<shift-jis-1997-ascii>
defined in L<Encode::SJIS::JIS>.

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1997_irv ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1997_irv ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0208_1997_irv_to_ucs jisx0201_katakana_hw_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object_sjis;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ISO/IEC 646:1991 IRV
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201:1997 Graphic character set for Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{'~'};	## undefined
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'B', revision => '@'}];
  $C;
}

package Encode::SJIS::JISCompatible::shift_jisx0213_fullwidth;
our $VERSION = $Encode::SJIS::JISCompatible::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/shift_jisx0213-fullwidth /);

=item shift_jisx0213-fullwidth

Shift_JISX0213 coded representation, defined by
JIS X 0213:2000 Appendix 1 (implemention level 4),
with the "compatible" mapping defined by JIS X 0213:2000.

This coding system is the "compatible" version of C<shift_jisx0213>
defined in L<Encode::SJIS::JIS>.

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0213_2000_1_latin ucs_to_jisx0213_2000_2 ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0213_2000_1_latin ucs_to_jisx0213_2000_2 ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0201_latin_to_ucs jisx0213_2000_1_latin_to_ucs jisx0213_2000_2_to_ucs jisx0201_katakana_hw_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object_sjis;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'J'};	## JIS X 0201:1997 Graphic character set for Latin letters
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'O'};	## JIS X 0213:2000 plane 1
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201:1997 Graphic character set for Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{'P'};	## JIS X 0213:2000 plane 2
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C;
}

package Encode::SJIS::JISCompatible::shift_jisx0213_ascii_fullwidth;
our $VERSION = $Encode::SJIS::JISCompatible::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/shift_jisx0213-ascii-fullwidth /);

=item shift_jisx0213-ascii-fullwidth

Same as Shift_JISX0213-fullwidth but using ASCII (ISO/IEC 646 IRV)
instead of JIS X 0201:1997 Latin character set.

Note that this coding system does NOT comform to
JIS X 0213:2000 Appendix 1.

This coding system is the "compatible" version of C<shift_jisx0213-ascii>
defined in L<Encode::SJIS::JIS>.

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1_irv ucs_to_jisx0213_2000_2 ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1_irv ucs_to_jisx0213_2000_2 ucs_to_jisx0201_katakana_hw)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0213_2000_1_irv_to_ucs jisx0213_2000_2_to_ucs jisx0201_katakana_hw_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object_sjis;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ISO/IEC 646:1991 IRV
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'O'};	## JIS X 0213:2000 plane 1
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{'I'};	## JIS X 0201:1997 Graphic character set for Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{'P'};	## JIS X 0213:2000 plane 2
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C;
}

=back

=cut


=head1 SEE ALSO

JIS X 0201:1997, "7-bit and 8-bit coded character
set for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 1997.

JIS X 0208:1997, "7-bit and 8-bit double byte coded Kanji
set for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 1997.

JIS X 0213:2000, "7-bit and 8-bit double byte coded extended Kanji
sets for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 2000.

L<Encode::SJIS>, L<Encode::SJIS::JIS>

L<Encode::ISO2022::JUNETCompatible>, L<Encode::ISO2022::EUCJACompatible>

=head1 LICENSE

Copyright 2010 Nanashi-san <nanashi-san@nanashi.invalid>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1;
