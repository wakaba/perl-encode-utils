## This file is auto-generated (at 2010-05-03T05:59:59Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::isoiec8859_3 --- Convertion tables
used with Encode::Table, C<isoiec8859_3_to_ucs>
and C<ucs_to_isoiec8859_3>

=head1 TABLES

=over 4

=item isoiec8859_3_to_ucs

Convertion table of isoiec8859_3 -> ucs

=item ucs_to_isoiec8859_3

Convertion table of ucs -> isoiec8859_3

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<isoiec8859_3.tbr>.)

=cut

package Encode::Table::isoiec8859_3;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a1a1a1a2a1a2a1a1a1a1a1a2a1a1a1a1a1a2a1a2a1a2a1a2a1a1a1a2a1a1a1a2a1a1a1a1a1a1a1a1a1a2a1a1a1a1a1a2a1a2a1a2a1a2a1a1a1a2a1a1a1a1a1a1a1a1a1a2a1a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a1a1a1a1a1a2a1a1a1a1a1a1a1a1a1a2a1a2a1a1a1a1a1a1a1a1a1a1a1a2a1a2a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a2a1a1a1a1a1a2a1a1a1a1a1a1a1a1a1a2a1a2a1a2}, <<'END');
 �Ħ˘��Ĥ��	İ
ŞĞĴ�Ż�ħ����ĥ��ışğĵ�ż �!�"�$�%Ċ&Ĉ'�(�)�*�+�,�-�.�/�1�2�3�4�5Ġ6�7�8Ĝ9�:�;�<�=Ŭ>Ŝ?�@�A�B�D�EċFĉG�H�I�J�K�L�M�N�O�Q�R�S�T�UġV�W�XĝY�Z�[�\�]ŭ^ŝ_˙
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{isoiec8859_3_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_isoiec8859_3} = \%U2L;
}
1;
### isoiec8859_3.pm ends here
