
=head1 NAME

Encode::Charset --- Coded Character Sets objects,
used by Encode::ISO2022, Encode::SJIS, and other modules.

=cut

package Encode::Charset;
use strict;
use vars qw(%CHARSET %CODING_SYSTEM $VERSION);
$VERSION=do{my @r=(q$Revision: 1.4 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};

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
      ## BUG: 96^n DRCSes with I byte have no mapping area
  }
}
  $CHARSET{G94n}->{"\x20\x40"}->{ucs} = 0x70460000;	## DRCS 94^2 04/00
  
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
  
  ## SJIS G3 mapping (JIS X 0213:2000 plane 2)
  $CHARSET{G94n}->{"\x50"}->{Csjis_kuE} = { # ku - 1
    0xF0 => 7,  0xF1 => 3,  0xF2 => 11, 0xF3 => 13, 0xF4 => 77,
    0xF5 => 79, 0xF6 => 81, 0xF7 => 83, 0xF8 => 85, 0xF9 => 87,
    0xFA => 89, 0xFB => 91, 0xFC => 93,
  };
  $CHARSET{G94n}->{"\x50"}->{Csjis_kuO} = { # ku - 1
    0xF0  => 0,  0xF1 => 2,  0xF2 => 4,  0xF3 => 12, 0xF4 => 14,
    0xF5  => 78, 0xF6 => 80, 0xF7 => 82, 0xF8 => 84, 0xF9 => 86,
    0xFA  => 88, 0xFB => 90, 0xFC => 92,
  };
  $CHARSET{G94n}->{"\x50"}->{Csjis_first} = { reverse (
    %{ $CHARSET{G94n}->{"\x50"}->{Csjis_kuE} },
    %{ $CHARSET{G94n}->{"\x50"}->{Csjis_kuO} },
  )};
  
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

&make_initial_coding_system;
sub make_initial_coding_system {
  for (0x30..0x7E) {
    my $F = chr $_;
    $CODING_SYSTEM{$F} = {};
    $CODING_SYSTEM{"\x2F".$F} = {reset_state => 1};
  }
  $CODING_SYSTEM{Csjis} = {perl_name => 'shiftjis'};
}

sub make_charset (%) {
  my %set = @_;
  my $setid = qq($set{I}$set{F}$set{revision});
  my $settype = $set{type} || 'G94';
  delete $set{type}, $set{I}, $set{F}, $set{revision};
  $CHARSET{ $settype }->{ $setid } = \%set;
}

## Make a new ISO/IEC 2022-buffers object with default status
sub new_object {
  my %C;
  $C{bit} = 8;
  $C{coding_system} = $CODING_SYSTEM{"\x40"};	## ISO/IEC 2022
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
  		coding_system => {
  			default => -1,
  		},
  	},
  	Ginvoke_by_single_shift	=> [0,0,0,0],	## Invoked by SS
  	Ginvoke_to_left	=> [1,1,1,1],	## Which invoked to? (1: L, 0: R)
  	private_set	=> {	## Private set vs Final byte
  		C0	=> [],
  		C1	=> [],
  		G94	=> [],
  		G94n	=> [[],[],[],[],["\x20\x40"]],
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

sub new_object_sjis {
  my $C = new_object;
  $C->{coding_system} = $CODING_SYSTEM{Csjis};
  $C->{CR} = undef;
  $C->{GR} = 'G2';	## 0xA1-0xDF
  $C->{G0} = $CHARSET{G94}->{J};	## JIS X 0201:1997 Latin
  $C->{G1} = $CHARSET{G94n}->{"\x4F"};	## JIS X 0213:2000
  $C->{G2} = $CHARSET{G94}->{I};	## JIS X 0201:1997 Katakana
  $C->{G3} = $CHARSET{G94n}->{"\x50"};	## JIS X 0213:2000 plane 2
  ## Special code area (0xFD-0xFF)
  $C->{Gsmap} = {"\xA0" => "\x{F8F0}", "\xFD" => "\x{F8F1}", "\xFE" => "\x{F8F2}", "\xFF" => "\x{F8F3}"};
  $C->{GsmapR} = {};	## Reversed table
  $C->{option}->{undef_char_sjis} = "\x81\xAC";
  $C;
}

1;
__END__

=head1 AUTHORS

Nanashi-san

Wakaba <w@suika.fam.cx>

=head1 LICENSE

Copyright 2002 AUTHORS

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/10/12 11:03:00 $
### Charset.pm ends here
