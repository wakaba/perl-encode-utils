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
������0������1������2������3������4������5������6������7������8������9������❶������❷������❸������❹������❺������❻������❼������❽������❾������❿������㊡������Ⓠ������Ⓐ������㊙������㊎������✿������♨������☀������☁������☃������◀������▶������⏎������♻������☞������☜������☟������☝������✌������❤������♥������♦������♣������♤������‼������⁉�������������░������☝������春������夏������秋������冬������↗������↘������↖������↙������!������✉
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{doti_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_doti} = \%U2L;
}
1;
### doti.pm ends here
