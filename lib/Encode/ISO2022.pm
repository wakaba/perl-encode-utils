
=head1 NAME

Encode::ISO2022 --- ISO/IEC 2022 encoder and decoder

=cut

require v5.7.3;
package Encode::ISO2022;
use strict;
use vars qw(%CHARSET $VERSION);
$VERSION=do{my @r=(q$Revision: 1.4 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/iso-2022 iso2022 2022 cp2022/);

### --- Intialization

my %_CHARS_to_RANGE = (
	l94	=> q/[\x21-\x7E]/,
	l96	=> q/[\x20-\x7F]/,
	l128	=> q/[\x00-\x7F]/,
	l256	=> q/[\x00-\xFF]/,
	r94	=> q/[\xA1-\xFE]/,
	r96	=> q/[\xA0-\xFF]/,
	r128	=> q/[\x80-\xFF]/,
	r256	=> q/[\x80-\xFF]/,
	b94	=> q/[\x21-\x7E\xA1-\xFE]/,
	b96	=> q/[\x20-\x7F\xA0-\xFF]/,
	b128	=> q/[\x00-\xFF]/,
	b256	=> q/[\x00-\xFF]/,
);

## --- Make initial charset definitions
&_make_initial_charsets;
sub _make_initial_charsets () {
for my $f (0x30..0x7E) {
  my $F = pack 'C', $f;
  for ('', '!', '"', '#') {
    $CHARSET{G94}->{ $_.$F }->{dimension} = 1;
    $CHARSET{G94}->{ $_.$F }->{chars} = 94;
    $CHARSET{G94}->{ $_.$F }->{ucs} =
      {'' => 0xE90940, '!' => 0xE944A0, '"' => 0xE98000, '#' => 0xE9BB60}->{ $_ }
      + 94 * ($f-0x30);
    
    $CHARSET{G96}->{ $_.$F }->{dimension} = 1;
    $CHARSET{G96}->{ $_.$F }->{chars} = 96;
    $CHARSET{G96}->{ $_.$F }->{ucs} =
      {'' => 0xE926A0, '!' => 0xE96200, '"' => 0xE99D60, '#' => 0xE9D8C0}->{ $_ }
      + 96 * ($f-0x30);
    
    $CHARSET{C0}->{ $_.$F }->{dimension} = 1;
    $CHARSET{C0}->{ $_.$F }->{chars} = 32;
    $CHARSET{C0}->{ $_.$F }->{ucs} =
      {'' => 0x70000000, '!' => 0x70001400,
      '"' => 0x70002800, '#' => 0x70003C00}->{ $_ } + 32 * ($f-0x30);
    
    $CHARSET{C1}->{ $_.$F }->{dimension} = 1;
    $CHARSET{C1}->{ $_.$F }->{chars} = 32;
    $CHARSET{C1}->{ $_.$F }->{ucs} =
      {'' => 0x70000A00, '!' => 0x70001E00,
      '"' => 0x70003200, '#' => 0x70004600}->{ $_ } + 32 * ($f-0x30);
    
    $CHARSET{G94}->{ ' '.$_.$F }->{dimension} = 1;	## DRCS
    $CHARSET{G94}->{ ' '.$_.$F }->{chars} = 94;
    $CHARSET{G94}->{ ' '.$_.$F }->{ucs} =
      {'' => 0x70090940, '!' => 0x700944A0,
      '"' => 0x70098000, '#' => 0x7009BB60}->{ $_ } + 94 * ($f-0x30);
    
    $CHARSET{G96}->{ ' '.$_.$F }->{dimension} = 1;	## DRCS
    $CHARSET{G96}->{ ' '.$_.$F }->{chars} = 96;
    $CHARSET{G96}->{ ' '.$_.$F }->{ucs} =
      {'' => 0x700926A0, '!' => 0x70096200,
      '"' => 0x70099D60, '#' => 0x7009D8C0}->{ $_ } + 96 * ($f-0x30);
  }
}
for my $f (0x30..0x5F, 0x7E) {
  my $F = pack 'C', $f;
  for ('', '!', '"', '#', ' ') {
    $CHARSET{G94n}->{ $_.$F }->{dimension} = 2;
    $CHARSET{G94n}->{ $_.$F }->{chars} = 94;
    $CHARSET{G94n}->{ $_.$F }->{ucs} =
      ({'' => 0xE9F6C0}->{ $_ }||0) + 94*94 * ($f-0x30);
      ## BUG: 94^n sets with I byte have no mapping area
    
    $CHARSET{G96n}->{ $_.$F }->{dimension} = 2;
    $CHARSET{G96n}->{ $_.$F }->{chars} = 96;
    $CHARSET{G96n}->{ $_.$F }->{ucs} =
      ({'' => 0xF4C000}->{ $_ }||0) + 96*96 * ($f-0x30);
      ## BUG: 94^n DRCSes with I byte have no mapping area
  }
}
for (0x60..0x6F) {
  my $F = pack 'C', $_;
  ## BUG: 9x^3 sets have no mapping area
  for ('', '!', '"', '#', ' ') {
    $CHARSET{G94n}->{ $_.$F }->{dimension} = 3;
    $CHARSET{G94n}->{ $_.$F }->{chars} = 94;
    
    $CHARSET{G96n}->{ $_.$F }->{dimension} = 3;
    $CHARSET{G96n}->{ $_.$F }->{chars} = 96;
  }
}
for (0x70..0x7D) {
  my $F = pack 'C', $_;
  ## BUG: 9x^4 sets have no mapping area
  for ('', '!', '"', '#', ' ') {
    $CHARSET{G94n}->{ $_.$F }->{dimension} = 4;
    $CHARSET{G94n}->{ $_.$F }->{chars} = 94;
    
    $CHARSET{G96n}->{ $_.$F }->{dimension} = 4;
    $CHARSET{G96n}->{ $_.$F }->{chars} = 96;
  }
}
for my $f (0x40..0x4E) {
  my $F = pack 'C', $f;
    $CHARSET{G96n}->{ ' '.$F }->{dimension} = 2;
    $CHARSET{G96n}->{ ' '.$F }->{chars} = 96;
    $CHARSET{G96n}->{ ' '.$F }->{ucs} = 0xF0000 + 96*96*($f-0x40);
    ## U+F0000-U+10F7FF (private) -> ESC 02/04 02/00 <I> (04/00-04/14) (DRCS)
}

$CHARSET{G94}->{B}->{ucs} = 0x21;	## ASCII
$CHARSET{G96}->{A}->{ucs} = 0xA0;	## ISO 8859-1

$CHARSET{G94n}->{'B@'}->{dimension} = 2;	## JIS X 0208-1990
$CHARSET{G94n}->{'B@'}->{chars} = 94;
$CHARSET{G94n}->{'B@'}->{ucs} = 0xE9F6C0 + 94*94*79;

  ## -- Control character sets
  $CHARSET{C0}->{'@'}->{ucs} = 0x00;	## ISO/IEC 6429 C0
  for ("\x40", "\x43", "\x44", "\x45", "\x46", "\x49", "\x4A", "\x4B", "\x4C") {
    $CHARSET{C0}->{$_}->{C_LS0} = "\x0F";
    $CHARSET{C0}->{$_}->{C_LS1} = "\x0E";
    $CHARSET{C0}->{$_}->{r_LS0} = '\x0F';
    $CHARSET{C0}->{$_}->{r_LS1} = '\x0E';
  }
  for ("\x40", "\x44", "\x45", "\x46", "\x48", "\x4C") {
    $CHARSET{C0}->{$_}->{reset_all} = {"\x0A" => 1, "\x0B" => 1,
      "\x0C" => 1, "\x0D" => 1};
  }
  $CHARSET{C0}->{"\x43"}->{reset_all} = {"\x0A" => 1};
  $CHARSET{C0}->{"\x44"}->{C_SS2} = "\x1C";
  $CHARSET{C0}->{"\x44"}->{r_SS2} = '\x1C';
  for ("\x45", "\x49", "\x4A", "\x4B") {
    $CHARSET{C0}->{$_}->{C_SS2} = "\x19";
    $CHARSET{C0}->{$_}->{C_SS3} = "\x1D";
    $CHARSET{C0}->{$_}->{r_SS2} = '\x19';
    $CHARSET{C0}->{$_}->{r_SS3} = '\x1D';
  }
  $CHARSET{C0}->{"\x4C"}->{C_SS2} = "\x19";
  $CHARSET{C0}->{"\x4C"}->{r_SS2} = '\x19';
  
  $CHARSET{C1}->{'64291991C1'}->{dimension} = 1;	## ISO/IEC 6429:1991 C1
  $CHARSET{C1}->{'64291991C1'}->{chars} = 32;
  $CHARSET{C1}->{'64291991C1'}->{ucs} = 0x80;
  for ("\x43", "\x45", "\x47", '64291991C1') {
    $CHARSET{C1}->{$_}->{C_SS2} = "\x8E";
    $CHARSET{C1}->{$_}->{C_SS3} = "\x8F";
    $CHARSET{C1}->{$_}->{r_SS2} = '\x8E';
    $CHARSET{C1}->{$_}->{r_SS3} = '\x8F';
    $CHARSET{C1}->{$_}->{r_SS2_ESC} = '\x1B\x4E';
    $CHARSET{C1}->{$_}->{r_SS3_ESC} = '\x1B\x4F';
  }
  for ("\x43", '64291991C1') {
    $CHARSET{C1}->{$_}->{r_CSI} = '\x9B';
    $CHARSET{C1}->{$_}->{r_CSI_ESC} = '\x1B\x5B';
    $CHARSET{C1}->{$_}->{r_DCS} = '\x90';
    $CHARSET{C1}->{$_}->{r_ST} = '\x9C';
    $CHARSET{C1}->{$_}->{r_OSC} = '\x9D';
    $CHARSET{C1}->{$_}->{r_PM} = '\x9E';
    $CHARSET{C1}->{$_}->{r_APC} = '\x9F';
    $CHARSET{C1}->{$_}->{reset_all} = {"\x85"=>1, "\x90"=>1,
      "\x9C"=>1, "\x9D"=>1, "\x9E"=>1, "\x9F"=>1};
  }
  $CHARSET{C1}->{'64291991C1'}->{r_SCI} = '\x9A';
  
  $CHARSET{single_control}->{Fs}   ={ucs => 0x70005000, chars => 32, dimension => 1};
  $CHARSET{single_control}->{'3F'} ={ucs => 0x70005020, chars => 80, dimension => 1};
  $CHARSET{single_control}->{'3F!'}={ucs => 0x70005070, chars => 80, dimension => 1};
  $CHARSET{single_control}->{'3F"'}={ucs => 0x700050C0, chars => 80, dimension => 1};
  $CHARSET{single_control}->{'3F#'}={ucs => 0x70005110, chars => 80, dimension => 1};
}


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

## Make a new ISO/IEC 2022-buffers object with default status
sub new_object {
  my %C;
  $C{bit} = 8;
  $C{CL} = 'C0'; $C{CR} = 'C1'; $C{ESC_Fe} = 'C1';
  $C{C0} = $CHARSET{C0}->{"\x40"};	## ISO/IEC 6429:1991 C0
  $C{C1} = $CHARSET{C1}->{'64291991C1'};	## ISO/IEC 6429:1991 C1
  $C{GL} = 'G0'; $C{GR} = 'G1';
  $C{G0} = $CHARSET{G94}->{"\x42"};	## ISO/IEC 646:1991 IRV
  #$C{G1} = $CHARSET{G96}->{"\x41"};	## ISO/IEC 8859-1 GR
  $C{G1} = $CHARSET{G94}->{"\x7E"};	## empty set
  $C{G2} = $CHARSET{G94}->{"\x7E"};	## empty set
  $C{G3} = $CHARSET{G94}->{"\x7E"};	## empty set
  $C{option} = {
  	C1invoke_to_right	=> 0,	## C1 invoked to: (0: ESC Fe, 1: CR)
  	G94n_designate_long	=> 0,	## (1: ESC 02/04 02/08 04/00..02)
  	designate_to	=> {	## Designated G buffer (-1: not be outputed)
  		C0	=> {
  			default	=> 0,
  		},
  		C1	=> {
  			default	=> 1,
  		},
  		G94	=> {
  			"\x42"	=> 0,
  			default	=> 0,
  		},
  		G96	=> {
  			default	=> 1,
  		},
  		G94n	=> {
  			default	=> 0,
  		},
  		G96n	=> {
  			default	=> 1,
  		},
  	},
  	Ginvoke_by_single_shift	=> [0,0,0,0],	## Invoked by SS
  	Ginvoke_to_left	=> [1,1,1,1],	## Which invoked to? (1: L, 0: R)
  	private_set	=> {	## Private set vs Final byte
  		C0	=> [],
  		C1	=> [],
  		G94	=> [],
  		G94n	=> [[],[],[],[],[]],
  		G96	=> [],
  		#G96n	=> [],	## (not implemented)
  		U96n	=> [],	## mule-unicode sets
  		XC1	=> {
  			'64291991C1'	=> undef,	## ISO/IEC 6429:1991 C1
  		},
  	},
  	reset => {	## Reset status at top of line
  		Gdesignation	=> "\x42",	## F of designation or 0
  		Ginvoke	=> 1,
  	},
  	undef_char	=> ["\x3F", {type => 'G94', charset => 'B'}],
  	use_revision	=> 1,	## Output IRR
  };
  \%C;
}

sub iso2022_to_internal ($;\%) {
  my ($s, $C) = @_;
  my %_GB_to_GN = (
    "\x28"=>'G0',"\x29"=>'G1',"\x2A"=>'G2',"\x2B"=>'G3',
    "\x2C"=>'G0',"\x2D"=>'G1',"\x2E"=>'G2',"\x2F"=>'G3',
  );
  $C ||= &new_object;
  
  use re 'eval';
  $s =~ s{
     ((??{ $_CHARS_to_RANGE{'l'.$C->{$C->{GL}}->{chars}}
         . qq/{$C->{$C->{GL}}->{dimension},$C->{$C->{GL}}->{dimension}}/ }))
    |((??{ $_CHARS_to_RANGE{'r'.$C->{$C->{GL}}->{chars}}
         . qq/{$C->{$C->{GR}}->{dimension},$C->{$C->{GR}}->{dimension}}/ }))
    
    |  (??{ q/(?:/ . ($C->{$C->{CR}}->{r_SS2} || '(?!)')
             . ($C->{$C->{ESC_Fe}}->{r_SS2_ESC} ?
                 qq/|$C->{$C->{ESC_Fe}}->{r_SS2_ESC}/ : '')
             . ($C->{$C->{CL}}->{r_SS2} ? qq/|$C->{$C->{CL}}->{r_SS2}/ : '') . q/)/
          . (  $C->{$C->{CL}}->{r_LS0}
             ||$C->{$C->{CL}}->{r_LS1}?	## ISO/IEC 6429:1992 9
             qq/[$C->{$C->{CL}}->{r_LS0}$C->{$C->{CL}}->{r_LS1}]*/:'')
        })
      ((??{ $_CHARS_to_RANGE{'b'.$C->{$C->{GL}}->{chars}}
            . qq/{$C->{G2}->{dimension},$C->{G2}->{dimension}}/ }))
    |  (??{ q/(?:/ . ($C->{$C->{CR}}->{r_SS3} || '(?!)')
             . ($C->{$C->{ESC_Fe}}->{r_SS3_ESC} ?
                qq/|$C->{$C->{ESC_Fe}}->{r_SS3_ESC}/ : '')
             . ($C->{$C->{CL}}->{r_SS3} ? qq/|$C->{$C->{CL}}->{r_SS3}/ : '') . q/)/
          . (  $C->{$C->{CL}}->{r_LS0}
            || $C->{$C->{CL}}->{r_LS1}?	## ISO/IEC 6429:1992 9
             qq/[$C->{$C->{CL}}->{r_LS0}$C->{$C->{CL}}->{r_LS1}]*/:'')
        })
      ((??{ $_CHARS_to_RANGE{'b'.$C->{$C->{GL}}->{chars}}
            . qq/{$C->{G3}->{dimension},$C->{G3}->{dimension}}/ }))
    
    ## Locking shift
    |( \x1B[\x6E\x6F\x7C-\x7E]
       |(??{ $C->{$C->{CL}}->{r_LS0}||'(?!)' })
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
    ## Control, SP, or broken data
    ## TODO: support control sets other than ISO/IEC 6429's
    } elsif (defined $misc) {
      $misc;
    ## GR graphic character
    } elsif ($gr) {
      my $c = 0;
      my $m = $C->{$C->{GR}}->{chars}==94?0xA1:$C->{$C->{GR}}->{chars}==96?0xA0:0x80;
      for (split //, $gr) {
        $c = $c * $C->{$C->{GR}}->{chars} + unpack ('C', $_) - $m;
      }
      chr ($C->{$C->{GR}}->{ucs} + $c);
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
      ## IRR (revision number)
      if ($esc =~ /\x1B\x26([\x40-\x7E])/) {
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
          if ($g94_g) {
            $C->{ $_GB_to_GN{ $g94_g } } = $CHARSET{G94}->{ $g94_f.$rev }
                                      || $CHARSET{G94}->{ $g94_f }
                                      || $CHARSET{G94}->{ "\x7E" }; '';
          } elsif (defined $g94n_f) {
            $C->{ $_GB_to_GN{ $g94n_g } || 'G0' } = $CHARSET{G94n}->{ $g94n_f.$rev }
                                      || $CHARSET{G94n}->{ $g94n_f }
                                      || $CHARSET{G94n}->{ "\x7E" }; '';
          } elsif ($g96_g) {
            $C->{ $_GB_to_GN{ $g96_g } } = $CHARSET{G96}->{ $g96_f.$rev }
                                      || $CHARSET{G96}->{ $g96_f }
                                      || $CHARSET{G96}->{ "\x7E" }; '';
          } elsif (defined $g96n_f) {
            $C->{ $_GB_to_GN{ $g96n_g } } = $CHARSET{G96n}->{ $g96n_f.$rev }
                                      || $CHARSET{G96n}->{ $g96n_f }
                                      || $CHARSET{G96n}->{ "\x7E" }; '';
          } elsif ($Fe) {	## ESC Fe => C1
            chr ($C->{ $C->{ESC_Fe} }->{ucs} + (ord ($Fe) - 0x40));
          } elsif ($CZD) {
            $C->{C0} = $CHARSET{C0}->{ $CZD.$rev }
                    || $CHARSET{C0}->{ $CZD } || $CHARSET{C0}->{ "\x7E" }; '';
          } elsif ($C1D) {
            $C->{C1} = $CHARSET{C1}->{ $C1D.$rev }
                    || $CHARSET{C1}->{ $C1D } || $CHARSET{C1}->{ "\x7E" }; '';
          } elsif ($Fs) {
            if ($Fs eq "\x6E") {	## LS2
              $C->{GL} = 'G2'; '';
            } elsif ($Fs eq "\x6F") {	## LS3
              $C->{GL} = 'G3'; '';
            } elsif ($Fs eq "\x7E") {	## LS1R
              $C->{GR} = 'G1';  $C->{GL} = 'G1' if $C->{bit} == 7; '';
            } elsif ($Fs eq "\x7D") {	## LS2R
              $C->{GR} = 'G2';  $C->{GL} = 'G2' if $C->{bit} == 7; '';
            } elsif ($Fs eq "\x7C") {	## LS3R
              $C->{GR} = 'G3';  $C->{GL} = 'G3' if $C->{bit} == 7; '';
            } else {
              chr ($CHARSET{single_control}->{Fs}->{ucs} + (ord ($Fs) - 0x60));
            }
          } elsif ($sI) {
            chr ($CHARSET{single_control}->{'3F'.$sI}->{ucs} + (ord ($sF) - 0x30));
          } elsif ($ACS) {	## Announcer
            if ($ACS eq "\x4A") { $C->{bit} = 7 }
            elsif ($ACS eq "\x4B") { $C->{bit} = 8 }
            '';
          }
        }gex;
        $C->{_irr} = undef;
      }
      $esc;
    ## Locking shifts
    } elsif ($ls) {
      if ($ls eq $C->{$C->{CL}}->{LS0}) {
        $C->{GL} = 'G0'; '';
      } elsif ($ls eq $C->{$C->{CL}}->{LS1}) {
        $C->{GL} = 'G1'; '';
      } elsif ($ls =~ /\x1B([\x6E\x6F])/) {
        $C->{GL} = {"\x6E"=>2, "\x6F"=>3}->{$1}; '';
      } elsif ($ls =~ /\x1B([\x7C-\x7E])/) {
        $C->{GR} = {"\x7E"=>1, "\x7D"=>2, "\x7C"=>3}->{$1}; '';
      }
    ## Control sequence
    } elsif ($csi) {
      $csi =~ tr/\xA0-\xFF/\x20-\x7F/d;
      $csi =~ s/$C->{$C->{CL}}->{LS0}//g if $C->{$C->{CL}}->{LS0};
      $csi =~ s/$C->{$C->{CL}}->{LS1}//g if $C->{$C->{CL}}->{LS1};
      "\x9B".$csi;
    }
  }gex;
  $s;
}

sub internal_to_iso2022 ($\%) {
  my ($s, $C) = @_;
  $C ||= &new_object;
  
  my $r = '';
  for my $c (split //, $s) {
    my $cc = ord $c;
    my $t;
    if ($cc <= 0x1F) {
      $t = _i2c ($c, $C, type => 'C0', charset => '@');
    } elsif ($cc == 0x20 || $cc == 0x7F) {
      $t = _back2ascii ($C) . $c;
    } elsif ($cc < 0x7F) {
      $t = _i2g ($c, $C, type => 'G94', charset => 'B');
    } elsif ($cc <= 0x9F) {
      $t = _i2c ($c, $C, type => 'C1', charset_id => '64291991C1',
        charset => $C->{private_set}->{XC1}->{'64291991C1'});
    } elsif ($cc <= 0xFF) {
      $t = _i2g (chr($cc-0x80), $C, type => 'G96', charset => 'A');
    } elsif ($cc <= 0x24FF) {
      my $c = $cc - 0x100;
      my $final = $C->{private_set}->{U96n}->[0];
      if (length $final) {
        $t = _i2g (chr(($c / 96)+0x20).chr(($c % 96)+0x20), $C,
          type => 'G96n', charset => $final);
      }
    } elsif ($cc <= 0x33FF) {
      my $c = $cc - 0x2500;
      my $final = $C->{private_set}->{U96n}->[1];
      if (length $final) {
        $t = _i2g (chr(($c / 96)+0x20).chr(($c % 96)+0x20), $C,
          type => 'G96n', charset => $final);
      }
    } elsif (0xE000 <= $cc && $cc <= 0xFFFF) {
      my $c = $cc - 0xE000;
      my $final = $C->{private_set}->{U96n}->[2];
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
          type => 'G94', charset => $C->{private_set}->{G94}->[ $c / 94 ]);
    } elsif (0x70410000 <= $cc && $cc <= 0x7041FFBF) {
      my $c = $cc - 0x70410000;
      $t = _i2g (chr(($c % 96)+0x20), $C, charset_id => 'P'.int ($c / 96),
          type => 'G96', charset => $C->{private_set}->{G96}->[ $c / 96 ]);
    } elsif (0x70420000 <= $cc && $cc <= 0x7046F19B) {
      my $c = $cc % 0x10000;
      $t = _i2g (chr((($c % 8836) / 94)+0x21).chr(($c % 94)+0x21), $C,
          type => 'G94n',
          charset_id => 'P'.int(($cc / 0x10000) - 0x7042).'_'.int($c / 8836),
          charset => $C->{private_set}->{G94n}->[ ($cc / 0x10000) - 0x7042 ]
                       ->[ $c / 8836 ]);
    }
    if (defined $t) {
      $r .= $t;
    } else {
      $r .= _i2g ($C->{option}->{undef_char}->[0], $C,
                  %{ $C->{option}->{undef_char}->[1] });
    }
  }
  $r . _back2ascii ($C);
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
      $s =~ s/([\x80-\x9F])/"\x1B" . chr (ord ($1) - 0x40)/ge;
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

sub make_charset (%) {
## TODO: support private charset ID such as 'X0'
  my %set = @_;
  my $setid = qq($set{I}$set{F}$set{revision});
  my $settype = $set{type} || 'G94';
  delete $set{type}, $set{I}, $set{F}, $set{revision};
  $CHARSET{ $settype }->{ $setid } = \%set;
}

1;
__END__

=head1 SEE ALSO

ISO/IEC 646:1991, "7-bit coded graphic character set for intormation interchange".

ISO/IEC 2022:1994, "Character Code Structure and Extension Techniques".
(IDT with ECMA 35, JIS X 0202:1998)

ISO/IEC 4873:1991, "8-Bit Coded Character Set Structure and Rules".
(IDT with ECMA 43)

ISO/IEC 6429:1992, "Control Functions for Coded Character Sets".
(IDT with ECMA 48:1991, JIS X 0211:1998)

ISO/IEC 8859, "8-Bit Single-Byte Coded Graphic Character Sets".

Encode, perlunicode

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

=head1 LICENSE

Copyright 2002 wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/09/16 06:35:16 $
### ISO2022.pm ends here
