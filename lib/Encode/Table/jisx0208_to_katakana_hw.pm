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
�����､�����｡�����･�����ﾞ�����ﾟ�����ｰ�����｢�����｣�����ｧ�����ｱ�����ｨ�����ｲ�����ｩ�����ｳ�����ｪ�����ｴ�����ｫ�����ｵ�����ｶ�����ｷ�����ｸ�����ｹ�����ｺ�����ｻ�����ｼ�����ｽ�����ｾ�����ｿ�����ﾀ�����ﾁ�����ｯ�����ﾂ�����ﾃ�����ﾄ�����ﾅ�����ﾆ�����ﾇ�����ﾈ�����ﾉ�����ﾊ�����ﾋ�����ﾌ�����ﾍ�����ﾎ�����ﾏ�����ﾐ�����ﾑ�����ﾒ�����ﾓ�����ｬ�����ﾔ�����ｭ�����ﾕ�����ｮ�����ﾖ�����ﾗ�����ﾘ�����ﾙ�����ﾚ�����ﾛ�����ﾜ�����ｦ�����ﾝ
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{jisx0208_to_katakana_hw_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_jisx0208_to_katakana_hw} = \%U2L;
}
1;
### jisx0208_to_katakana_hw.pm ends here
