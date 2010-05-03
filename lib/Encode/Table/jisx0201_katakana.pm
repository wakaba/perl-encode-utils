## This file is auto-generated (at 2010-05-03T05:59:47Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::jisx0201_katakana --- Convertion tables
used with Encode::Table, C<jisx0201_katakana_to_ucs>
and C<ucs_to_jisx0201_katakana>

=head1 TABLES

=over 4

=item jisx0201_katakana_to_ucs

Convertion table of jisx0201_katakana -> ucs

=item ucs_to_jisx0201_katakana

Convertion table of ucs -> jisx0201_katakana

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<jisx0201_katakana.tbr>.)

=cut

package Encode::Table::jisx0201_katakana;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3}, <<'END');
øº‘‰®ã€‚øº‘‰¯ã€Œøº‘‰°ã€øº‘‰±ã€øº‘‰²ãƒ»øº‘‰³ãƒ²øº‘‰´ã‚¡øº‘‰µã‚£øº‘‰¶ã‚¥øº‘‰·ã‚§øº‘‰¸ã‚©øº‘‰¹ãƒ£øº‘‰ºãƒ¥øº‘‰»ãƒ§øº‘‰¼ãƒƒøº‘‰½ãƒ¼øº‘‰¾ã‚¢øº‘‰¿ã‚¤øº‘Š€ã‚¦øº‘Šã‚¨øº‘Š‚ã‚ªøº‘Šƒã‚«øº‘Š„ã‚­øº‘Š…ã‚¯øº‘Š†ã‚±øº‘Š‡ã‚³øº‘Šˆã‚µøº‘Š‰ã‚·øº‘ŠŠã‚¹øº‘Š‹ã‚»øº‘ŠŒã‚½øº‘Šã‚¿øº‘ŠŽãƒøº‘Šãƒ„øº‘Šãƒ†øº‘Š‘ãƒˆøº‘Š’ãƒŠøº‘Š“ãƒ‹øº‘Š”ãƒŒøº‘Š•ãƒøº‘Š–ãƒŽøº‘Š—ãƒøº‘Š˜ãƒ’øº‘Š™ãƒ•øº‘Ššãƒ˜øº‘Š›ãƒ›øº‘Šœãƒžøº‘ŠãƒŸøº‘Šžãƒ øº‘ŠŸãƒ¡øº‘Š ãƒ¢øº‘Š¡ãƒ¤øº‘Š¢ãƒ¦øº‘Š£ãƒ¨øº‘Š¤ãƒ©øº‘Š¥ãƒªøº‘Š¦ãƒ«øº‘Š§ãƒ¬øº‘Š¨ãƒ­øº‘Š©ãƒ¯øº‘Šªãƒ³øº‘Š«ã‚›øº‘Š¬ã‚œ
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{jisx0201_katakana_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_jisx0201_katakana} = \%U2L;
}
1;
### jisx0201_katakana.pm ends here
