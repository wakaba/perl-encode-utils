## This file is auto-generated (at 2010-05-03T06:00:09Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::iso_ir_231 --- Convertion tables
used with Encode::Table, C<iso_ir_231_to_ucs>
and C<ucs_to_iso_ir_231>

=head1 TABLES

=over 4

=item iso_ir_231_to_ucs

Convertion table of iso_ir_231 -> ucs

=item ucs_to_iso_ir_231

Convertion table of ucs -> iso_ir_231

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<iso_ir_231.tbr>.)

=cut

package Encode::Table::iso_ir_231;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a5a2a5a1a5a2a5a1a5a1a5a2a5a2a5a1a5a3a5a1a5a1a5a2a5a2a5a2a5a2a5a2a5a1a5a2a5a1a5a1a5a2a5a2a5a2a5a1a5a1a5a2a5a2a5a1a5a3a5a3a5a1a5a3a5a1a5a1}, <<'END');
øºŽ¾ÅøºŽ¿Øøº€ÄøºÞøº‚ÆøºƒÅ’øº„Ê¹øº…·øº†â™­øº‡®øºˆ±øº‰Æ øºŠÆ¯øº‹Ê¾øºÊ»øºŽÅ‚øºøøºÄ‘øº‘þøº’æøº“Å“øº”Êºøº•Ä±øº–£øº—ðøº™Æ¡øºšÆ°øº°øºžâ„“øºŸâ„—øº ©øº¡â™¯øº¢¿øº£¡
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{iso_ir_231_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_iso_ir_231} = \%U2L;
}
1;
### iso_ir_231.pm ends here
