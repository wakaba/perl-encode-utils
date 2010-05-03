## This file is auto-generated (at 2010-05-03T05:59:47Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::jisx0201_latin --- Convertion tables
used with Encode::Table, C<jisx0201_latin_to_ucs>
and C<ucs_to_jisx0201_latin>

=head1 TABLES

=over 4

=item jisx0201_latin_to_ucs

Convertion table of jisx0201_latin -> ucs

=item ucs_to_jisx0201_latin

Convertion table of ucs -> jisx0201_latin

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<jisx0201_latin.tbr>.)

=cut

package Encode::Table::jisx0201_latin;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a3}, <<'END');
øº‘‹Œ!øº‘‹"øº‘‹#øº‘‹$øº‘‹%øº‘‹‘&øº‘‹’'øº‘‹“(øº‘‹”)øº‘‹•*øº‘‹–+øº‘‹—,øº‘‹˜-øº‘‹™.øº‘‹š/øº‘‹›0øº‘‹œ1øº‘‹2øº‘‹3øº‘‹Ÿ4øº‘‹ 5øº‘‹¡6øº‘‹¢7øº‘‹£8øº‘‹¤9øº‘‹¥:øº‘‹¦;øº‘‹§<øº‘‹¨=øº‘‹©>øº‘‹ª?øº‘‹«@øº‘‹¬Aøº‘‹­Bøº‘‹®Cøº‘‹¯Døº‘‹°Eøº‘‹±Føº‘‹²Gøº‘‹³Høº‘‹´Iøº‘‹µJøº‘‹¶Køº‘‹·Løº‘‹¸Møº‘‹¹Nøº‘‹ºOøº‘‹»Pøº‘‹¼Qøº‘‹½Røº‘‹¾Søº‘‹¿Tøº‘Œ€Uøº‘ŒVøº‘Œ‚Wøº‘ŒƒXøº‘Œ„Yøº‘Œ…Zøº‘Œ†[øº‘Œ‡¥øº‘Œˆ]øº‘Œ‰^øº‘ŒŠ_øº‘Œ‹`øº‘ŒŒaøº‘Œbøº‘Œcøº‘Œdøº‘Œeøº‘Œ‘føº‘Œ’gøº‘Œ“høº‘Œ”iøº‘Œ•jøº‘Œ–køº‘Œ—løº‘Œ˜møº‘Œ™nøº‘Œšoøº‘Œ›pøº‘Œœqøº‘Œrøº‘Œsøº‘ŒŸtøº‘Œ uøº‘Œ¡vøº‘Œ¢wøº‘Œ£xøº‘Œ¤yøº‘Œ¥zøº‘Œ¦{øº‘Œ§|øº‘Œ¨}øº‘Œ©â€¾
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{jisx0201_latin_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_jisx0201_latin} = \%U2L;
}
1;
### jisx0201_latin.pm ends here
