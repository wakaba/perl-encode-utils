=head1 NAME

Encode::ISO2022::ISO646 --- Encode and decode of versions of
ISO/IEC 646

=head1 ENCODINGS

=over 4

=cut

require 5.7.3;
use strict;
package Encode::ISO2022::ISO646;
use vars qw($VERSION);
$VERSION=do{my @r=(q$Revision: 1.3 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
use base qw(Encode::Encoding);
require Encode::ISO2022;

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str = &Encode::ISO2022::internal_to_iso2022 ($str, $obj->__2022_encode);
  return $str;
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  return &Encode::ISO2022::iso2022_to_internal ($str, $obj->__2022_decode);
}

sub __2022__common ($) {
  my $C = Encode::ISO2022->new_object;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G94}->{B} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{G1} = $Encode::ISO2022::CHARSET{G94}->{"\x7E"};	## empty
  $C->{option}->{reset}->{Gdesignation} = 0;
  $C->{option}->{reset}->{Ginvoke} = 0;
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C;
}
sub __2022_decode ($) {
  my $C = shift->__2022__common;
  $C;
}

package Encode::ISO2022::ISO646::ISO646basic1993;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw/ISO_646.basic:1983 ref csISO646basic1983/);

=item ISO_646.basic:1983

A coded character set of
basic code table of ISO/IEC 646 (only graphic characters, 02/00-07/14).
(Name: ISO_646.basic:1983 (RFC 1345), ref (RFC 1345), csISO646basic1983 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{C0} = $Encode::ISO2022::CHARSET{C0}->{"\x7E"};	## empty
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x21\x40"};	## IR170
  # 0x7E = undef
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x21\x40"}];
  $C;
}

package Encode::ISO2022::ISO646::INVARIANT;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!INVARIANT csINVARIANT ISO/IEC646.BCT!);

=item INVARIANT

A coded character set of
basic code table of ISO/IEC 646 (with C0 set of ISO/IEC 6429).
(Name: INVARIANT (RFC 1345), csINVARIANT (IANA), ISO/IEC646.BCT)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x21\x40"};	## IR170
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x21\x40"}];
  $C;
}

package Encode::ISO2022::ISO646::ISO646irv;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!ISO_646.irv:1983 iso-ir-2 irv csISO2IntlRefVersion ICS!);

=item ISO_646.irv:1983

International reference version (IRV) of ISO 646:1983.
(Name: ISO_646.irv:1983 (RFC 1345), iso-ir-2 (RFC 1345), irv (RFC 1345),
csISO2IntlRefVersion (IANA), ICS)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x40"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x40"}];
  $C;
}

package Encode::ISO2022::ISO646::BS_4730;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!BS_4730 iso-ir-4 ISO646-GB gb uk csISO4UnitedKingdom!);

=item BS_4730

BS 4730, a United Kingdom version of ISO/IEC 646.
(Name: BS_4730 (RFC 1345), iso-ir-4 (RFC 1345), ISO646-GB (RFC 1345), 
gb (RFC 1345), uk (RFC 1345), csISO4UnitedKingdom (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x41"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x41"}];
  $C;
}

package Encode::ISO2022::ISO646::USASCII;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
#__PACKAGE__->Define (qw!ANSI_X3.4-1968 iso-ir-6 ANSI_X3.4-1986 ISO_646.irv:1991
#  ASCII ISO646-US US-ASCII us IBM367 cp367 csASCII
#  646 ASCII-7 ATF-8 CP20127 US_ASCII!);

=item ANSI_X3.4-1968

ANSI X3.4-1968 or ISO/IEC 646:1991 International reference version (IRV).
(Name: ANSI_X3.4-1968 (RFC 1345), iso-ir-6 (RFC 1345), ANSI_X3.4-1986 (RFC 1345),
ISO_646.irv:1991 (RFC 1345), ASCII (RFC 1345), ISO646-US (RFC 1345), 
US-ASCII (RFC 1345), us (RFC 1345), IBM367 (RFC 1345), cp367 (RFC 1345),
csASCII (IANA), 646, ASCII-7, ATF-8, CP20127 (M$), US_ASCII)

Note that this coding system defined in this module is not used,
since perl standard Encode module already implement this.

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x41"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x41"}];
  $C;
}

package Encode::ISO2022::ISO646::SEN_850200_B;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!SEN_850200_B iso-ir-10 FI ISO646-FI ISO646-SE 
csISO10Swedish!);

=item SEN_850200_B

SEN 850200 Appendix B, Swedish version of ISO/IEC 646.
(Name: SEN_850200_B (RFC 1345), iso-ir-10 (RFC 1345), FI (RFC 1345), 
ISO646-FI (RFC 1345), ISO646-SE (RFC 1345), se (RFC 1345), csISO10Swedish (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x47"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x47"}];
  $C;
}

package Encode::ISO2022::ISO646::SEN_850200_C;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!SEN_850200_C iso-ir-11 ISO646-SE2
csISO11SwedishForNames!);

=item SEN_850200_C

SEN 850200 Appendix C, Swedish version of ISO/IEC 646 for names.
(Name: SEN_850200_C (RFC 1345), iso-ir-11 (RFC 1345), ISO646-SE2 (RFC 1345), 
csISO11SwedishForNames (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x48"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x48"}];
  $C;
}

package Encode::ISO2022::ISO646::IT;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!IT iso-ir-15 ISO646-IT csISO15Italian!);

=item IT

Italic version of ISO/IEC 646.
(Name: IT (RFC 1345), iso-ir-15 (RFC 1345), ISO646-IT (RFC 1345), 
csISO15Italian (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x59"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x59"}];
  $C;
}

package Encode::ISO2022::ISO646::PT;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!PT iso-ir-16 ISO646-PT csISO16Portuguese!);

=item PT

Portuguese version of ISO/IEC 646.
(Name: PT (RFC 1345), iso-ir-16 (RFC 1345), ISO646-PT (RFC 1345), 
csISO16Portuguese (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x4C"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x4C"}];
  $C;
}

package Encode::ISO2022::ISO646::ES;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!ES iso-ir-17 ISO646-ES csISO17Spanish!);

=item ES

Spanish version of ISO/IEC 646.
(Name: ES (RFC 1345), iso-ir-17 (RFC 1345), ISO646-ES (RFC 1345), 
csISO17Spanish (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x5A"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x5A"}];
  $C;
}

package Encode::ISO2022::ISO646::DIN_66003;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!DIN_66003 iso-ir-21 de ISO646-de csISO21German!);

=item DIN_66003

DIN 66003, German version of ISO/IEC 646.
(Name: DIN_66003 (RFC 1345), iso-ir-21 (RFC 1345), de (RFC 1345),
ISO646-de (RFC 1345), csISO21German (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x4B"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x4B"}];
  $C;
}

package Encode::ISO2022::ISO646::DIN_66003;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!NF_Z_62-010_(1973) iso-ir-25 ISO646-FR1 csISO25French!);

=item NF_Z_62-010_(1973)

NF Z 62-010 1973, French version of ISO/IEC 646.
(Name: NF_Z_62-010_(1973) (RFC 1345), iso-ir-25 (RFC 1345),
ISO646-FR1 (RFC 1345), csISO25French (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x52"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x52"}];
  $C;
}

package Encode::ISO2022::ISO646::GB_1988;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!GB_1988-80 iso-ir-57 cn ISO646-cn csISO57GB1988!);

=item GB_1988-80

GB_1988-80, Chinese version of ISO/IEC 646.
(Name: GB_1988-80 (RFC 1345), iso-ir-57 (RFC 1345), cn (RFC 1345),
ISO646-cn (RFC 1345), csISO57GB1988 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x54"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x54"}];
  $C;
}

package Encode::ISO2022::ISO646::csISO60DanishNorwegian;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw! NS_4551-1 iso-ir-60 ISO646-NO no csISO60DanishNorwegian
 csISO60Norwegian1!);

=item NS_4551-1

NS_4551-1, Norwegian version of ISO/IEC 646.
(Name: NS_4551-1 (RFC 1345), iso-ir-60 (RFC 1345), ISO646-NO (RFC 1345),
no (RFC 1345), csISO60DanishNorwegian (IANA), csISO60Norwegian1 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x60"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x60"}];
  $C;
}

package Encode::ISO2022::ISO646::csISO61Norwegian2;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw! NS_4551-2 iso-ir-61 ISO646-NO2 no2 csISO61Norwegian2!);

=item NS_4551-2

NS_4551-2, Norwegian version of ISO/IEC 646.
(Name: NS_4551-2 (RFC 1345), iso-ir-61 (RFC 1345), ISO646-NO2 (RFC 1345),
no2 (RFC 1345), csISO61Norwegian2 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x61"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x61"}];
  $C;
}

package Encode::ISO2022::ISO646::csISO69French;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!NF_Z_62-010 iso-ir-69 ISO646-FR fr csISO69French!);

=item NF_Z_62-010

NF Z 62-010, French version of ISO/IEC 646.
(Name: NS_4551-2 (RFC 1345), iso-ir-69 (RFC 1345), ISO646-FR (RFC 1345),
fr (RFC 1345), csISO69French (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x66"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x66"}];
  $C;
}

package Encode::ISO2022::ISO646::PT2;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!PT2 iso-ir-84 ISO646-PT2 csISO84Portuguese2!);

=item PT2

Portuguse version of ISO/IEC 646.
(Name: PT2 (RFC 1345), iso-ir-84 (RFC 1345), ISO646-PT2 (RFC 1345),
csISO84Portuguese2 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x67"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x67"}];
  $C;
}

package Encode::ISO2022::ISO646::ES2;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!ES2 iso-ir-85 ISO646-ES2 csISO85Spanish2!);

=item ES2

Spanish version of ISO/IEC 646.
(Name: ES2 (RFC 1345), iso-ir-85 (RFC 1345), ISO646-ES2 (RFC 1345),
csISO85Spanish2 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x68"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x68"}];
  $C;
}

package Encode::ISO2022::ISO646::csISO86Hungarian;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!MSZ_7795.3 iso-ir-86 ISO646-HU hu csISO86Hungarian!);

=item MSZ_7795.3

Hungarian version of ISO/IEC 646.
(Name: MSZ_7795.3 (RFC 1345), iso-ir-86 (RFC 1345), ISO646-HU (RFC 1345),
hu (RFC 1345), csISO86Hungarian (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x69"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x69"}];
  $C;
}

package Encode::ISO2022::ISO646::csISO121Canadian1;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!CSA_Z243.4-1985-1 iso-ir-121 ISO646-CA csa7-1 ca
 csISO121Canadian1!);

=item CSA_Z243.4-1985-1

Canadian version of ISO/IEC 646.
(Name: CSA_Z243.4-1985-1 (RFC 1345), iso-ir-121 (RFC 1345), ISO646-CA (RFC 1345),
csa7-1 (RFC 1345), ca (RFC 1345), csISO121Canadian1 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x77"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x77"}];
  $C;
}

package Encode::ISO2022::ISO646::csISO122Canadian2;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!CSA_Z243.4-1985-2 iso-ir-122 ISO646-CA2 csa7-2
 csISO122Canadian2!);

=item CSA_Z243.4-1985-2

Canadian version of ISO/IEC 646.
(Name: CSA_Z243.4-1985-2 (RFC 1345), iso-ir-122 (RFC 1345), ISO646-CA2 (RFC 1345),
csa7-2 (RFC 1345), csISO122Canadian2 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x78"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x78"}];
  $C;
}

package Encode::ISO2022::ISO646::csISO122Canadian2;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!JUS_I.B1.0022 iso-ir-141 ISO646-YU js yu
 csISO141JUSIB1002!);

=item JUS_I.B1.002

Canadian version of ISO/IEC 646.
(Name: JUS_I.B1.002 (RFC 1345), iso-ir-141 (RFC 1345), ISO646-YU (RFC 1345),
js (RFC 1345), yu (RFC 1345), csISO141JUSIB1002 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x7A"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x7A"}];
  $C;
}

package Encode::ISO2022::ISO646::csISO151Cuba;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::ISO646';
__PACKAGE__->Define (qw!NC_NC00-10:81 cuba iso-ir-151ISO646-CU
 csISO151Cuba!);

=item NC_NC00-10:81

Canadian version of ISO/IEC 646.
(Name: NC_NC00-10:81 (RFC 1345), cuba (RFC 1345), iso-ir-151 (RFC 1345),
ISO646-CU (RFC 1345), csISO151Cuba (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x21\x41"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x21\x41"}];
  $C;
}

# DS_2089 DS2089 ISO646-DK dk csISO646Danish (IANA)
	## Not in ISOREG
# KSC5636 ISO646-KR csKSC5636 (IANA)
	## Not in ISOREG

1;
__END__

=back

=head1 AUTHORS

Nanashi-san

Wakaba <w@suika.fam.cx>

=head1 LICENSE

Copyright 2002 Authors

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/09/23 10:36:03 $
### ISO646.pm ends here
