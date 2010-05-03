## This file is auto-generated (at 2010-05-03T06:14:11Z).
## Do not edit by hand!

=head1 NAME

Encode::SJIS::JIS --- The Encode module for shift JIS coding systems


=cut

package Encode::SJIS::JIS;
use 5.7.3;
use strict;
our $VERSION = q(2010.0503);

=head1 ENCODINGS

=over 8

=cut


=item sjis

"Shift JIS" coding system.

Since this name is ambiguous (it can now refer all or any
of shift JIS coding system family), this name should not
be used to address specific coding system.  In this module,
this is considered as an alias name to the shift JIS with
latest official definition, currently of JIS X 0213:2000
Appendix 1 (with implemention level 4).

Note that the name "Shift_JIS" is not associated with
this name, because IANA registry [IANAREG] assignes
it to a shift JIS defined by JIS X 0208:1997.
(Alias: s-jis, x-sjis, x_sjis, x-sjis-jp, shift-jis, shiftjis, shift.jis, x-shiftjis, x-shift-jis, x-shift_jis)

This name is an alias of shift_jisx0213.

=cut


=item sjis-ascii

Same as sjis but ASCII (ISO/IEC 646 IRV) instead of
JIS X 0201 Roman (or Latin) set.

In spite of the history of shift JIS, ASCII is sometimes
used instead of JIS X 0201 Roman set, because of compatibility
with ASCII world.
(Alias: shift-jis-ascii)

This name is an alias of shift_jisx0213-ascii.

=cut


package Encode::SJIS::JIS::shift_jis_1997;
our $VERSION = $Encode::SJIS::JIS::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/shift-jis-1997 shift_jis csshiftjis japanese-shift-jis/);

=item shift-jis-1997

Shift coded representation defined by JIS X 0208:1997 Appendix 1.

Note that although IANA registry [IANAREG] assignes the name "MS_Kanji"
as an alias of "Shift_JIS", in this module this name is not aliased
for the shift-coded representation of JIS X 0208, since it is more
apropreate to associate this name with
Microsoft-defined-Shift-JIS.  (Microsoft's shift JIS is a superset of
"shifted" form of JIS X 0208-1990, so it causes no problem to decode,
despite MS Shift JIS does not comform to JIS X 0208:1997.)
(Alias: shift_jis, csshiftjis, japanese-shift-jis)

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0208_1997 ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0208_1997 ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0201_latin_to_ucs jisx0208_1997_to_ucs jisx0201_katakana_to_ucs)], %tblopt) if $tbl;
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

package Encode::SJIS::JIS::shift_jis_1997_ascii;
our $VERSION = $Encode::SJIS::JIS::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/shift-jis-1997-ascii shift_jis-ascii/);

=item shift-jis-1997-ascii

Same as shift-jis-1997 but ASCII (ISO/IEC 646 IRV)
instead of JIS X 0201:1997 Latin character set.

Note that this coding system does NOT comform to
JIS X 0208:1997 Appendix 1.
(Alias: shift_jis-ascii)

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1997 ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0208_1997 ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0208_1997_to_ucs jisx0201_katakana_to_ucs)], %tblopt) if $tbl;
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

package Encode::SJIS::JIS::shift_jisx0213;
our $VERSION = $Encode::SJIS::JIS::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/shift_jisx0213 japanese-shift-jisx0213 shift-jisx0213 x-shift_jisx0213 shift-jis-3 shift-jis-2000 sjisx0213/);

=item shift_jisx0213

Shift_JISX0213 coded representation, defined by
JIS X 0213:2000 Appendix 1 (implemention level 4).
(Alias: japanese-shift-jisx0213, shift-jisx0213, x-shift_jisx0213, shift-jis-3, shift-jis-2000, sjisx0213)

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2 ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2 ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0201_latin_to_ucs jisx0213_2000_1_to_ucs jisx0213_2000_2_to_ucs jisx0201_katakana_to_ucs)], %tblopt) if $tbl;
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

package Encode::SJIS::JIS::shift_jisx0213_ascii;
our $VERSION = $Encode::SJIS::JIS::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/shift_jisx0213-ascii shift-jis-2000-ascii/);

=item shift_jisx0213-ascii

Same as Shift_JISX0213 but using ASCII (ISO/IEC 646 IRV)
instead of JIS X 0201:1997 Latin character set.

Note that this coding system does NOT comform to
JIS X 0213:2000 Appendix 1.
(Alias: shift-jis-2000-ascii)

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2 ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2 ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0213_2000_1_to_ucs jisx0213_2000_2_to_ucs jisx0201_katakana_to_ucs)], %tblopt) if $tbl;
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

package Encode::SJIS::JIS::shift_jisx0213_plane1;
our $VERSION = $Encode::SJIS::JIS::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/shift_jisx0213-plane1 /);

=item shift_jisx0213-plane1

Shift_JISX0213-plane1 coded representation defined by JIS X 0213:2000
Appendix 1 (i.e. implemention level 3).

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
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0213_2000_1 ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(ucs_to_jisx0201_latin ucs_to_jisx0213_2000_1 ucs_to_jisx0201_katakana)], %tblopt) if $tbl;
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
  $s = Encode::Table::convert ($s, [qw(jisx0201_latin_to_ucs jisx0213_2000_1_to_ucs jisx0201_katakana_to_ucs)], %tblopt) if $tbl;
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
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{'~'};	## undefined
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C;
}
Encode::Alias::define_alias ('sjis' => 'shift_jisx0213');
Encode::Alias::define_alias ('s-jis' => 'shift_jisx0213');
Encode::Alias::define_alias ('x-sjis' => 'shift_jisx0213');
Encode::Alias::define_alias ('x_sjis' => 'shift_jisx0213');
Encode::Alias::define_alias ('x-sjis-jp' => 'shift_jisx0213');
Encode::Alias::define_alias ('shift-jis' => 'shift_jisx0213');
Encode::Alias::define_alias ('shiftjis' => 'shift_jisx0213');
Encode::Alias::define_alias ('shift.jis' => 'shift_jisx0213');
Encode::Alias::define_alias ('x-shiftjis' => 'shift_jisx0213');
Encode::Alias::define_alias ('x-shift-jis' => 'shift_jisx0213');
Encode::Alias::define_alias ('x-shift_jis' => 'shift_jisx0213');
Encode::Alias::define_alias ('sjis-ascii' => 'shift_jisx0213-ascii');
Encode::Alias::define_alias ('shift-jis-ascii' => 'shift_jisx0213-ascii');

=back

Shift JISes using alternative character names defined
by JIS X 0208:1997 or JIS X 0213:2000 (so some characters
are mapped to HALFWIDTH or FULLWIDTH area of UCS) are not
included in this module but in L<Encode::SJIS::JISCompatible>.

Shift JISes with JIS X 0208-1978, -1983, -1990 are not
included in this module since these standards did NOT
define them (but some vendor did implement them as non-standard
encodings).  They are defined in Encode::SJIS::* modules
other than this.

Being ones of Shift JISes defined in *JIS* TR, Shift JIS
variants defined by JIS TR X 0015 "XML Japanese profile"
is not supported by this module, but by other Encode::SJIS::*
modulss.  Shift JISes which is given their names by JIS TR X 0015
are all vendor defined variants of Shift JISes and do NOT part
of formal JIS coded character set standards NOR comform to
those standards.  (It might sound strange that JIS TR defines
names for encodings clealy not comforming to JIS standards.
JIS TR "standalization" process is much looser than JIS standard's.)

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

L<Encode::SJIS>



=head1 LICENSE

Copyright 2010 Nanashi-san <nanashi-san@nanashi.invalid>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1;
