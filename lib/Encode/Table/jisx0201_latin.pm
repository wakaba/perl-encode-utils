## This file is auto-generated (at 2010-05-03T05:59:47Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::jisx0201_latin --- Convertion tables
used with Encode::Table, C<jisx0201_latin_to_ucs>
and C<ucs_to_jisx0201_latin>

=head1 TABLES

=over 4

=item jisx0201_latin_to_ucs

Convertion table of jisx0201_latin -> ucs

=item ucs_to_jisx0201_latin

Convertion table of ucs -> jisx0201_latin

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<jisx0201_latin.tbr>.)

=cut

package Encode::Table::jisx0201_latin;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a3}, <<'END');
�����!�����"�����#�����$�����%�����&�����'�����(�����)�����*�����+�����,�����-�����.�����/�����0�����1�����2�����3�����4�����5�����6�����7�����8�����9�����:�����;�����<�����=�����>�����?�����@�����A�����B�����C�����D�����E�����F�����G�����H�����I�����J�����K�����L�����M�����N�����O�����P�����Q�����R�����S�����T�����U�����V�����W�����X�����Y�����Z�����[�����������]�����^�����_�����`�����a�����b�����c�����d�����e�����f�����g�����h�����i�����j�����k�����l�����m�����n�����o�����p�����q�����r�����s�����t�����u�����v�����w�����x�����y�����z�����{�����|�����}�����‾
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{jisx0201_latin_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_jisx0201_latin} = \%U2L;
}
1;
### jisx0201_latin.pm ends here
