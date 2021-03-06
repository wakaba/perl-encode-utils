## This file is auto-generated (at 2010-05-03T06:00:00Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::isoiec8859_9 --- Convertion tables
used with Encode::Table, C<isoiec8859_9_to_ucs>
and C<ucs_to_isoiec8859_9>

=head1 TABLES

=over 4

=item isoiec8859_9_to_ucs

Convertion table of isoiec8859_9 -> ucs

=item ucs_to_isoiec8859_9

Convertion table of ucs -> isoiec8859_9

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<isoiec8859_9.tbr>.)

=cut

package Encode::Table::isoiec8859_9;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a1a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a1a2a1a1}, <<'END');
 ���������	�
���������������������� �!�"�#�$�%�&�'�(�)�*�+�,�-�.�/�0Ğ1�2�3�4�5�6�7�8�9�:�;�<�=İ>Ş?�@�A�B�C�D�E�F�G�H�I�J�K�L�M�N�O�PğQ�R�S�T�U�V�W�X�Y�Z�[�\�]ı^ş_�
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{isoiec8859_9_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_isoiec8859_9} = \%U2L;
}
1;
### isoiec8859_9.pm ends here
