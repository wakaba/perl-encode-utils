
=head1 NAME

Encode::Charset::Pictogram --- Coded character sets objects,
used by Encode::ISO2022, Encode::SJIS, and other modules
--- Coded character sets of pictograms

=cut

package Encode::Charset::Pictogram;
use strict;
our $VERSION=do{my @r=(q$Revision: 1.1 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
require Encode::Charset;

sub import ($;@) {
  #shift;
  #my %item;
  #for (@_) {
  #  $item{$_} = 1;
  #}
  #if ($item{':foo'}) {
    $Encode::Charset::CHARSET{G256n}->{CSimode_g3} = {
      	chars => 188, dimension => 2, rows => 3, ucs => 0x7100E524,
      	Csjis_ku => {0xF7 => 0, 0xF8 => 1, 0xF9 => 2},
      	Csjis_first => {0 => 0xF7, 1 => 0xF8, 2 => 0xF9},
    };
    $Encode::Charset::CHARSET{G256n}->{CSlmode_g3} = {
      	chars => 188, dimension => 2, rows => 4, ucs => 0x7100E524,
      	Csjis_ku => {0xF7 => 3, 0xF8 => 1, 0xF9 => 2},
      	Csjis_first => {3 => 0xF7, 1 => 0xF8, 2 => 0xF9},
    };
    $Encode::Charset::CHARSET{G256n}->{CSdoti_g3} = {
      	chars => 188, dimension => 2, rows => 4, ucs => 0x7100E000,
      	Csjis_ku => {0xF0 => 0, 0xF1 => 1, 0xF2 => 2, 0xF3 => 3, 0xF4 => 4},
      	Csjis_first => {0 => 0xF0, 1 => 0xF1, 2 => 0xF2, 3 => 0xF3, 4 => 0xF4},
    };
    for (101..106) {
      $Encode::Charset::CHARSET{G94}->{'P'.$_} = {
      	chars => 94, dimension => 1, ucs => 0x70400000 + 94*$_,
      };
      $Encode::Charset::CHARSET{G94}->{ 'CSpictogram_page_'.($_-100) }
        = $Encode::Charset::CHARSET{G94}->{'P'.$_};
    }
  #}
  1;
}

=head1 EXAMPLE

  use Encode::Charset::Pictgram qw(:all);

=head1 SEE ALSO

L<Encode::SJIS::Pictogram/"SEE ALSO">

=head1 LICENSE

Copyright 2002 Nanashi-san  <nanashi-san@nanashi.invalid>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1; # $Date: 2002/12/18 10:21:09 $
