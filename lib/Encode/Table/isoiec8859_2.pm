## This file is auto-generated (at 2010-05-03T05:59:59Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::isoiec8859_2 --- Convertion tables
used with Encode::Table, C<isoiec8859_2_to_ucs>
and C<ucs_to_isoiec8859_2>

=head1 TABLES

=over 4

=item isoiec8859_2_to_ucs

Convertion table of isoiec8859_2 -> ucs

=item ucs_to_isoiec8859_2

Convertion table of ucs -> isoiec8859_2

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<isoiec8859_2.tbr>.)

=cut

package Encode::Table::isoiec8859_2;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a1a1a1a2a1a2a1a2a1a1a1a2a1a2a1a1a1a1a1a2a1a2a1a2a1a2a1a1a1a2a1a2a1a1a1a2a1a2a1a2a1a1a1a2a1a2a1a2a1a1a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a1a1a1a1a2a1a1a1a2a1a2a1a1a1a2a1a1a1a2a1a1a1a2a1a1a1a1a1a2a1a2a1a2a1a2a1a1a1a1a1a2a1a1a1a1a1a2a1a2a1a1a1a2a1a1a1a1a1a2a1a1a1a2a1a1a1a1a1a2a1a1a1a2a1a2a1a1a1a2a1a1a1a2a1a1a1a2a1a1a1a1a1a2a1a2a1a2a1a2a1a1a1a1a1a2a1a1a1a1a1a2a1a2a1a1a1a2a1a1a1a1a1a2a1a2}, <<'END');
 �Ą˘Ł�ĽŚ��	Š
ŞŤŹ�ŽŻ�ą˛ł�ľśˇ�šşťź˝žż Ŕ!�"�#Ă$�%Ĺ&Ć'�(Č)�*Ę+�,Ě-�.�/Ď0Đ1Ń2Ň3�4�5Ő6�7�8Ř9Ů:�;Ű<�=�>Ţ?�@ŕA�B�CăD�EĺFćG�HčI�JęK�LěM�N�OďPđQńRňS�T�UőV�W�XřYůZ�[ű\�]�^ţ_˙
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{isoiec8859_2_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_isoiec8859_2} = \%U2L;
}
1;
### isoiec8859_2.pm ends here
