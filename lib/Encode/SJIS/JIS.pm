
=head1 NAME

Encode::SJIS::JIS --- Encoder/decoder of standard Shift JIS coding systems

=head1 ENCODINGS

=over 4

=cut

package Encode::SJIS::JIS;
use strict;
our $VERSION=do{my @r=(q$Revision: 1.1 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
require Encode::SJIS;
require Encode::Encoding;

package Encode::SJIS::JIS::SJIS1997;
use base 'Encode::SJIS';
__PACKAGE__->Define (qw!shift-jis-1997 shift_jis csshiftjis japanese-shift-jis!);

=item shift-jis-1997

Shift coded representation defined by JIS X 0208:1997 Appendix 1.
(Alias: shift_jis (IANA), csshiftjis (IANA), japanese-shift-jis (emacsen))

Note that although IANA registry [IANAREG] associates the name "MS_Kanji"
as an alias of "Shift_JIS", in this module it is not used as
a name of Shift coded representation of JIS X 0208,
since it is more apropreate to associate the name with
Microsoft-defined-Shift-JIS.  (Microsoft's shift JIS is
superset of JIS X 0208's shift JIS, even Microsoft's
does NOT comform to JIS X 0208:1997.)

=cut

sub __2022__common ($) {
  my $C = Encode::SJIS->new_object;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{J};	## JIS X 0201:1997 Latin
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{G2} = $Encode::Charset::CHARSET{G94}->{I};	## JIS X 0201:1997 Katakana
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{' @'};	## undef
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_jisx0201_latin ucs_to_jisx0208_1997 ucs_to_jisx0201_katakana/];
}
sub __decode_map ($) {
  [qw/jisx0201_latin_to_ucs jisx0208_1997_to_ucs jisx0201_katakana_to_ucs/];
}

package Encode::SJIS::JIS::SJIS1997ASCII;
use base 'Encode::SJIS::JIS::SJIS1997';
__PACKAGE__->Define (qw/shift-jis-1997-ascii/);

=item shift-jis-1997-ascii

Same as Shift_JISX0213 but ASCII (ISO/IEC 646 IRV)
instead of JIS X 0201:1997 Latin character set.

Note that this coding system does NOT comform to
JIS X 0208:1997 Appendix 1.

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{B};	## ASCII
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_ascii ucs_to_jisx0208_1997 ucs_to_jisx0201_katakana/];
}
sub __decode_map ($) {
  [qw/jisx0208_1997_to_ucs jisx0201_katakana_to_ucs/];
}

package Encode::SJIS::JIS::SJIS2000plane1;
use base 'Encode::SJIS';
__PACKAGE__->Define (qw!shift_jisx0213-plane1!);

=item shift_jisx0213-plane1

Shift_JISX0213-plane1 coded representation defined by JIS X 0213:2000
Appendix 1 (i.e. implemention level 3).

=cut

sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{G3} = $Encode::Charset::CHARSET{G94n}->{' @'};	## undef
  $C;
}
sub __encode_map ($) {
  [qw/ucs_to_jisx0201_latin ucs_to_jisx0213_2000_1 ucs_to_jisx0201_katakana/];
}

1;
__END__

=back

Coding systems C<shift_jisx0213> and C<shift_jisx0213-ascii>
are defined in Encode::SJIS.

Shift JISes using alternative name (so mapped to HALFWIDTH
or FULLWIDTH area of UCS) defined by JIS X 0208:1997 or
JIS X 0213:2000 are not included in this module but in
Encode::SJIS::JISCompatible.

Shift JISes with JIS X 0208-1978, -1983, -1990 are not
included in this module since these standards did not
define them.  They are defined in Encode::SJIS::*
other than this module.

=head1 SEE ALSO

JIS X 0208:1997, "7-bit and 8-bit double byte coded Kanji
set for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 1997.

JIS X 0213:2000, "7-bit and 8-bit double byte coded extended Kanji
sets for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 2000.

Encode::SJIS

[IANAREG] "CHARACTER SETS", IANA <http://www.iana.org/>,
<http://www.iana.org/assignments/character-sets>.
The charset registry for IETF <http://www.ietf.org/> standards.

=head1 LICENSE

Copyright 2002 Nanashi-san

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/10/12 11:02:38 $
### SJIS.pm ends here
