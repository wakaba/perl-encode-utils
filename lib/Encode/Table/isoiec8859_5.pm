## This file is auto-generated (at 2010-05-03T05:59:59Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::isoiec8859_5 --- Convertion tables
used with Encode::Table, C<isoiec8859_5_to_ucs>
and C<ucs_to_isoiec8859_5>

=head1 TABLES

=over 4

=item isoiec8859_5_to_ucs

Convertion table of isoiec8859_5 -> ucs

=item ucs_to_isoiec8859_5

Convertion table of ucs -> isoiec8859_5

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<isoiec8859_5.tbr>.)

=cut

package Encode::Table::isoiec8859_5;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a1a1a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a1a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a3a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a2a1a1a1a2a1a2}, <<'END');
 �ЁЂЃЄЅІЇЈ	Љ
ЊЋЌ�ЎЏАБВГДЕЖЗИЙКЛМНОП Р!С"Т#У$Ф%Х&Ц'Ч(Ш)Щ*Ъ+Ы,Ь-Э.Ю/Я0а1б2в3г4д5е6ж7з8и9й:к;л<м=н>о?п@рAсBтCуDфEхFцGчHшIщJъKыLьMэNюOяP№QёRђSѓTєUѕVіWїXјYљZњ[ћ\ќ]�^ў_џ
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{isoiec8859_5_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_isoiec8859_5} = \%U2L;
}
1;
### isoiec8859_5.pm ends here
