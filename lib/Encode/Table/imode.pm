## This file is auto-generated (at 2010-05-03T06:00:09Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::imode --- Convertion tables
used with Encode::Table, C<imode_to_ucs>
and C<ucs_to_imode>

=head1 TABLES

=over 4

=item imode_to_ucs

Convertion table of imode -> ucs

=item ucs_to_imode

Convertion table of ucs -> imode

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<imode.tbr>.)

=cut

package Encode::Table::imode;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a3a6a1a6a3a6a3a6a3a6a1a6a3a6a3a6a3}, <<'END');
������☀������☁������☂������☃������♈������♉������♊������♋������♌������♍������♎������♏������♐������♑������♒������♓������☏������♥������♠������♦������♣������↘������↖������↙������✉������❤������⤴������♪������♨������⤵������!������⁉������‼������〰�������������™������♻������℗
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{imode_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_imode} = \%U2L;
}
1;
### imode.pm ends here
