
=head1 NAME

Encode::Table::JISEditions --- Code point unification tables of
JIS coded character sets

=cut

package Encode::Table::JISEditions;
use strict;
our $VERSION=do{my @r=(q$Revision: 1.1 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};

my $start94n = 0xE9F6C0;
my $start1978 = $start94n + 94*94*(0x40-0x30);
my $start1983 = $start94n + 94*94*(0x42-0x30);
my $start1990 = $start94n + 94*94*79;
my $start2000 = $start94n + 94*94*(0x4F-0x30);

for (0..94*94-1) {
  $Encode::Table::TABLE{jisx0208_1978_to_1983__cpunify}->{chr ($_ + $start1978)} = chr ($_ + $start1983);
  $Encode::Table::TABLE{jisx0208_1978_to_1990__cpunify}->{chr ($_ + $start1978)} = chr ($_ + $start1990);
  $Encode::Table::TABLE{jisx0208_1983_to_1990__cpunify}->{chr ($_ + $start1983)} = chr ($_ + $start1990);
}
$Encode::Table::TABLE{jisx0208_1983_to_1978__cpunify} = {reverse %{$Encode::Table::TABLE{jisx0208_1978_to_1983__cpunify}}};
$Encode::Table::TABLE{jisx0208_1990_to_1978__cpunify} = {reverse %{$Encode::Table::TABLE{jisx0208_1978_to_1990__cpunify}}};
$Encode::Table::TABLE{jisx0208_1990_to_1983__cpunify} = {reverse %{$Encode::Table::TABLE{jisx0208_1983_to_1990__cpunify}}};

my $startlatin = 0xE90940 + 94*(ord ('J')-0x30);
for (0..93) {
  $Encode::Table::TABLE{jisx0201_latin_to_ascii__cpunify}->{chr ($startlatin + $_)} = chr ($_ + 0x21);
}
$Encode::Table::TABLE{ascii_to_jisx0201_latin__cpunify} = {reverse %{$Encode::Table::TABLE{jisx0201_latin_to_ascii__cpunify}}};

my @hw = split //, q(!"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~);
my @fw = qw(�� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��);
for (0..93) {
  $Encode::Table::TABLE{jisx0208_1990_to_ascii}->{chr ($start1990 + (ord ($fw[$_]) - 0xA1) * 94 + (ord (substr ($fw[$_], 1)) - 0xA1))} = $hw[$_];
}
$Encode::Table::TABLE{ascii_to_jisx0208_1990} = {reverse %{$Encode::Table::TABLE{jisx0208_1990_to_ascii}}};

my $startkatakana = 0xE90940 + 94*(ord ('I')-0x30);
@hw = qw(�� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��);
@fw = qw(�� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ��);
for (0..0x3E) {
  $Encode::Table::TABLE{jisx0208_1990_to_jisx0201_katakana}->{chr ($start1990 + (ord ($fw[$_]) - 0xA1) * 94 + (ord (substr ($fw[$_], 1)) - 0xA1))} = chr ($startkatakana + ord (substr ($hw[$_], 1)) - 0xA1);
}
$Encode::Table::TABLE{jisx0201_katakana_to_jisx0208_1990} = {reverse %{$Encode::Table::TABLE{jisx0208_1990_to_jisx0201_katakana}}};

1;

=head1 SEE ALSO

L<Encode::Table>

=head1 LICENSE

Copyright 2002 Nanashi-san

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/10/14 06:56:53 $
### JISEditions.pm ends here
