
=head1 NAME

Encode::SJIS --- Shift JIS coding systems encoder and decoder

=head1 ENCODINGS

This module defines encoding engine for Shift JIS coding systems.
This module only provides general en/decoding parts.  Actual profiles
for Shift JISes are included in Encode::SJIS::*.

=over 4

=cut

package Encode::SJIS;
use 5.7.3;
use strict;
our $VERSION=do{my @r=(q$Revision: 1.6 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
require Encode::Charset;
use base qw(Encode::Encoding);

*new_object = \&Encode::Charset::new_object_sjis;

## Code extention escape sequence defined by ISO/IEC 2022 is
## not supported in this version of this module.

sub sjis_to_internal ($$) {
  my ($s, $C) = @_;
  $C ||= &new_object;
  $s =~ s{
     ([\x00-\x7F\xA1-\xDF])
  #   ([\xA1-\xDF])
    |([\x81-\x9F\xE0-\xFC][\x40-\x7E\x80-\xFC])
    |\x1B([\x40-\x5F])
    |([\x80-\xFF])	## Broken or supplemental 1-byte character
  }{
    my ($c7, $c2, $c1, $c8) = ($1, $2, $3, $4);
    if (defined $c7) {
      if ($c7 =~ /([\x21-\x7E])/) {
        chr ($C->{ $C->{GL} }->{ucs} + ord ($1) - 0x21);
      } elsif ($c7 =~ /([\x00-\x1F])/) {
        chr ($C->{ $C->{CL} }->{ucs} + ord ($1));
      } elsif ($C->{GR} && $c7 =~ /([\xA1-\xDF])/) {
        chr ($C->{ $C->{GR} }->{ucs} + ord ($1) - 0xA1);
      } else {	## 0x20, 0x7F
        $C->{Gsmap}->{ $c7 } || $c7;
      }
    } elsif ($c2) {
      if ($c2 =~ /([\x81-\xEF])(.)/) {
        my ($f, $s) = (ord $1, ord $2);
        $f -= $f < 0xA0 ? 0x81 : 0xC1;  $s -= 0x40 + ($s > 0x7F);
        chr ($C->{G1}->{ucs} + $f * 188 + $s);
      } else {	## [\xF0-\xFC].
        my ($f, $s) = (ord substr ($c2, 0, 1), ord substr ($c2, 1, 1));
        if ($C->{G3}->{Csjis_kuE}) {	## 94^2 set with first-byte->ku mapping
          my $F = $s > 0x9E ? $C->{G3}->{Csjis_kuE}->{ $f }:	## ku of even number
                              $C->{G3}->{Csjis_kuO}->{ $f };	## ku of odd number
          if (defined $F) {
            $s -= ($s > 0x9E ? 0x9F : $s > 0x7F ? 0x41 : 0x40);
            chr ($C->{G3}->{ucs} + $F * 94 + $s);
          } else {	## Mapping is not defined
            $f -= 0xF0; $s -= 0x40 + ($s > 0x7F);
            chr ($Encode::Charset::CHARSET{G94n}->{"\x20\x40"}->{ucs} + $f * 188 + $s);
          }
        } elsif ($C->{G3}->{Csjis_ku}) {	## n^2 set with first-byte->ku mapping
          if (defined $C->{G3}->{Csjis_ku}->{ $f }) {
            $f = $C->{G3}->{Csjis_ku}->{ $f };
            $s -= ($s > 0x9E ? 0x9F : $s > 0x7F ? 0x41 : 0x40);
            chr ($C->{G3}->{ucs} + $f * $C->{G3}->{chars} + $s);
          } else {	## Mapping is not defined
            $f -= 0xF0; $s -= 0x40 + ($s > 0x7F);
            chr ($Encode::Charset::CHARSET{G94n}->{"\x20\x40"}->{ucs} + $f * 188 + $s);
          }
        } else {	## 94^2 set without special mapping information
          $f -= 0xF0; $s -= 0x40 + ($s > 0x7F);
          chr ($C->{G3}->{ucs} + $f * 188 + $s);
        }
      }
    } elsif ($c1) {	## ESC Fe
      chr ($C->{ $C->{ESC_Fe} }->{ucs} + ord ($c1) - 0x40);
    } else {	# $C8
      $C->{Gsmap}->{ $c8 } || $c8;
    }
  }gex;
  $s;
}

sub internal_to_sjis ($\%) {
  use integer;
  my ($s, $C) = @_;
  $C ||= &new_object;
  
  my $r = '';
  my @c = split //, $s;
  for my $i (0..$#c) {
    my $c = $c[$i]; my $cc = ord $c;  Encode::_utf8_off ($c);
    my $t;
    ## CL = C0 control characters
    if ($cc <= 0x1F) {
      $t = $c if $C->{ $C->{CL} } eq $Encode::Charset::CHARSET{C0}->{"\x40"};
    ## 0x20 == SP and 0x7E == DEL
    } elsif ($cc == 0x20 || $cc == 0x7F) {
      $t = $c;
    ## GL = G0 = ISO/IEC 646 graphic character set
    } elsif ($cc < 0x7F) {
      $t = $c if $C->{ $C->{GL} } eq $Encode::Charset::CHARSET{G94}->{"\x42"};
    ## 0x80
    } elsif ($C->{option}->{C1invoke_to_right} && $cc == 0x80) {
      $t = "\x80"
        if $C->{ $C->{CR} } eq $Encode::Charset::CHARSET{C1}->{'64291991C1'};
    ## ESC Fe = C1 control characters
    } elsif ($cc <= 0x9F) {
      $t = "\x1B".pack 'C', ($cc - 0x40)
        if $C->{ $C->{ESC_Fe} } eq $Encode::Charset::CHARSET{C1}->{'64291991C1'};
    ## G1 or G3 = 94^2 graphic character set from ISO-IR
    } elsif (0xE9F6C0 <= $cc && $cc <= 0xF06F80) {
      my $c = $cc - 0xE9F6C0;  my $F = chr (($c / 8836)+0x30);
      if ($C->{G1} eq $Encode::Charset::CHARSET{G94n}->{ $F }) {
        my ($c1, $c2) = ((($c % 8836) / 94)+0x21, ($c % 94)+0x21);
        $t = pack ('CC', (($c1 - 1) >> 1) + ($c1 < 0x5F ? 0x71 : 0xB1),
               $c2 + (($c1 & 1) ? ($c2 < 0x60 ? 0x1F : 0x20) : 0x7E));
      } elsif ($C->{G3} eq $Encode::Charset::CHARSET{G94n}->{ $F }) {
        my ($c1, $c2) = ((($c % 8836) / 94)+0x21, ($c % 94)+0x21);
        if ($C->{G3}->{Csjis_first}) {
          my $fb = $C->{G3}->{Csjis_first}->{ ($c % 8836) / 94 };
          $t = pack ('CC', $fb, $c2 + (($c1 & 1) ? ($c2 < 0x60 ? 0x1F : 0x20) : 0x7E)) if $fb;
        } else {
          $t = pack ('CC', ($c / 188) + 0xF0,
                     $c2 + (($c1 & 1) ? ($c2 < 0x60 ? 0x1F : 0x20) : 0x7E))
               if ($c / 188) + 0xF0 < 0xFD;
        }
      }
    ## G1 = JIS X 0208-1990/:1997
    } elsif (0xF49D7C <= $cc && $cc <= 0xF4BFFF) {
      my $c = $cc - 0xF49D7C;
      if ($C->{G1} eq $Encode::Charset::CHARSET{G94n}->{'B@'}) {
        my ($c1, $c2) = ((($c % 8836) / 94)+0x21, ($c % 94)+0x21);
        $t = pack ('CC', (($c1 - 1) >> 1) + ($c1 < 0x5F ? 0x71 : 0xB1),
               $c2 + (($c1 & 1) ? ($c2 < 0x60 ? 0x1F : 0x20) : 0x7E));
      }
    ## GL = G0 = ISO/IEC 646 graphic character set / GR = G2 = JIS X 0201 Katakana set
    } elsif (0xE90940 <= $cc && $cc <= 0xE92641) {
      my $c = $cc - 0xE90940;  my $F = chr (($c / 94)+0x30);
      if ($C->{ $C->{GL} } eq $Encode::Charset::CHARSET{G94}->{ $F }) {
        $t = pack 'C', (($c % 94) + 0x21);
      } elsif ($C->{ $C->{GR} } eq $Encode::Charset::CHARSET{G94}->{ $F }) {
        $t = pack 'C', (($c % 94) + 0xA1) if ($c % 94) < 0x3F;
      }
    ## G1 / G3 = 94^2 graphic character set
    } elsif (0x70420000 <= $cc && $cc <= 0x7046F19B) {
      my $c = $cc % 0x10000;
      my $F0=$C->{option}->{private_set}->{G94n}->[($cc/0x10000)-0x7042]->[$c/8836];
      my $F1 = 'P'.(($cc / 0x10000) - 0x7042).'_'.($c / 8836);
      if ($C->{G3} eq $Encode::Charset::CHARSET{G94n}->{ $F0 }
       || $C->{G3} eq $Encode::Charset::CHARSET{G94n}->{ $F1 }) {
        my ($c1, $c2) = ((($c % 8836) / 94)+0x21, ($c % 94)+0x21);
        if ($C->{G3}->{Csjis_first}) {
          my $fb = $C->{G3}->{Csjis_first}->{ ($c % 8836) / 94 };
          $t = pack ('CC', $fb, $c2 + (($c1 & 1) ? ($c2 < 0x60 ? 0x1F : 0x20) : 0x7E)) if $fb;
        } else {
          $t = pack ('CC', ($c / 188) + 0xF0,
                     $c2 + (($c1 & 1) ? ($c2 < 0x60 ? 0x1F : 0x20) : 0x7E))
               if ($c / 188) + 0xF0 < 0xFD;
        }
      }
    ## Non-ISO/IEC 2022 Coded Character Sets Mapping Area
    } elsif (0x71000000 <= $cc && $cc <= 0x71FFFFFF) {
      if ($C->{G3}->{ucs} <= $cc) {
        my $c = $cc - $C->{G3}->{ucs};
        my $f = $C->{G3}->{Csjis_first}->{$c / $C->{G3}->{chars}};
        if ($f) {
          my $s = $c % $C->{G3}->{chars};
          $t = pack ('CC', $f, 0x40 + $s + ($s > 62));
        }
      }
    ## Other character sets are not supported now (and there is no plan to implement them).
    }
    
    ## Output the character itself
    if (defined $t) {
      $r .= $t;
    ## Output the character itself with mapping table of special code positions
    } elsif ($C->{GsmapR}->{ $c }) {
      $r .= $C->{GsmapR}->{ $c };
    } elsif ($C->{option}->{fallback_from_ucs} =~ /quiet/) {
      return ($r, halfway => 1, converted_length => $i,
              warn => $C->{option}->{fallback_from_ucs} =~ /warn/ ? 1 : 0,
              reason => sprintf (q(U+%04X: There is no character mapped to), $cc));
    } elsif ($C->{option}->{fallback_from_ucs} eq 'croak') {
      return ($r, halfway => 1, die => 1,
              reason => sprintf (q(U+%04X: There is no character mapped to), $cc));
    ## 
    } else {
      ## Try to output with fallback escape sequence (if specified)
      my $t = Encode::Charset->fallback_escape ($C, $c);
      if (defined $t) {
        my %D = (fallback => $C->{option}->{fallback_from_ucs}, reset => $C->{option}->{reset});
        $C->{option}->{fallback_from_ucs} = 'croak';
        eval q{$t = $C->{_encoder}->_encode_internal ($t, $C)} or undef $t;
        $C->{option}->{fallback_from_ucs} = $D{fallback};
      }
      if (defined $t) {
        $r .= $t;
      } else {	## Replacement character specified in charset definition
        $r .= $C->{option}->{undef_char_sjis} || "\x3F";
      }
    }
  }
  $r;
}

sub page_to_internal ($$) {
  my ($C, $s) = @_;
  $s = pack ('U*', unpack ('C*', $s));
  $s =~ s(\x1B\x24([EFGOPQ])([\x21-\x7E]+)\x0F)(
    my $page = {qw/E 1 F 2 G 3 O 4 P 5 Q 6/}->{$1};
    my $r = '';
    for my $c (split //, $2) {
      $r .= chr ($Encode::Charset::CHARSET{G94}->{'CSpictogram_page_'.$page}->{ucs} + ord ($c) - 0x21);
    }
    $r;
  )gex;
  $s;
}

sub _internal_to_page ($$$%) {
  my ($yourself, $C, $c, $option) = @_;
  my $cc = ord $c;
  for my $page (1..6) {
    my $cs = $Encode::Charset::CHARSET{G94}->{'CSpictogram_page_'.$page};
    if ($cs->{ucs} <= $cc && $cc < $cs->{ucs} + $cs->{chars} * $cs->{dimension}) {
      return "\x1B\x24" . ([qw/_ E F G O P Q/]->[$page])
            .pack ('C', 0x21 + $cc - $cs->{ucs}) . "\x0F";
    }
  }
  ## $c is not a pictogram
  $option->{fallback_from_ucs} = $C->{option}->{fallback_from_ucs_2};
  $yourself->fallback_escape ($C, $c, %$option);
}

=back

=head1 SEE ALSO

JIS X 0208:1997, "7-bit and 8-bit double byte coded Kanji
set for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 1997.

JIS X 0213:2000, "7-bit and 8-bit double byte coded extended Kanji
sets for information interchange", Japan Industrial Standards
Committee (JISC) <http://www.jisc.go.jp/>, 2000.

L<Encode::SJIS::JIS>

L<Encode>, L<perlunicode>

L<Encode::Charset>, L<Encode::ISO2022>

=head1 LICENSE

Copyright 2002 Nanashi-san <nanashi-san@nanashi.invalid>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1; # $Date: 2002/12/18 10:21:09 $
