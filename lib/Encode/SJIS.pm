
=head1 NAME

Encode::SJIS --- Shift JIS coding systems encoder and decoder

=head1 ENCODINGS

This module defines only two basic version of shift JIS.
Other variants are defined in Encode::SJIS::* modules.

=over 4

=cut

package Encode::SJIS;
use 5.7.3;
use strict;
our $VERSION=do{my @r=(q$Revision: 1.1 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
require Encode::Charset;

### --- Perl Encode module common functions

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  if (!defined $obj->{_encode_mapping} || $obj->{_encode_mapping}) {
    require Encode::Table;
    $str = Encode::Table::convert ($str, $obj->__encode_map,
      -autoload => defined $obj->{_encode_mapping_autoload} ?
                   $obj->{_encode_mapping_autoload} : 1);
  }
  $str = &internal_to_sjis ($str, $obj->__2022_encode);
  $str;
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str = &sjis_to_internal ($str, $obj->__2022_decode);
  if (!defined $obj->{_decode_mapping} || $obj->{_decode_mapping}) {
    require Encode::Table;
    $str = Encode::Table::convert ($str, $obj->__decode_map,
      -autoload => defined $obj->{_decode_mapping_autoload} ?
                   $obj->{_decode_mapping_autoload} : 1);
  }
  $str;
}

### --- Encode::SJIS unique functions
*new_object = \&Encode::Charset::new_object_sjis;

sub sjis_to_internal ($$) {
  my ($s, $C) = @_;
  $C ||= &new_object;
  $s =~ s{
     ([\x00-\x7F\xA1-\xDF])
  #   ([\xA1-\xDF])
    |([\x81-\x9F\xE0-\xFC][\x40-\x7E\x80-\xFC])
    |\x1B([\x40-\x5F])
    |([\x80-\xFF])	## Broken or supplemental 1-byte character
  }{
    my ($c7, $c2, $c1, $c8) = ($1, $2, $3, $4);
    if (defined $c7) {
      if ($c7 =~ /([\x21-\x7E])/) {
        chr ($C->{ $C->{GL} }->{ucs} + ord ($1) - 0x21);
      } elsif ($c7 =~ /([\x00-\x1F])/) {
        chr ($C->{ $C->{CL} }->{ucs} + ord ($1));
      } elsif ($C->{GR} && $c7 =~ /([\xA1-\xDF])/) {
        chr ($C->{ $C->{GR} }->{ucs} + ord ($1) - 0xA1);
      } else {	## 0x20, 0x7F
        $C->{Gsmap}->{ $c7 } || $c7;
      }
    } elsif ($c2) {
      if ($c2 =~ /([\x81-\xEF])(.)/) {
        my ($f, $s) = (ord $1, ord $2);
        $f -= $f < 0xA0 ? 0x81 : 0xC1;  $s -= 0x40 + ($s > 0x7F);
        chr ($C->{G1}->{ucs} + $f * 188 + $s);
      } else {	## [\xF0-\xFC].
        my ($f, $s) = unpack ('CC', $c2);
        if ($C->{G3}->{Csjis_kuE}) {
          $f = $s > 0x9E ? $C->{G3}->{Csjis_kuE}->{ $f }:
                           $C->{G3}->{Csjis_kuO}->{ $f };
          $s -= ($s > 0x9E ? 0x9F : $s > 0x7F ? 0x41 : 0x40);
          chr ($C->{G3}->{ucs} + $f * 94 + $s);
        } else {
          $f -= 0xF0; $s -= 0x40 + ($s > 0x7F);
          chr ($C->{G3}->{ucs} + $f * 188 + $s);
        }
      }
    } elsif ($c1) {	## ESC Fe
      chr ($C->{ $C->{ESC_Fe} }->{ucs} + ord ($c1) - 0x40);
    } else {	# $C8
      $C->{Gsmap}->{ $c8 } || $c8;
    }
  }gex;
  $s;
}

sub __clone ($) {
  my $self = shift;
  bless {%$self}, ref $self;
};

use base qw(Encode::Encoding);
__PACKAGE__->Define (qw!shift_jisx0213 japanese-shift-jisx0213
shift-jisx0213 x-shift_jisx0213 shift-jis-3
sjis shift-jis x-sjis x_sjis x-sjis-jp shiftjis x-shiftjis
x-shift-jis shift.jis!);

=item sjis

"Shift JIS" coding system.  (Alias: shift-jis, shiftjis,
shift.jis, x-shiftjis, x-shift-jis, x-sjis, x_sjis,
x-sjis-jp)

Since this name is ambiguous (it can now refer all or any
of shift JIS coding system family), this name should not
be used to address specific coding system.  In this module,
this is considered as an alias name to the shift JIS with
latest official definition, currently of JIS X 0213:2000
Appendix 1 (with implemention level 4).

Note that the name "Shift_JIS" is not associated with
this name, because IANA registry [IANAREG] assignes
it to a shift JIS defined by JIS X 0208:1997.

=item shift_jisx0213

Shift_JISX0213 coded representation, defined by
JIS X 0213:2000 Appendix 1 (implemention level 4).
(Alias: shift-jisx0213, x-shift_jisx0213, japanese-shift-jisx0213 (emacsen),
shift-jis-3 (Yudit))

=cut

sub __2022__common ($) {
  my $C = Encode::SJIS->new_object;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{J};	## JIS X 0201:1997 Latin
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{"\x4F"};	## JIS X 0213:2000 plane 1
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{I};	## JIS X 0201:1997 Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{"\x50"};	## JIS X 0213:2000 plane 2
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C;
}
sub __2022_decode ($) {
  my $C = shift->__2022__common;
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_jisx0201_latin ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2 ucs_to_jisx0201_katakana/];
}
sub __decode_map ($) {
  [qw/jisx0201_latin_to_ucs jisx0213_2000_1_to_ucs jisx0213_2000_2_to_ucs jisx0201_katakana_to_ucs/];
}

package Encode::SJIS::X0213ASCII;
use vars qw/@ISA/;
push @ISA, 'Encode::SJIS';
__PACKAGE__->Define (qw/shift_jisx0213-ascii sjis-ascii shift-jis-ascii/);

=item sjis-ascii

Same as sjis but ASCII (ISO/IEC 646 IRV) instead of
JIS X 0201 Roman (or Latin) set.  (Alias: shift-jis-ascii)

In spite of the history of shift JIS, ASCII is sometimes
used instead of JIS X 0201 Roman set, because of compatibility
with ASCII world.

Note that this name is now an alias of shift_jisx0213-ascii,
as sjis is of shift_jisx0213.

=item shift_jisx0213-ascii

Same as Shift_JISX0213 but ASCII (ISO/IEC 646 IRV)
instead of JIS X 0201:1997 Latin character set.

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{B};	## ASCII
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0213_2000_1 ucs_to_jisx0213_2000_2 ucs_to_jisx0201_katakana/];
}
sub __decode_map ($) {
  [qw/jisx0213_2000_1_to_ucs jisx0213_2000_2_to_ucs jisx0201_katakana_to_ucs/];
}

1;
__END__

=head1 SEE ALSO

JIS X 0208:1997, "7-bit and 8-bit double byte coded Kanji
set for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 1997.

JIS X 0213:2000, "7-bit and 8-bit double byte coded extended Kanji
sets for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 2000.

Encode, perlunicode

[IANAREG] "CHARACTER SETS", IANA <http://www.iana.org/>,
<http://www.iana.org/assignments/character-sets>.
The charset registry for IETF <http://www.ietf.org/> standards.
(Note that in this registry two shift JISes are registered,
"Shift_JIS" and "Windows-31j".  Former is JIS X 0208:1997's
definition and later is the Windows standard character set.)

=head1 LICENSE

Copyright 2002 Nanashi-san

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/10/12 07:27:01 $
### SJIS.pm ends here
