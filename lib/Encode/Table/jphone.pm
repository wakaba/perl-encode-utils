## This file is auto-generated (at 2010-05-03T06:00:09Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::jphone --- Convertion tables
used with Encode::Table, C<jphone_to_ucs>
and C<ucs_to_jphone>

=head1 TABLES

=over 4

=item jphone_to_ucs

Convertion table of jphone -> ucs

=item ucs_to_jphone

Convertion table of ucs -> jphone

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<jphone.tbr>.)

=cut

package Encode::Table::jphone;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a6a3a6a3a6a1a6a1a6a3a6a3a6a3a6a3a6a3a6a3a6a1a6a1a6a3a6a1a6a3}, <<'END');
ý°‚”žâ˜Žý°‚”¤â˜ý°‚”µ?ý°‚”¶!ý°‚”·â™¥ý°‚•â˜ƒý°‚•žâ˜ý°‚•Ÿâ˜€ý°‚• â˜‚ý°‚––â™¨ý°‚˜Ÿ©ý°‚˜ ®ý°‚™¡â—ý°‚™¢×ý°‚œ¢â„¢
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{jphone_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_jphone} = \%U2L;
}
1;
### jphone.pm ends here
