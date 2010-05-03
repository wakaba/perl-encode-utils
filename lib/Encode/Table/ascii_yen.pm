## This file is auto-generated (at 2010-05-03T05:59:47Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::ascii_yen --- Convertion tables
used with Encode::Table, C<ascii_yen_to_ucs>
and C<ucs_to_ascii_yen>

=head1 TABLES

=over 4

=item ascii_yen_to_ucs

Convertion table of ascii_yen -> ucs

=item ucs_to_ascii_yen

Convertion table of ucs -> ascii_yen

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<ascii_yen.tbr>.)

=cut

package Encode::Table::ascii_yen;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1}, <<'END');
!!""##$$%%&&''(())**++,,--..//00112233445566778899::;;<<==>>??@@AABBCCDDEEFFGGHHIIJJKKLLMMNNOOPPQQRRSSTTUUVVWWXXYYZZ[[\¥]]^^__``aabbccddeeffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzz{{||}}~~
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{ascii_yen_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_ascii_yen} = \%U2L;
}
1;
### ascii_yen.pm ends here
