## This file is auto-generated (at 2010-05-03T05:59:59Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::isoiec8859_4 --- Convertion tables
used with Encode::Table, C<isoiec8859_4_to_ucs>
and C<ucs_to_isoiec8859_4>

=head1 TABLES

=over 4

=item isoiec8859_4_to_ucs

Convertion table of isoiec8859_4 -> ucs

=item ucs_to_isoiec8859_4

Convertion table of ucs -> isoiec8859_4

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<isoiec8859_4.tbr>.)

=cut

package Encode::Table::isoiec8859_4;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a1a1a1a2a1a2a1a2a1a1a1a2a1a2a1a1a1a1a1a2a1a2a1a2a1a2a1a1a1a2a1a1a1a1a1a2a1a2a1a2a1a1a1a2a1a2a1a2a1a1a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a1a1a1a1a1a1a1a1a1a1a1a1a2a1a2a1a1a1a2a1a1a1a2a1a1a1a1a1a2a1a2a1a2a1a2a1a2a1a1a1a1a1a1a1a1a1a1a1a2a1a1a1a1a1a1a1a2a1a2a1a1a1a2a1a1a1a1a1a1a1a1a1a1a1a1a1a2a1a2a1a1a1a2a1a1a1a2a1a1a1a1a1a2a1a2a1a2a1a2a1a2a1a1a1a1a1a1a1a1a1a1a1a2a1a1a1a1a1a1a1a2a1a2a1a2}, <<'END');
 �ĄĸŖ�ĨĻ��	Š
ĒĢŦ�Ž��ą˛ŗ�ĩļˇ�šēģŧŊžŋ Ā!�"�#�$�%�&�'Į(Č)�*Ę+�,Ė-�.�/Ī0Đ1Ņ2Ō3Ķ4�5�6�7�8�9Ų:�;�<�=Ũ>Ū?�@āA�B�C�D�E�F�GįHčI�JęK�LėM�N�OīPđQņRōSķT�U�V�W�X�YųZ�[�\�]ũ^ū_˙
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{isoiec8859_4_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_isoiec8859_4} = \%U2L;
}
1;
### isoiec8859_4.pm ends here
