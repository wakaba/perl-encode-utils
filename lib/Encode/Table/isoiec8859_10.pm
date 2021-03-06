## This file is auto-generated (at 2010-05-03T06:00:00Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::isoiec8859_10 --- Convertion tables
used with Encode::Table, C<isoiec8859_10_to_ucs>
and C<ucs_to_isoiec8859_10>

=head1 TABLES

=over 4

=item isoiec8859_10_to_ucs

Convertion table of isoiec8859_10 -> ucs

=item ucs_to_isoiec8859_10

Convertion table of ucs -> isoiec8859_10

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<isoiec8859_10.tbr>.)

=cut

package Encode::Table::isoiec8859_10;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a1a1a1a2a1a2a1a2a1a2a1a2a1a2a1a1a1a2a1a2a1a2a1a2a1a2a1a1a1a2a1a2a1a1a1a2a1a2a1a2a1a2a1a2a1a2a1a1a1a2a1a2a1a2a1a2a1a2a1a3a1a2a1a2a1a2a1a1a1a1a1a1a1a1a1a1a1a1a1a2a1a2a1a1a1a2a1a1a1a2a1a1a1a1a1a1a1a1a1a2a1a2a1a1a1a1a1a1a1a1a1a2a1a1a1a2a1a1a1a1a1a1a1a1a1a1a1a1a1a2a1a1a1a1a1a1a1a1a1a1a1a1a1a2a1a2a1a1a1a2a1a1a1a2a1a1a1a1a1a1a1a1a1a2a1a2a1a1a1a1a1a1a1a1a1a2a1a1a1a2a1a1a1a1a1a1a1a1a1a1a1a2}, <<'END');
 �ĄĒĢĪĨĶ�Ļ	Đ
ŠŦŽ�ŪŊ�ąēģīĩķ�ļđšŧž―ūŋ Ā!�"�#�$�%�&�'Į(Č)�*Ę+�,Ė-�.�/�0�1Ņ2Ō3�4�5�6�7Ũ8�9Ų:�;�<�=�>�?�@āA�B�C�D�E�F�GįHčI�JęK�LėM�N�O�P�QņRōS�T�U�V�WũX�YųZ�[�\�]�^�_ĸ
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{isoiec8859_10_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_isoiec8859_10} = \%U2L;
}
1;
### isoiec8859_10.pm ends here
