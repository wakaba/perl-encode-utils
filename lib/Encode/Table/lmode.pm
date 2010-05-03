## This file is auto-generated (at 2010-05-03T06:00:09Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::lmode --- Convertion tables
used with Encode::Table, C<lmode_to_ucs>
and C<ucs_to_lmode>

=head1 TABLES

=over 4

=item lmode_to_ucs

Convertion table of lmode -> ucs

=item ucs_to_lmode

Convertion table of ucs -> lmode

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<lmode.tbr>.)

=cut

package Encode::Table::lmode;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a1a6a3a6a3a6a3a6a1a6a3a6a3a6a3a6a3a6a3}, <<'END');
������☀������☁������☂������☃������♈������♉������♊������♋������♌������♍������♎������♏������♐������♑������♒������♓������☏������♥������♠������♦������♣������↘������↖������↙������✉������❤������⤴������♪������♨������⤵������!������⁉������‼������〰�������������™������♻������℗������♬������❀
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{lmode_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_lmode} = \%U2L;
}
1;
### lmode.pm ends here
