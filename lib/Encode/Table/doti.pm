## This file is auto-generated (at 2010-05-03T06:00:09Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::doti --- Convertion tables
used with Encode::Table, C<doti_to_ucs>
and C<ucs_to_doti>

=head1 TABLES

=over 4

=item doti_to_ucs

Convertion table of doti -> ucs

=item ucs_to_doti

Convertion table of ucs -> doti

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<doti.tbr>.)

=cut

package Encode::Table::doti;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a6a1a6a1a6a1a6a1a6a1a6a1a6a1a6a1a6a1a6a1a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a1a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a1a6a3}, <<'END');
ý±€Ž€€0ý±€Ž€1ý±€Ž€‚2ý±€Ž€ƒ3ý±€Ž€„4ý±€Ž€…5ý±€Ž€†6ý±€Ž€‡7ý±€Ž€ˆ8ý±€Ž€‰9ý±€Ž€â¶ý±€Ž€Žâ·ý±€Ž€â¸ý±€Ž€â¹ý±€Ž€‘âºý±€Ž€’â»ý±€Ž€“â¼ý±€Ž€”â½ý±€Ž€•â¾ý±€Ž€–â¿ý±€Ž€šãŠ¡ý±€Ž€Ÿâ“†ý±€Ž€ â’¶ý±€Ž€¢ãŠ™ý±€Ž€¨ãŠŽý±€ŽŽâœ¿ý±€Ž‚â™¨ý±€Ž‚¤â˜€ý±€Ž‚¥â˜ý±€Ž‚§â˜ƒý±€Ž‚©â—€ý±€Ž‚ªâ–¶ý±€Ž‚­âŽý±€Ž‚®â™»ý±€Ž‚¯â˜žý±€Ž‚°â˜œý±€Ž‚±â˜Ÿý±€Ž‚²â˜ý±€Ž‚´âœŒý±€Ž‚¸â¤ý±€Ž‚ºâ™¥ý±€Ž‚»â™¦ý±€Ž‚¼â™£ý±€Ž‚½â™¤ý±€Ž‚¾â€¼ý±€Ž‚¿â‰ý±€Žƒ²ý±€Ž„â–‘ý±€Ž…†â˜ý±€Ž…‰æ˜¥ý±€Ž…Šå¤ý±€Ž…‹ç§‹ý±€Ž…Œå†¬ý±€Žâ†—ý±€Žâ†˜ý±€Ž‘â†–ý±€Ž’â†™ý±€Ž˜!ý±€Ž¬âœ‰
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{doti_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_doti} = \%U2L;
}
1;
### doti.pm ends here
