
=head1 NAME

Encode::ISO2022 --- ISO/IEC 2022 encoder and decoder

=head1 ENCODINGS

=over 4

=item iso2022

ISO/IEC 2022:1994.  Default status is:

=over 2

=item CL = C0 = ISO/IEC 6429:1991 C0 set

=item CR = C1 = ISO/IEC 6429:1991 C1 set

=item GL = G0 = ISO/IEC 646:1991 IRV GL(G0) set

=item GR = G1 = empty set

=item G2 = empty set

=item G3 = empty set

=back

(Alias: iso/iec2022, iso-2022, 2022, cp2022)

=back

Note that ISO/IEC 2022 based encodings are found in
Encode::ISO2022::* modules.  This module, Encode::ISO2022
only provides a general ISO/IEC 2022 encoder/decoder.

=cut

require v5.7.3;
package Encode::ISO2022;
use strict;
use vars qw(%CHARSET %CODING_SYSTEM $VERSION);
$VERSION=do{my @r=(q$Revision: 1.14 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw!iso-2022 iso/iec2022 iso2022 2022 cp2022!);
require Encode::Charset;
	*CHARSET = \%Encode::Charset::CHARSET;
	*CODING_SYSTEM = \%Encode::Charset::CODING_SYSTEM;

### --- Perl Encode module common functions

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str = &internal_to_iso2022 ($str);
  return $str;
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  return &iso2022_to_internal ($str);
}

### --- Encode::ISO2022 unique functions
*new_object = \&Encode::Charset::new_object;

sub iso2022_to_internal ($;%) {
  my ($s, $C) = @_;
  $C ||= &new_object;
  my $t = '';
  $s =~ s{^((?:(?!\x1B\x25\x2F?[\x30-\x7E]).)*)}{
    my $i2 = $1;
    $t = _iso2022_to_internal ($i2, $C);
    '';
  }es;
  my $pad = '';
  use re 'eval';
  $s =~ s{
     ## ISO/IEC 2022
      (??{"$pad\x1B$pad\x25$pad\x40"})((?:(?!\x1B\x25\x2F?[\x30-\x7E]).)*)
     ## UTF-8
     |(??{"$pad\x1B$pad\x25$pad(?:\x47|\x2F$pad"."[\x47-\x49])"})
       ((?:(?!\x1B\x25\x2F?[\x30-\x7E]).)*)
     ## UCS-2, UTF-16
     |(??{"$pad\x1B$pad\x25$pad\x2F$pad"})([\x40\x43\x45\x4A-\x4C])
       ((?:(?!\x00\x1B\x00\x25(?:\x00\x2F)?\x00[\x30-\x7E])..)*)
     ## UCS-4
     |(??{"$pad\x1B$pad\x25$pad\x2F$pad"})[\x41\x44\x46]
       ((?:(?!\x00\x00\x00\x1B\x00\x00\x00\x25(?:\x00\x00\x00\x2F)?
           \x00\x00\x00[\x30-\x7E])....)*)
     ## with standard return
     |(??{"$pad\x1B$pad\x25$pad"})([\x30-\x7E])
       ((?:(?!\x1B\x25\x2F?[\x30-\x7E]).)*)
     ## without standard return
     |(??{"$pad\x1B$pad\x25$pad\x2F$pad"})([\x30-\x7E])(.*)
  }{
    my ($i2,$u8,$Fu2,$u2,$u4,$Fsr,$sr,$Fnsr,$nsr) = ($1,$2,$3,$4,$5,$6,$7,$8,$9);
    my $r = '';
    if (defined $i2) {
      $r = _iso2022_to_internal ($i2, $C);  $pad = '';
    } elsif (defined $u8) {
      $r = Encode::decode ('utf8', $u8);  $pad = '';
    } elsif ($Fu2) {
      if (ord ($Fu2) > 0x49) {
        $r = Encode::decode ('utf-16be', $u2);
      } else {
        $r = Encode::decode ('ucs-2be', $u2);
      }
      $pad = "\x00";
    } elsif (defined $u4) {
      $r = Encode::decode ('ucs-4be', $u2);  $pad = "\x00\x00\x00";
    } elsif (defined $Fsr && $CODING_SYSTEM{$Fsr}->{perl_name}) {
      $r = Encode::decode ($CODING_SYSTEM{$Fsr}->{perl_name}, $sr);  $pad = '';
    } elsif (defined $Fnsr && $CODING_SYSTEM{$Fnsr}->{perl_name}) {
      $r = Encode::decode ($CODING_SYSTEM{$Fnsr}->{perl_name}, $nsr);  $pad = '';
    } else {	## temporary
      $r = '?' x length ($sr.$nsr);  $pad = '';
    }
    $r;
  }gesx;
  $t . $s;
}

# this is very very trickey.  my perl 5.8.0 does not process
# regex with eval except the first time (i think it's a bug
# of perl), so we redefine this function whenever being called!
# when this unexpected behavior is fixed or someone finds
# better way to avoid it, we will rewrite this code.
&_iso2022_to_internal (undef);
sub _iso2022_to_internal ($;%) {
  eval q{ sub __iso2022_to_internal ($;%) { 0 } };
  eval q{
sub __iso2022_to_internal ($;%) {
  use re 'eval';
  my ($s, $C) = @_;
  my %_GB_to_GN = (
    "\x28"=>'G0',"\x29"=>'G1',"\x2A"=>'G2',"\x2B"=>'G3',
    "\x2C"=>'G0',"\x2D"=>'G1',"\x2E"=>'G2',"\x2F"=>'G3',
  );
  my %_CHARS_to_RANGE = (
	l94	=> q/[\x21-\x7E]/,	l96	=> q/[\x20-\x7F]/,
	l128	=> q/[\x00-\x7F]/,	l256	=> q/[\x00-\xFF]/,
	r94	=> q/[\xA1-\xFE]/,	r96	=> q/[\xA0-\xFF]/,
	r128	=> q/[\x80-\xFF]/,	r256	=> q/[\x80-\xFF]/,
	b94	=> q/[\x21-\x7E\xA1-\xFE]/,	b96	=> q/[\x20-\x7F\xA0-\xFF]/,
	b128	=> q/[\x00-\xFF]/,	b256	=> q/[\x00-\xFF]/,
  );
  
  $s =~ s{
     ((??{ $_CHARS_to_RANGE{'l'.$C->{$C->{GL}}->{chars}}
         . qq/{$C->{$C->{GL}}->{dimension},$C->{$C->{GL}}->{dimension}}/ }))
    |((??{ $_CHARS_to_RANGE{'r'.$C->{$C->{GR}}->{chars}}
         . qq/{$C->{$C->{GR}}->{dimension},$C->{$C->{GR}}->{dimension}}/  }))
    |  (??{ q/(?:/ . ($C->{$C->{CR}}->{r_SS2} || '(?!)')
             . ($C->{$C->{ESC_Fe}}->{r_SS2_ESC} ?
                 qq/|$C->{$C->{ESC_Fe}}->{r_SS2_ESC}/ : '')
             . ($C->{$C->{CL}}->{r_SS2} ? qq/|$C->{$C->{CL}}->{r_SS2}/ : '') . q/)/
          . (  $C->{$C->{CL}}->{r_LS0}
             ||$C->{$C->{CL}}->{r_LS1}?	## ISO/IEC 6429:1992 9
             qq/[$C->{$C->{CL}}->{r_LS0}$C->{$C->{CL}}->{r_LS1}]*/:'')
        })
      ((??{ $_CHARS_to_RANGE{'b'.$C->{G2}->{chars}}
         . qq/{$C->{G2}->{dimension},$C->{G2}->{dimension}}/ }))
    |  (??{ q/(?:/ . ($C->{$C->{CR}}->{r_SS3} || '(?!)')
             . ($C->{$C->{ESC_Fe}}->{r_SS3_ESC} ?
                qq/|$C->{$C->{ESC_Fe}}->{r_SS3_ESC}/ : '')
             . ($C->{$C->{CL}}->{r_SS3} ? qq/|$C->{$C->{CL}}->{r_SS3}/ : '') . q/)/
          . (  $C->{$C->{CL}}->{r_LS0}
            || $C->{$C->{CL}}->{r_LS1}?	## ISO/IEC 6429:1992 9
             qq/[$C->{$C->{CL}}->{r_LS0}$C->{$C->{CL}}->{r_LS1}]*/:'')
        })
      ((??{ $_CHARS_to_RANGE{'b'.$C->{G3}->{chars}}
            . qq/{$C->{G3}->{dimension},$C->{G3}->{dimension}}/ }))
    
    ## Locking shift
    |(  (??{ $C->{$C->{CL}}->{r_LS0}||'(?!)' })
       |(??{ $C->{$C->{CL}}->{r_LS1}||'(?!)' })
     )
    
    ## Control sequence
    |(??{ '(?:'.($C->{$C->{CR}}->{r_CSI}||'(?!)')
               .($C->{$C->{ESC_Fe}}->{r_CSI_ESC} ?
                 qq/|$C->{$C->{ESC_Fe}}->{r_CSI_ESC}/: '')
          .')'
        })
    ((??{ qq/[\x30-\x3F$C->{$C->{CL}}->{LS0}$C->{$C->{CL}}->{LS1}\xB0-\xBF]*/
         .qq/[\x20-\x2F$C->{$C->{CL}}->{LS0}$C->{$C->{CL}}->{LS1}\xA0-\xAF]*/
        }) [\x40-\x7E\xD0-\xFE])
    
    ## Other escape sequence
    |(\x1B[\x20-\x2F]*[\x30-\x7E])
    
    ## Misc. sequence (SP, control, or broken data)
    |([\x00-\xFF])
  }{
    my ($gl,$gr,$ss2,$ss3,$ls,$csi,$esc,$misc)
      = ($1,$2,$3,$4,$5,$6,$7,$8,$9);
    $C->{_irr} = undef unless defined $esc;
    ## GL graphic character
    if (defined $gl) {
      my $c = 0;
      my $m = $C->{$C->{GL}}->{chars}==94?0x21:$C->{$C->{GL}}->{chars}==96?0x20:0;
      for (split //, $gl) {
        $c = $c * $C->{$C->{GL}}->{chars} + unpack ('C', $_) - $m;
      }
      chr ($C->{$C->{GL}}->{ucs} + $c);
    ## GR graphic character
    } elsif ($gr) {
      my $c = 0;
      my $m = $C->{$C->{GR}}->{chars}==94?0xA1:$C->{$C->{GR}}->{chars}==96?0xA0:0x80;
      for (split //, $gr) {
        $c = $c * $C->{$C->{GR}}->{chars} + unpack ('C', $_) - $m;
      }
      chr ($C->{$C->{GR}}->{ucs} + $c);
    ## Control, SP, or broken data
    ## TODO: support control sets other than ISO/IEC 6429's
    } elsif (defined $misc) {
      $misc;
    ## Graphic character with SS2
    } elsif ($ss2) {
      $ss2 =~ tr/\x80-\xFF/\x00-\x7F/;
      my $c = 0;  my $m = $C->{G2}->{chars}==94?0x21:$C->{G2}->{chars}==96?0x20:0;
      for (split //, $ss2) {
        $c = $c * $C->{G2}->{chars} + unpack ('C', $_) - $m;
      }
      chr ($C->{G2}->{ucs} + $c);
    ## Graphic character with SS3
    } elsif ($ss3) {
      $ss3 =~ tr/\x80-\xFF/\x00-\x7F/;
      my $c = 0;  my $m = $C->{G3}->{chars}==94?0x21:$C->{G3}->{chars}==96?0x20:0;
      for (split //, $ss3) {
        $c = $c * $C->{G3}->{chars} + unpack ('C', $_) - $m;
      }
      chr ($C->{G3}->{ucs} + $c);
    ## Escape sequence
    } elsif ($esc) {
      if ($esc =~ /\x1B\x26([\x40-\x7E])/) {	## 6F (IRR) = ESC 02/06 Ft
        $C->{_irr} = $1;  $esc = '';
      } else {
        $esc =~ s{
           \x1B([\x28-\x2B])(\x20?[\x21-\x23]?[\x30-\x7E])	## Gx = 94^1
          |\x1B\x24([\x28-\x2B]?)(\x20?[\x21-\x23]?[\x30-\x7E])	## Gx = 94^n
          
          |\x1B([\x2C-\x2F])(\x20?[\x21-\x23]?[\x30-\x7E])	## Gx = 96^1
          |\x1B\x24([\x2C-\x2F])(\x20?[\x21-\x23]?[\x30-\x7E])	## Gx = 96^n
          
          |\x1B([\x40-\x5F])	## ESC Fe
          
          |\x1B\x21([\x21-\x23]?[\x30-\x7E])	## CL = C0
          |\x1B\x22([\x21-\x23]?[\x30-\x7E])	## CR & ESC Fe = C1
          
          |\x1B([\x60-\x7E])	## Single control functions
          |\x1B\x23([\x21-\x23]?)([\x30-\x7E])
          
          |\x1B\x20([\x40-\x7E])	## Announcer
        }{
          my ($g94_g,$g94_f,$g94n_g,$g94n_f,$g96_g,$g96_f,$g96n_g,$g96n_f,$Fe,
              $CZD, $C1D, $Fs, $sI, $sF,$ACS)
              = ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15);
          my $rev = $C->{_irr} || '';
          my $f2s = $C->{option}->{final_to_set};
          if ($g94_g) {	## ESC 02/08 [I] F
            $C->{ $_GB_to_GN{ $g94_g } }
              =    $CHARSET{G94}->{ $f2s->{G94}->{$g94_f.$rev} || $g94_f.$rev }
                || $CHARSET{G94}->{ $f2s->{G94}->{$g94_f} || $g94_f }
                || $CHARSET{G94}->{ "\x7E" }; '';
          } elsif (defined $g94n_f) {	## ESC 02/04 [02/08..11] [I] F
            $C->{ $_GB_to_GN{ $g94n_g } || 'G0' }
              =    $CHARSET{G94n}->{ $f2s->{G94n}->{$g94n_f.$rev} || $g94n_f.$rev }
                || $CHARSET{G94n}->{ $f2s->{G94n}->{$g94n_f} || $g94n_f }
                || $CHARSET{G94n}->{ "\x7E" }; '';
          } elsif ($g96_g) {	## ESC 02/12..15 [I] F
            $C->{ $_GB_to_GN{ $g96_g } }
              =    $CHARSET{G96}->{ $f2s->{G96}->{$g96_f.$rev} || $g96_f.$rev }
                || $CHARSET{G96}->{ $f2s->{G96}->{$g96_f} || $g96_f }
                || $CHARSET{G96}->{ "\x7E" }; '';
          } elsif ($g96n_g) {	## ESC 02/04 02/12..15 [I] F
            $C->{ $_GB_to_GN{ $g96n_g } }
              =    $CHARSET{G96n}->{ $f2s->{G96n}->{$g96n_f.$rev} || $g96n_f.$rev }
                || $CHARSET{G96n}->{ $f2s->{G96n}->{$g96n_f} || $g96n_f }
                || $CHARSET{G96n}->{ "\x7E" }; '';
          } elsif ($Fe) {	## ESC Fe = C1
            chr ($C->{ $C->{ESC_Fe} }->{ucs} + (ord ($Fe) - 0x40));
          } elsif (defined $Fs) {	## ESC Fs
            if ($Fs eq "\x6E") {	## LS2
              $C->{GL} = 'G2'; '';
            } elsif ($Fs eq "\x6F") {	## LS3
              $C->{GL} = 'G3'; '';
            } elsif ($Fs eq "\x7E" || $Fs eq "\x6B") {	## LS1R
              $C->{GR} = 'G1';  $C->{GL} = 'G1' if $C->{bit} == 7; '';
            } elsif ($Fs eq "\x7D" || $Fs eq "\x6C") {	## LS2R
              $C->{GR} = 'G2';  $C->{GL} = 'G2' if $C->{bit} == 7; '';
            } elsif ($Fs eq "\x7C" || $Fs eq "\x6D") {	## LS3R
              $C->{GR} = 'G3';  $C->{GL} = 'G3' if $C->{bit} == 7; '';
            } else {
              chr ($CHARSET{single_control}->{Fs}->{ucs} + (ord ($Fs) - 0x60));
            }
          } elsif (defined $CZD) {	## 1F (CZD) = ESC 02/01 [I] F
            $C->{C0} = $CHARSET{C0}->{ $f2s->{C0}->{$CZD.$rev} || $CZD.$rev }
                    || $CHARSET{C0}->{ $f2s->{C0}->{$CZD} || $CZD }
                    || $CHARSET{C0}->{ "\x7E" }; '';
          } elsif (defined $C1D) {	## 2F (C1D) = ESC 02/02 [I] F
            $C->{C1} = $CHARSET{C1}->{ $f2s->{C1}->{$C1D.$rev} || $C1D.$rev }
                    || $CHARSET{C1}->{ $f2s->{C1}->{$C1D} || $C1D }
                    || $CHARSET{C1}->{ "\x7E" }; '';
          } elsif ($sI) {	## 3F = ESC 02/03 [I] F
            chr ($CHARSET{single_control}->{'3F'.$sI}->{ucs} + (ord ($sF) - 0x30));
          } elsif ($ACS) {	## 0F (Announcer) = ESC 02/00 F
            if ($ACS eq "\x4A") { $C->{bit} = 7 }
            elsif ($ACS eq "\x4B") { $C->{bit} = 8 }
            '';
          }
        }gex;
        $C->{_irr} = undef;
      }
      $esc;
    } elsif ($ls) {	## Locking shifts = LS0 / LS1
      if ($ls eq $C->{$C->{CL}}->{LS0}) {
        $C->{GL} = 'G0'; '';
      } elsif ($ls eq $C->{$C->{CL}}->{LS1}) {
        $C->{GL} = 'G1'; '';
      }
    } elsif ($csi) {	## Control sequence = CSI [P..] [I] F
      $csi =~ tr/\xA0-\xFF/\x20-\x7F/d;
      $csi =~ s/$C->{$C->{CL}}->{LS0}//g if $C->{$C->{CL}}->{LS0};
      $csi =~ s/$C->{$C->{CL}}->{LS1}//g if $C->{$C->{CL}}->{LS1};
      "\x9B".$csi;
    }
  }gesx;
  $s;
} # __iso2022_to_internal

  };
  &__iso2022_to_internal (@_) if defined $_[0];

} # _iso2022_to_internal

sub internal_to_iso2022 ($;%) {
  my ($s, $C) = @_;
  $C ||= &new_object;
  
  my $r = '';
  my @c = split //, $s;
  for my $i (0..$#c) {
    my $c = $c[$i]; my $cc = ord $c;  Encode::_utf8_off ($c);
    my $t;
    if ($cc <= 0x1F) {
      $t = _i2c ($c, $C, type => 'C0', charset => '@');
    } elsif ($cc == 0x20 || $cc == 0x7F) {
      $t = _back2ascii ($C) . $c;
    } elsif ($cc < 0x7F) {
      $t = _i2g ($c, $C, type => 'G94', charset => 'B');
    } elsif ($cc <= 0x9F) {
      $t = _i2c (pack ('C', $cc), $C, type => 'C1', charset_id => '64291991C1',
        charset => $C->{option}->{private_set}->{XC1}->{'64291991C1'});
    } elsif ($cc <= 0xFF) {
      $t = _i2g (pack ('C', $cc-0x80), $C, type => 'G96', charset => 'A');
    } elsif ($cc <= 0x24FF) {
      my $c = $cc - 0x100;
      my $final = $C->{option}->{private_set}->{U96n}->[0];
      if (length $final) {
        $t = _i2g (chr(($c / 96)+0x20).chr(($c % 96)+0x20), $C,
          type => 'G96n', charset => $final);
      }
    } elsif ($cc <= 0x33FF) {
      my $c = $cc - 0x2500;
      my $final = $C->{option}->{private_set}->{U96n}->[1];
      if (length $final) {
        $t = _i2g (chr(($c / 96)+0x20).chr(($c % 96)+0x20), $C,
          type => 'G96n', charset => $final);
      }
    } elsif (0xE000 <= $cc && $cc <= 0xFFFF) {
      my $c = $cc - 0xE000;
      my $final = $C->{option}->{private_set}->{U96n}->[2];
      if (length $final) {
        $t = _i2g (chr(($c / 96)+0x20).chr(($c % 96)+0x20), $C,
          type => 'G96n', charset => $final);
      }
    
    } elsif (0xE9F6C0 <= $cc && $cc <= 0xF06F80) {
      my $c = $cc - 0xE9F6C0;
      $t = _i2g (chr((($c % 8836) / 94)+0x21).chr(($c % 94)+0x21), $C,
        type => 'G94n', charset => chr(($c / 8836)+0x30));
    } elsif (0xF49D7C <= $cc && $cc <= 0xF4BFFF) {
      my $c = $cc - 0xF49D7C;
      $t = _i2g (chr(($c / 94)+0x21).chr(($c % 94)+0x21), $C,
        type => 'G94n', charset => 'B', revision => '@');
    
    } elsif (0xF0000 <= $cc && $cc <= 0x10F7FF) {
      my $c = $cc - 0xF0000;
      $t = _i2g (chr((($c % 9216) / 96)+0x20).chr(($c % 96)+0x20), $C,
        type => 'G96n', charset => "\x20".chr(($c / 9216)+0x40));
    } elsif (0xE90940 <= $cc && $cc <= 0xE92641) {
      my $c = $cc - 0xE90940;
      $t = _i2g (chr(($c % 94)+0x21), $C,
        type => 'G94', charset => chr(($c / 94)+0x30));
    } elsif (0xE92642 <= $cc && $cc <= 0xE9269F) {
      my $c = $cc - 0xE92642;
      $t = _i2g (chr($c+0x21),$C,type => 'G94', charset => "\x64", revision => '@');
    } elsif (0xE926A0 <= $cc && $cc <= 0xE9443F) {
      my $c = $cc - 0xE926A0;
      $t = _i2g (chr(($c % 96)+0x20), $C,
        type => 'G96', charset => chr(($c / 96)+0x30));
    } elsif (0xE944A0 <= $cc && $cc <= 0xE961A1) {
      my $c = $cc - 0xE944A0;
      $t = _i2g (chr(($c % 94)+0x21), $C,
        type => 'G94', charset => '!'.chr(($c / 94)+0x30));
    } elsif (0xE96200 <= $cc && $cc <= 0xE97F9F) {
      my $c = $cc - 0xE96200;
      $t = _i2g (chr(($c % 96)+0x20), $C,
        type => 'G96', charset => '!'.chr(($c / 96)+0x30));
    } elsif (0xE98000 <= $cc && $cc <= 0xE99D01) {
      my $c = $cc - 0xE98000;
      $t = _i2g (chr(($c % 94)+0x21), $C,
        type => 'G94', charset => '"'.chr(($c / 94)+0x30));
    } elsif (0xE99D60 <= $cc && $cc <= 0xE9BAFF) {
      my $c = $cc - 0xE99D60;
      $t = _i2g (chr(($c % 96)+0x20), $C,
        type => 'G96', charset => '"'.chr(($c / 96)+0x30));
    } elsif (0xE9BB60 <= $cc && $cc <= 0xE9D861) {
      my $c = $cc - 0xE9BB60;
      $t = _i2g (chr(($c % 94)+0x21), $C,
        type => 'G94', charset => '#'.chr(($c / 94)+0x30));
    } elsif (0xE9D8C0 <= $cc && $cc <= 0xE9F65F) {
      my $c = $cc - 0xE9D8C0;
      $t = _i2g (chr(($c % 96)+0x20), $C,
        type => 'G96', charset => '#'.chr(($c / 96)+0x30));
    } elsif (0x70090940 <= $cc && $cc <= 0x70092641) {
      my $c = $cc - 0x70090940;
      $t = _i2g (chr(($c % 94)+0x21), $C,
        type => 'G94', charset => "\x20".chr(($c / 94)+0x30));
    } elsif (0x700926A0 <= $cc && $cc <= 0x7009443F) {
      my $c = $cc - 0x700926A0;
      $t = _i2g (chr(($c % 96)+0x20), $C,
        type => 'G96', charset => "\x20".chr(($c / 96)+0x30));
    ## TODO: DRCS with I byte: U+700944A0-U+7009F6BF
    } elsif (0x70400000 <= $cc && $cc <= 0x7040FFED) {
      my $c = $cc - 0x70400000;
      $t = _i2g (chr(($c % 94)+0x21), $C, charset_id => 'P'.int ($c / 94),
          type => 'G94', charset => $C->{option}->{private_set}->{G94}->[ $c / 94 ]);
    } elsif (0x70410000 <= $cc && $cc <= 0x7041FFBF) {
      my $c = $cc - 0x70410000;
      $t = _i2g (chr(($c % 96)+0x20), $C, charset_id => 'P'.int ($c / 96),
          type => 'G96', charset => $C->{option}->{private_set}->{G96}->[ $c / 96 ]);
    } elsif (0x70420000 <= $cc && $cc <= 0x7046F19B) {
      my $c = $cc % 0x10000;
      $t = _i2g (chr((($c % 8836) / 94)+0x21).chr(($c % 94)+0x21), $C,
          type => 'G94n',
          charset_id => 'P'.int(($cc / 0x10000) - 0x7042).'_'.int($c / 8836),
          charset => $C->{option}->{private_set}->{G94n}
                       ->[ ($cc / 0x10000) - 0x7042 ]->[ $c / 8836 ]);
    }
    if (defined $t) {
      ## Back to ISO/IEC 2022 if necessary
      $t = _i2o ($t, $C, cs_F => "\x40")
        if $C->{coding_system} ne $CODING_SYSTEM{"\x40"};
    } else {
      ## Output in UCS-n or UTF-n if character can't be represented in ISO/IEC 2022
      my $F;  my @F = qw~G /G /H /I  B  /A /D /F~;
      push @F, qw~/J /K /L~ if $cc <= 0x10FFFF;
      push @F, qw~/@ /C /E~ if $cc <= 0xFFFF;
      for (@F) {
        if (defined $C->{option}->{designate_to}->{coding_system}->{$_}
            && $C->{option}->{designate_to}->{coding_system}->{$_} > -1) {
          $F = $_; last;
        } elsif ($C->{option}->{designate_to}->{coding_system}->{default} > -1) {
          $F = $_; last;
        }
      }
      $t = _i2o ($c, $C, cs_F => $F) if $F;
    }
    if (defined $t) {	## Output the character itself
      $r .= $t;
    } elsif ($C->{option}->{fallback_from_ucs} =~ /quiet/) {
      $r .= _back2ascii ($C) if $C->{option}->{fallback_from_ucs} =~ /back/;
      return ($r, halfway => 1, converted_length => $i,
              warn => $C->{option}->{fallback_from_ucs} =~ /warn/ ? 1 : 0,
              reason => sprintf (q(U+%04X: There is no character mapped to), $cc));
    } elsif ($C->{option}->{fallback_from_ucs} eq 'croak') {
      return ($r, halfway => 1, die => 1,
              reason => sprintf (q(U+%04X: There is no character mapped to), $cc));
    } else {
      ## Try to output with fallback escape sequence (if specified)
      my $t = Encode::Charset->fallback_escape ($C, $c);
      if (defined $t) {
        my %D = (fallback => $C->{option}->{fallback_from_ucs}, reset => $C->{option}->{reset});
        $C->{option}->{fallback_from_ucs} = 'croak';
        $C->{option}->{reset} = {Gdesignation => 0, Ginvoke => 0};
        eval q{$t = $C->{_encoder}->_encode_internal ($t, $C)} or undef $t;
        $C->{option}->{fallback_from_ucs} = $D{fallback};
        $C->{option}->{reset} = $D{reset};
      }
      if (defined $t) {
        $r .= $t;
      } else {	## Replacement character specified in charset definition
        unless ($C->{option}->{undef_char}->[0] eq "\x20") {	## A graphic character
          $t = _i2g ($C->{option}->{undef_char}->[0], $C,
                      %{ $C->{option}->{undef_char}->[1] });
        } else {	## SPACE
          $t = _back2ascii ($C) . "\x20";
        }
        $r .= $C->{coding_system} eq $CODING_SYSTEM{"\x40"} ?
              $t : _i2o ($t, $C, cs_F => "\x40");
      }
    }
  }
  ($r . _back2ascii ($C));	## Back to ASCII at the end of document if specified
}

## $O{charset} eq undef means that charset is same as the current designated one.
sub _i2c ($%%) {
  my ($s, $C, %O) = @_;
  my $r = '';
  if ($O{type} eq 'C0') {
    if (defined $O{charset}) {
      if ( $C->{C0} ne $CHARSET{C0}->{$O{charset}}
        && $C->{C0} ne $CHARSET{C0}->{$O{charset_id}}) {
        for ($C->{option}->{designate_to}->{C0}->{$O{charset}},
             $C->{option}->{designate_to}->{C0}->{default}) {
          if (defined $_) { return undef if $_ == -1;  last }
        }
        $r .= "\x1B\x21".$O{charset};
        $C->{C0} = $CHARSET{C0}->{$O{charset}};
      }
    } elsif (defined $O{charset_id}) {
      if ($C->{C0} ne $CHARSET{C0}->{$O{charset_id}}) {
        return undef;  ## Control set is not designated nor has F byte
      }
    }
    $r .= _back2ascii ($C, reset_all => $C->{C0}->{reset_all}->{$s});
    return $r . $s;
  } elsif ($O{type} eq 'C1') {
    if (defined $O{charset}) {
      if ( $C->{C1} ne $CHARSET{C1}->{$O{charset}}
        && $C->{C1} ne $CHARSET{C1}->{$O{charset_id}}) {
        for ($C->{option}->{designate_to}->{C1}->{$O{charset}},
             $C->{option}->{designate_to}->{C1}->{default}) {
          if (defined $_) { return undef if $_ == -1;  last }
        }
        $r .= "\x1B\x22".$O{charset};
        $C->{C1} = $CHARSET{C1}->{$O{charset}};
      }
    } elsif (defined $O{charset_id}) {
      if ($C->{C1} ne $CHARSET{C1}->{$O{charset_id}}) {
        return undef;  ## Control set is not designated nor has F byte
      }
    }
    $r .= _back2ascii ($C, reset_all => $C->{C1}->{reset_all}->{$s});
    unless ($C->{option}->{C1invoke_to_right}) {	## ESC Fe
      $s =~ s/([\x80-\x9F])/"\x1B" . pack ('C', ord ($1) - 0x40)/ge;
    }
    return $r . $s;
  }
}
sub _i2g ($%%) {
  my ($s, $C, %O) = @_;
  my $r = '';
  my $set = $CHARSET{$O{type}}->{$O{charset}.
    ($O{revision}&&$C->{option}->{use_revision}?$O{revision}:'')};
  my $set0 = $CHARSET{$O{type}}->{$O{charset_id}};
  ## -- designate character set
  my $G = 0;
  if ($C->{G0} eq $set || $C->{G0} eq $set0) { $G = 0 }
  elsif ($C->{G1} eq $set || $C->{G1} eq $set0) { $G = 1 }
  elsif ($C->{G2} eq $set || $C->{G2} eq $set0) { $G = 2 }
  elsif ($C->{G3} eq $set || $C->{G3} eq $set0) { $G = 3 }
  else {
    return undef unless $set;	## charset does not have F byte
    $G = 1 if $O{type} eq 'G96' || $O{type} eq 'G96n';
    for ($C->{option}->{designate_to}->{$O{type}}->{$O{charset}},
         $C->{option}->{designate_to}->{$O{type}}->{default}) {
      if (defined $_) {
        $G = $_; last;
      }
    }
    if ($G == -1) {
      return undef;
    }
    if ($O{type} eq 'G94') {
      $r .= ($O{revision}&&$C->{option}->{use_revision}?"\x1B\x26".$O{revision}:'')
         ."\x1B".("\x28","\x29","\x2A","\x2B")[$G].$O{charset};
    } elsif ($O{type} eq 'G94n') {
      if ($G == 0 && !$C->{option}->{G94n_designate_long}
        && ($O{charset} eq '@' || $O{charset} eq 'A' || $O{charset} eq 'B')) {
        $r .= ($O{revision}&&$C->{option}->{use_revision}?"\x1B\x26".$O{revision}:'')
           ."\x1B\x24".$O{charset};
      } else {
        $r .= ($O{revision}&&$C->{option}->{use_revision}?"\x1B\x26".$O{revision}:'')
           ."\x1B\x24".("\x28","\x29","\x2A","\x2B")[$G].$O{charset};
      }
    } elsif ($O{type} eq 'G96') {
      $r .= ($O{revision}&&$C->{option}->{use_revision}?"\x1B\x26".$O{revision}:'')
         ."\x1B".("\x2C","\x2D","\x2E","\x2F")[$G].$O{charset};
    } elsif ($O{type} eq 'G96n') {
      $r .= ($O{revision}&&$C->{option}->{use_revision}?"\x1B\x26".$O{revision}:'')
         ."\x1B\x24".("\x2C","\x2D","\x2E","\x2F")[$G].$O{charset};
    }
    $C->{'G'.$G} = $CHARSET{$O{type}}->{$O{charset}};
  }
  ## -- invoke G buffer
  my $left = $C->{option}->{Ginvoke_to_left}->[$G];
  if ($C->{GL} eq 'G'.$G) {
    $left = 1;
  } elsif ($C->{GR} eq 'G'.$G) {
    $left = 0;
  } else {
    if ($C->{option}->{Ginvoke_by_single_shift}->[$G]) {
      if ($C->{C1}->{'C_SS'.$G}) {
        $r .= _i2c ($C->{C1}->{'C_SS'.$G}, $C, type => 'C1') || return undef;
      } elsif ($C->{C0}->{'C_SS'.$G}) {
        $r .= _i2c ($C->{C0}->{'C_SS'.$G}, $C, type => 'C0') || return undef;
      } else {	## Both C0 and C1 set do not have SS2/3.
        $left = 0 if $G == 1 && !$C->{C0}->{C_LS1};
        $r .= __invoke ($C, $G => $left) if $C->{$left?'GL':'GR'} ne 'G'.$G;
      }
    } else {
      $left = 0 if $G == 1 && !$C->{C0}->{C_LS1};
      $r .= __invoke ($C, $G => $left) if $C->{$left?'GL':'GR'} ne 'G'.$G;
    }
  }
  $s =~ tr/\x00-\x7F/\x80-\xFF/ unless $left;
  $r . $s;
}
sub _back2ascii (%) {
  my ($C, %O) = @_;
  my $r = '';
  if ($C->{option}->{reset}->{Gdesignation}) {
    my $F = $C->{option}->{reset}->{Gdesignation};	# \x42
    $r .= "\x1B\x28".$F unless $C->{G0} eq $CHARSET{G94}->{$F};
    $C->{G0} = $CHARSET{G94}->{$F};
    if ($O{reset_all}) {
      $C->{G1} = $CHARSET{G94}->{"\x7E"};
      $C->{G2} = $CHARSET{G94}->{"\x7E"};
      $C->{G3} = $CHARSET{G94}->{"\x7E"};
    }
  }
  if ($C->{option}->{reset}->{Ginvoke}) {
    if ($C->{GL} ne 'G0') {
      $r .= $C->{C0}->{C_LS0} || ($C->{C0} = $CHARSET{C0}->{'@'},"\x1B\x21\x40\x0F");
      $C->{GL} = 'G0';
    }
    $C->{GR} = undef if $O{reset_all};
  }
  $r;
}
## __invoke (\%C, $G, $left_or_right)
sub __invoke (\%$$) {
  my ($C, $G) = @_;
  if ($_[2]) {
    $C->{GL} = 'G'.$G;
    return ($C->{C0}->{C_LS0}
            || scalar ($C->{C0}=$CHARSET{C0}->{'@'},"\x1B\x21\x40\x0F"),
         $C->{C0}->{C_LS1}, "\x1B\x6E", "\x1B\x6F")[$G];
  } else {
    $C->{GR} = 'G'.$G;
    return ("", "\x1B\x7E", "\x1B\x7D", "\x1B\x7C")[$G];
  }
  '';
}
sub _i2o ($\%%) {
  my ($s, $C, %O) = @_;
  my $CS = $CODING_SYSTEM{ $O{cs_F} } || $CODING_SYSTEM{ $O{cs_id} } || return undef;
  my $r = '';
  if ($CS ne $C->{coding_system}) {
    my $e = '';
    $e .= "\x1B\x25";
    $e .= $O{cs_F} || $C->{option}->{private_set}->{coding_system}->{ $O{cs_id} }
          || return undef;
    if ($C->{coding_system} eq $CODING_SYSTEM{"\x2F\x40"}
     || $C->{coding_system} eq $CODING_SYSTEM{"\x2F\x43"}
     || $C->{coding_system} eq $CODING_SYSTEM{"\x2F\x45"}
     || $C->{coding_system} eq $CODING_SYSTEM{"\x2F\x4A"}
     || $C->{coding_system} eq $CODING_SYSTEM{"\x2F\x4B"}
     || $C->{coding_system} eq $CODING_SYSTEM{"\x2F\x4C"}) {
      $e =~ s/(.)/\x00$1/go;
    } elsif ($C->{coding_system} eq $CODING_SYSTEM{"\x2F\x41"}
     || $C->{coding_system} eq $CODING_SYSTEM{"\x2F\x44"}
     || $C->{coding_system} eq $CODING_SYSTEM{"\x2F\x46"}) {
      $e =~ s/(.)/\x00\x00\x00$1/go;
    }
    $r .= $e;
    $C->{coding_system} = $CS;
    if ($CS->{reset_state}) {
      $C->{GL} = undef;  $C->{GR} = undef;
      $C->{C0} = $CHARSET{C0}->{"\x7E"};
      $C->{C1} = $CHARSET{C1}->{"\x7E"};
      $C->{G0} = $CHARSET{G94}->{"\x7E"};
      $C->{G1} = $CHARSET{G94}->{"\x7E"};
      $C->{G2} = $CHARSET{G94}->{"\x7E"};
      $C->{G3} = $CHARSET{G94}->{"\x7E"};
    }
  }
  if ($CS eq $CODING_SYSTEM{"\x40"}) {
    # 
  } elsif ($CS eq $CODING_SYSTEM{G} || $CS eq $CODING_SYSTEM{'/G'}
        || $CS eq $CODING_SYSTEM{'/H'} || $CS eq $CODING_SYSTEM{'/I'}) {
    Encode::_utf8_off ($s);
  } elsif ($CS eq $CODING_SYSTEM{'/@'} || $CS eq $CODING_SYSTEM{'/C'}
        || $CS eq $CODING_SYSTEM{'/E'}) {
    $s = Encode::encode ('ucs-2be', $s);
  } elsif ($CS eq $CODING_SYSTEM{'/A'} || $CS eq $CODING_SYSTEM{'/D'}
        || $CS eq $CODING_SYSTEM{'/F'}) {
    $s = Encode::encode ('ucs-4be', $s);
  } elsif ($CS eq $CODING_SYSTEM{'/J'} || $CS eq $CODING_SYSTEM{'/K'}
        || $CS eq $CODING_SYSTEM{'/L'}) {
    $s = Encode::encode ('UTF-16BE', $s);
  } elsif ($CS eq $CODING_SYSTEM{B}) {
    $s = Encode::encode ('utf-1', $s);
  } else {
    return undef;
  }
  $r . $s;
}

=head1 SEE ALSO

ISO/IEC 646:1991, "7-bit coded graphic character set for intormation interchange".

ISO/IEC 2022:1994, "Character Code Structure and Extension Techniques".
(IDT with ECMA 35, JIS X 0202:1998)

ISO/IEC 4873:1991, "8-Bit Coded Character Set Structure and Rules".
(IDT with ECMA 43)

ISO/IEC 6429:1992, "Control Functions for Coded Character Sets".
(IDT with ECMA 48:1991, JIS X 0211:1998)

ISO/IEC 8859, "8-Bit Single-Byte Coded Graphic Character Sets".

L<Encode>, perlunicode

=head1 TODO

=over 4

=item NCR (coding system other than ISO/IEC 2022) support

=over 2

=item ESC 02/05 02/15 03/x of X Compound Text

=back

=item Output of control character sets, single control functions

=item Designation sequence of control character sets (input)

=item Special graphic character sets such as G3 of EUC-TW

=item SUPER SHIFT (SS) invoke function of old control character set

=item Safe transparent of control string (ISO/IEC 6429)

=item Output of unoutputable characters as alternative notation such as SGML-like entity

=item C0 set invoked to CR area like ISIRI code

Really need?

=item special treatment of 0x20, 0x7E, 0xA0, 0xFF

For example, GB mongolian sets use MSP (MONGOLIAN SPACE)
with these code positions.

And, no less coding systems does not use (or does ban using) DEL.

=item A lot of character sets don't have pseudo-UCS mapping.

Most of 9m^n (n >= 3) sets, 9m^n sets with I byte, 9m^n
DRCSes do not have pseudo-UCS mapping area.  It is
questionable to allocate lots of code positions to these
rarely-(or no-)used character sets.

=item Even character sets that have pseudo-UCS mapping, some of them can't be outputed in ISO/IEC 2022.

Because output of rarely-used character sets is
not implemented yet.

=back

=head1 AUTHORS

Nanashi-san  <nanashi.san@nanashi.invalid>

Wakaba <w@suika.fam.cx>

=head1 LICENSE

Copyright 2002 AUTHORS, all rights reserved.

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1; # $Date: 2002/12/18 10:21:09 $
