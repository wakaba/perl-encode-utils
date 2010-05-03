## This file is auto-generated (at 2010-05-03T06:00:09Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::iso_ir_169 --- Convertion tables
used with Encode::Table, C<iso_ir_169_to_ucs>
and C<ucs_to_iso_ir_169>

=head1 TABLES

=over 4

=item iso_ir_169_to_ucs

Convertion table of iso_ir_169 -> ucs

=item ucs_to_iso_ir_169

Convertion table of ucs -> iso_ir_169

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<iso_ir_169.tbr>.)

=cut

package Encode::Table::iso_ir_169;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a2a5a2a5a2a5a3a5a3a5a3a5a3a5a3a5a3a5a2a5a3a5a3a5a3a5a1a5a1a5a3a5a3a5a3a5a1a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a1a5a3a5a3a5a1a5a1a5a3a5a1a5a3a5a3a5a1a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a1}, <<'END');
����� �����!�����%�����?�����.�����,�����:�����0�����1�����2�����3�����4�����5�����6�����7�����8�����9�����˄�����˃�����˅�����﹢�����⇉�����∠�����⇄�����←�����↦�����˖�����◫�����▷�����△�����������$�����↓�����↙�����↘�����_�����□�����♡�����▶�����→�����✉�����−�����⊿�����������∥�����◳�����>�����<�����◎�����=�����‾�����✡�����*�����○�����↛�����↑�����⇅�����↖�����↗�����〜�����﹖������
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{iso_ir_169_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_iso_ir_169} = \%U2L;
}
1;
### iso_ir_169.pm ends here
