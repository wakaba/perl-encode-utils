## This file is auto-generated (at 2010-05-03T05:59:58Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::jisx0208_to_katakana_hw --- Convertion tables
used with Encode::Table, C<jisx0208_to_katakana_hw_to_ucs>
and C<ucs_to_jisx0208_to_katakana_hw>

=head1 TABLES

=over 4

=item jisx0208_to_katakana_hw_to_ucs

Convertion table of jisx0208_to_katakana_hw -> ucs

=item ucs_to_jisx0208_to_katakana_hw

Convertion table of ucs -> jisx0208_to_katakana_hw

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<jisx0208_to_katakana_hw.tbr>.)

=cut

package Encode::Table::jisx0208_to_katakana_hw;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3}, <<'END');
ø½‰µ½ï½¤ø½‰µ¾ï½¡ø½‰¶ï½¥ø½‰¶†ï¾žø½‰¶‡ï¾Ÿø½‰¶—ï½°ø½‰¶±ï½¢ø½‰¶²ï½£ø½‰»´ï½§ø½‰»µï½±ø½‰»¶ï½¨ø½‰»·ï½²ø½‰»¸ï½©ø½‰»¹ï½³ø½‰»ºï½ªø½‰»»ï½´ø½‰»¼ï½«ø½‰»½ï½µø½‰»¾ï½¶ø½‰¼€ï½·ø½‰¼‚ï½¸ø½‰¼„ï½¹ø½‰¼†ï½ºø½‰¼ˆï½»ø½‰¼Šï½¼ø½‰¼Œï½½ø½‰¼Žï½¾ø½‰¼ï½¿ø½‰¼’ï¾€ø½‰¼”ï¾ø½‰¼–ï½¯ø½‰¼—ï¾‚ø½‰¼™ï¾ƒø½‰¼›ï¾„ø½‰¼ï¾…ø½‰¼žï¾†ø½‰¼Ÿï¾‡ø½‰¼ ï¾ˆø½‰¼¡ï¾‰ø½‰¼¢ï¾Šø½‰¼¥ï¾‹ø½‰¼¨ï¾Œø½‰¼«ï¾ø½‰¼®ï¾Žø½‰¼±ï¾ø½‰¼²ï¾ø½‰¼³ï¾‘ø½‰¼´ï¾’ø½‰¼µï¾“ø½‰¼¶ï½¬ø½‰¼·ï¾”ø½‰¼¸ï½­ø½‰¼¹ï¾•ø½‰¼ºï½®ø½‰¼»ï¾–ø½‰¼¼ï¾—ø½‰¼½ï¾˜ø½‰¼¾ï¾™ø½‰¼¿ï¾šø½‰½€ï¾›ø½‰½‚ï¾œø½‰½…ï½¦ø½‰½†ï¾
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{jisx0208_to_katakana_hw_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_jisx0208_to_katakana_hw} = \%U2L;
}
1;
### jisx0208_to_katakana_hw.pm ends here
