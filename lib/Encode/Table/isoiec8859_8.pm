## This file is auto-generated (at 2010-05-03T06:00:00Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::isoiec8859_8 --- Convertion tables
used with Encode::Table, C<isoiec8859_8_to_ucs>
and C<ucs_to_isoiec8859_8>

=head1 TABLES

=over 4

=item isoiec8859_8_to_ucs

Convertion table of isoiec8859_8 -> ucs

=item ucs_to_isoiec8859_8

Convertion table of ucs -> isoiec8859_8

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<isoiec8859_8.tbr>.)

=cut

package Encode::Table::isoiec8859_8;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a3a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2}, <<'END');
 ��������	�
���������������������?‗@אAבBגCדDהEוFזGחHטIיJךKכLלMםNמOןPנQסRעSףTפUץVצWקXרYשZת
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{isoiec8859_8_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_isoiec8859_8} = \%U2L;
}
1;
### isoiec8859_8.pm ends here
