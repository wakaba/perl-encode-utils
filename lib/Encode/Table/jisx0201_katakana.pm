## This file is auto-generated (at 2010-05-03T05:59:47Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::jisx0201_katakana --- Convertion tables
used with Encode::Table, C<jisx0201_katakana_to_ucs>
and C<ucs_to_jisx0201_katakana>

=head1 TABLES

=over 4

=item jisx0201_katakana_to_ucs

Convertion table of jisx0201_katakana -> ucs

=item ucs_to_jisx0201_katakana

Convertion table of ucs -> jisx0201_katakana

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<jisx0201_katakana.tbr>.)

=cut

package Encode::Table::jisx0201_katakana;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3}, <<'END');
�����。�����「�����」�����、�����・�����ヲ�����ァ�����ィ�����ゥ�����ェ�����ォ�����ャ�����ュ�����ョ�����ッ�����ー�����ア�����イ�����ウ�����エ�����オ�����カ�����キ�����ク�����ケ�����コ�����サ�����シ�����ス�����セ�����ソ�����タ�����チ�����ツ�����テ�����ト�����ナ�����ニ�����ヌ�����ネ�����ノ�����ハ�����ヒ�����フ�����ヘ�����ホ�����マ�����ミ�����ム�����メ�����モ�����ヤ�����ユ�����ヨ�����ラ�����リ�����ル�����レ�����ロ�����ワ�����ン�����゛�����゜
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{jisx0201_katakana_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_jisx0201_katakana} = \%U2L;
}
1;
### jisx0201_katakana.pm ends here
