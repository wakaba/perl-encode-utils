
=head1 NAME

Encode::Charset::Private --- Coded character sets objects,
used by Encode::ISO2022, Encode::SJIS, and other modules
--- Coded character sets not registered in ISO-IR

=cut

package Encode::Charset::Private;
use strict;
our $VERSION=do{my @r=(q$Revision: 1.1 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
require Encode::Charset;

sub import ($@) {
  shift;
  my %item;
  for (@_) {
    $item{$_} = 1;
  }
  if ($item{':gb'}) {
    my $c = 0x70420000;
    for (0..4,6) {
      $Encode::Charset::CHARSET{G94n}->{'P0_'.$_} = {
      	chars => 94, dimension => 2, ucs => $c + 94*94*$_,
      };
      $Encode::Charset::CHARSET{G94n}->{
        [qw/CSgb12345 CSgb7589 CSgb13131 CSgb7590 CSgb13132 _ CSgb16500/]->[$_]
      } = $Encode::Charset::CHARSET{G94n}->{'P0_'.$_};
    }
  }
  if ($item{':cns'}) {
    my $c = 0x70430000;
    for (0..6) {
      $Encode::Charset::CHARSET{G94n}->{'P1_'.$_} = {
      	chars => 94, dimension => 2, ucs => $c + 94*94*$_,
      };
      $Encode::Charset::CHARSET{G94n}->{'CScns11643_'.(8+$_)}
        = $Encode::Charset::CHARSET{G94n}->{'P1_'.$_};
    }
    $c = 0x70440000;
    for (0..1) {
      $Encode::Charset::CHARSET{G94n}->{'P2_'.$_} = {
      	chars => 94, dimension => 2, ucs => $c + 94*94*$_,
      };
      $Encode::Charset::CHARSET{G94n}->{'CScns11643_'.(15+$_)}
        = $Encode::Charset::CHARSET{G94n}->{'P2_'.$_};
    }
  }
  if ($item{':mule'}) {
    my $c = 0x70450000;
    for (1..6) {
      $Encode::Charset::CHARSET{G94n}->{'P3_'.$_} = {
      	chars => 94, dimension => 2, ucs => $c + 94*94*$_,
      };
      $Encode::Charset::CHARSET{G94n}->{
        [qw/_ CSmule_ethiopic CSmule_indian_2column CSmule_indian_1column
            CSmule_tibetan CSmule_tibetan_1column CSmule_thai_xtis/]->[$_]
      } = $Encode::Charset::CHARSET{G94n}->{'P3_'.$_};
    }
    $c = 0x70400000;
    for (0..5) {
      $Encode::Charset::CHARSET{G94}->{'P'.$_} = {
      	chars => 94, dimension => 1, ucs => $c + 94*$_,
      };
      $Encode::Charset::CHARSET{G94}->{
        [qw/CSomron_sisheng CSmule_lao CSmule_arabic_digit
            CSmule_arabic_1column CSmule_arabic_2column
            CSis13194/]->[$_]
      } = $Encode::Charset::CHARSET{G94}->{'P'.$_};
    }
    $Encode::Charset::CHARSET{G94}->{CSmule2_thai} = {
      chars => 94, dimension => 1, ucs => 0xE926A0+96*0x24+1,
    };	## TIS 620
    $c = 0x70410000;
    for (0..2) {
      $Encode::Charset::CHARSET{G96}->{'P'.$_} = {
      	chars => 96, dimension => 1, ucs => $c + 96*$_,
      };
      $Encode::Charset::CHARSET{G96}->{
        [qw/CSmule_ipa CSviscii_lower CSviscii_upper/]->[$_]
      } = $Encode::Charset::CHARSET{G96}->{'P'.$_};
    }
    $Encode::Charset::CHARSET{G96n}->{CSmule_ucs_0100}
      = {chars => 96, dimension => 2, ucs => 0x0100};
    $Encode::Charset::CHARSET{G96n}->{CSmule_ucs_2400}
      = {chars => 96, dimension => 2, ucs => 0x2400};
    $Encode::Charset::CHARSET{G96n}->{CSmule_ucs_E000}
      = {chars => 96, dimension => 2, ucs => 0xE000};
  }
}

sub designate_mule ($) {
  my $C = shift;
  #$C->{option}->{final_to_set}->{G94n}->{"\x30"} = "CSmule_big5_1";
  #$C->{option}->{final_to_set}->{G94n}->{"\x31"} = "CSmule_big5_2";
  #$C->{option}->{final_to_set}->{G94n}->{"\x32"} = "CSmule2_ethiopic";
  $C->{option}->{final_to_set}->{G94n}->{"\x33"} = "CSmule_ethiopic";
  $C->{option}->{private_set}->{G94n}->[3]->[1] = "\x33";
  $C->{option}->{final_to_set}->{G94n}->{"\x35"} = "CSmule_indian_2column";
  $C->{option}->{private_set}->{G94n}->[3]->[2] = "\x35";
  $C->{option}->{final_to_set}->{G94n}->{"\x36"} = "CSmule_indian_1column";
  $C->{option}->{private_set}->{G94n}->[3]->[3] = "\x36";
  $C->{option}->{final_to_set}->{G94n}->{"\x37"} = "CSmule_tibetan";
  $C->{option}->{private_set}->{G94n}->[3]->[4] = "\x37";
  $C->{option}->{final_to_set}->{G94n}->{"\x38"} = "CSmule_tibetan_1column";
  $C->{option}->{private_set}->{G94n}->[3]->[5] = "\x38";
  $C->{option}->{final_to_set}->{G94n}->{"\x3F"} = "CSmule_thai_xtis";
  $C->{option}->{private_set}->{G94n}->[3]->[6] = "\x3F";
  
  $C->{option}->{final_to_set}->{G94}->{"\x30"} = "CSomron_sisheng";
  $C->{option}->{private_set}->{G94}->[0] = "\x30";
  #$C->{option}->{final_to_set}->{G94}->{"\x31"} = "CSmule2_thai";
  $C->{option}->{final_to_set}->{G94}->{"\x31"} = "CSmule_lao";
  $C->{option}->{private_set}->{G94}->[1] = "\x31";
  $C->{option}->{final_to_set}->{G94}->{"\x32"} = "CSmule_arabic_digit";
  $C->{option}->{private_set}->{G94}->[2] = "\x32";
  $C->{option}->{final_to_set}->{G94}->{"\x33"} = "CSmule_arabic_1column";
  $C->{option}->{private_set}->{G94}->[3] = "\x33";
  $C->{option}->{final_to_set}->{G94}->{"\x34"} = "CSmule_arabic_2column";
  $C->{option}->{private_set}->{G94}->[4] = "\x34";
  $C->{option}->{final_to_set}->{G94}->{"\x35"} = "CSis13194";
  $C->{option}->{private_set}->{G94}->[5] = "\x35";
  
  $C->{option}->{final_to_set}->{G96}->{"\x30"} = "CSmule_ipa";
  $C->{option}->{private_set}->{G96}->[0] = "\x30";
  $C->{option}->{final_to_set}->{G96}->{"\x31"} = "CSviscii_lower";
  $C->{option}->{private_set}->{G96}->[1] = "\x31";
  $C->{option}->{final_to_set}->{G96}->{"\x32"} = "CSviscii_upper";
  $C->{option}->{private_set}->{G96}->[2] = "\x32";
  
  # 96^2 03/00 = bitmap
  $C->{option}->{final_to_set}->{G96n}->{"\x31"} = "CSmule_ucs_0100";
  $C->{option}->{private_set}->{U96n}->[0] = "\x31";
  $C->{option}->{final_to_set}->{G96n}->{"\x32"} = "CSmule_ucs_2400";
  $C->{option}->{private_set}->{U96n}->[1] = "\x32";
  $C->{option}->{final_to_set}->{G96n}->{"\x33"} = "CSmule_ucs_E000";
  $C->{option}->{private_set}->{U96n}->[2] = "\x33";
}

1;
__END__

=head1 EXAMPLE

  use Encode::Charset::Private qw(:mule);	## Load mule private charsets
  my $C = Encode::Charset->new_object;
  Encode::Charset::Private::designate_mule ($C);

=head1 LICENSE

Copyright 2002 Nanashi-san

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/10/16 10:39:05 $
