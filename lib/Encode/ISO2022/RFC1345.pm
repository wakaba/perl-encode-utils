=head1 NAME

Encode::ISO2022::RFC1345 --- Encode and decode of ISO/IEC 2022
based encodings described in IETF RFC 1345 (and not defined by
any other standards)

=head1 ENCODINGS

=over 4

=cut

require 5.7.3;
use strict;
package Encode::ISO2022::RFC1345;
use vars qw($VERSION);
$VERSION=do{my @r=(q$Revision: 1.4 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
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

sub __clone ($) {
  my $self = shift;
  bless {%$self}, ref $self;
};

package Encode::ISO2022::RFC1345::NATSSEFI;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/NATS-SEFI iso-ir-8-1 csNATSSEFI/);

=item NATS-SEFI

NATS-SEFI (Alias: iso-ir-8-1, csNATSSEFI (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x43"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x43"}];
  $C;
}

package Encode::ISO2022::RFC1345::NATSSEFIADD;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/NATS-SEFI-ADD iso-ir-8-2 csNATSSEFIADD/);

=item NATS-SEFI-ADD

NATS-SEFI-ADD (Alias: iso-ir-8-2, csNATSSEFIADD (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{C0} = $Encode::ISO2022::CHARSET{C0}->{"\x7E"};	## empty
  # 0x20, 0x7E = undef
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x44"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  # no replacement character available
  $C;
}

package Encode::ISO2022::RFC1345::NATSDANO;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/NATS-DANO iso-ir-9-1 csNATSDANO/);

=item NATS-DANO

NATS-DANO (Alias: iso-ir-9-1, csNATSDANO (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x45"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x45"}];
  $C;
}

package Encode::ISO2022::RFC1345::NATSDANOADD;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/NATS-DANO-ADD iso-ir-9-2 csNATSDANOADD/);

=item NATS-DANO-ADD

NATS-DANO-ADD (Alias: iso-ir-9-2, csNATSDANOADD (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{C0} = $Encode::ISO2022::CHARSET{C0}->{"\x7E"};	## empty
  # 0x20, 0x7E = undef
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x46"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  # no replacement character available
  $C;
}

package Encode::ISO2022::RFC1345::csISO18Greek7Old;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/greek7-old iso-ir-18 csISO18Greek7Old/);

=item greek7-old

greek7-old (Alias: iso-ir-18, csISO18Greek7Old (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x5B"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x5B"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO19LatinGreek;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/latin-greek iso-ir-19 csISO19LatinGreek/);

=item latin-greek

latin-greek (Alias: iso-ir-19, csISO19LatinGreek (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x5C"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x5C"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO27LatinGreek1;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/Latin-greek-1 iso-ir-27 csISO27LatinGreek1/);

=item Latin-greek-1

Latin-greek-1 (Alias: iso-ir-27, csISO27LatinGreek1 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x55"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x20"];
  $C;
}

package Encode::ISO2022::RFC1345::ISO_5427;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/ISO_5427 iso-ir-37 csISO5427Cyrillic/);

=item ISO_5427

ISO_5427 (Alias: iso-ir-37, csISO5427Cyrillic (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x4E"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x4E"}];
  $C;
}

package Encode::ISO2022::RFC1345::BS_viewdata;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/BS_viewdata iso-ir-47 csISO47BSViewdata/);

=item BS_viewdata

BS_viewdata (Alias: iso-ir-47, csISO47BSViewdata (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x56"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x56"}];
  $C;
}

package Encode::ISO2022::RFC1345::INIS;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/INIS iso-ir-49 csISO49INIS/);

=item INIS

INIS (Alias: iso-ir-49, csISO49INIS (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x57"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x20"];
  $C;
}

package Encode::ISO2022::RFC1345::csISO50INIS8;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/INIS-8 iso-ir-50 csISO50INIS8/);

=item INIS-8

INIS-8 (Alias: iso-ir-50, csISO50INIS8 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x5D"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x20"];
  $C;
}

package Encode::ISO2022::RFC1345::csISO51INISCyrillic;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/INIS-cyrillic iso-ir-51 csISO51INISCyrillic/);

=item INIS-cyrillic

INIS-cyrillic (Alias: iso-ir-51, csISO51INISCyrillic (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x5E"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x20"];
  $C;
}

package Encode::ISO2022::RFC1345::ISO5427Cyrillic1981;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/ISO_5427:1981 iso-ir-54 ISO5427Cyrillic1981/);

=item ISO_5427:1981

ISO_5427:1981 (Alias: iso-ir-54, ISO5427Cyrillic1981 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x51"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x20"];
  $C;
}

package Encode::ISO2022::RFC1345::csISO5428Greek;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/ISO_5428:1980 iso-ir-55 csISO5428Greek/);

=item ISO_5428:1980

ISO_5428:1980 (Alias: iso-ir-55, csISO5428Greek (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x53"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x20"];
  $C;
}

package Encode::ISO2022::RFC1345::greek7;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/greek7 iso-ir-88 csISO88Greek7/);

=item greek7

greek7 (Alias: iso-ir-88, csISO88Greek7 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x6A"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x6A"}];
  $C;
}

package Encode::ISO2022::RFC1345::ASMO_449;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/ASMO_449 ISO_9036 arabic7 iso-ir-89 csISO89ASMO449/);

=item ASMO_449

ASMO_449 (Alias: ISO_9036, arabic7, iso-ir-89, csISO89ASMO449 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x6B"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x6B"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO91JISC62291984a;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/JIS_C6229-1984-a iso-ir-91 jp-ocr-a csISO91JISC62291984a/);

=item JIS_C6229-1984-a

JIS_C6229-1984-a (Alias: iso-ir-91, jp-ocr-a, csISO91JISC62291984a (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x6D"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x6D"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO92JISC62991984b;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/JIS_C6229-1984-b iso-ir-92 ISO646-JP-OCR-B jp-ocr-b
 csISO92JISC62991984b/);

=item JIS_C6229-1984-b

JIS_C6229-1984-b (Alias: iso-ir-92, ISO646-JP-OCR-B, jp-ocr-b,
csISO92JISC62991984b (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x6E"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x6E"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO93JIS62291984badd;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/JIS_C6229-1984-b-add iso-ir-93 jp-ocr-b-add
 csISO93JIS62291984badd/);

=item JIS_C6229-1984-b-add

JIS_C6229-1984-b-add (Alias: iso-ir-93, jp-ocr-b-add,
csISO93JIS62291984badd (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x6F"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x20"];
  $C;
}

package Encode::ISO2022::RFC1345::csISO94JIS62291984hand;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/JIS_C6229-1984-hand iso-ir-94 jp-ocr-hand
 csISO94JIS62291984hand/);

=item JIS_C6229-1984-hand

JIS_C6229-1984-hand (Alias: iso-ir-94, jp-ocr-hand,
csISO94JIS62291984hand (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x70"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x70"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO93JIS62291984badd;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/JIS_C6229-1984-hand-add iso-ir-95 jp-ocr-hand-add
 csISO93JIS62291984badd/);

=item JIS_C6229-1984-hand-add

JIS_C6229-1984-hand-add (Alias: iso-ir-95, jp-ocr-hand-add,
csISO93JIS62291984badd (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x71"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x20"];
  $C;
}

package Encode::ISO2022::RFC1345::csISO96JISC62291984kana;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/JIS_C6229-1984-kana iso-ir-96
 csISO96JISC62291984kana/);

=item JIS_C6229-1984-kana

JIS_C6229-1984-kana (Alias: iso-ir-96,
csISO96JISC62291984kana (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x72"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x20"];
  $C;
}

package Encode::ISO2022::RFC1345::csISO2033;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/ISO_2033-1983 iso-ir-98 e13b
 csISO2033/);

=item ISO_2033-1983

ISO_2033-1983 (Alias: iso-ir-98, e13b,
csISO2033 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x73"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x20"];
  $C;
}

package Encode::ISO2022::RFC1345::csISO102T617bit;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/T.61-7bit iso-ir-102 csISO102T617bit/);

=item T.61-7bit

T.61-7bit (Alias: iso-ir-102, csISO102T617bit (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x75"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x75"}];
  $C;
}


package Encode::ISO2022::RFC1345::csISO146Serbian;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/JUS_I.B1.003-serb iso-ir-146 serbian csISO146Serbian/);

=item JUS_I.B1.003-serb

JUS_I.B1.003-serb (Alias: iso-ir-146, serbian, csISO146Serbian (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x7B"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x7B"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO147Macedonian;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/JUS_I.B1.003-mac macedonian iso-ir-147
 csISO147Macedonian/);

=item JUS_I.B1.003-mac

JUS_I.B1.003-mac (Alias: macedonian, iso-ir-147, csISO147Macedonian (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x7D"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x7D"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO150GreekCCITT;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/greek-ccitt iso-ir-150 csISO150
 csISO150GreekCCITT/);

=item greek-ccitt

greek-ccitt (Alias: iso-ir-150, csISO150 (IANA), csISO150GreekCCITT (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x21\x40"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x21\x40"}];
  $C;
}




package Encode::ISO2022::RFC1345::csISO70VideotexSupp1;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/videotex-suppl iso-ir-70 csISO70VideotexSupp1/);

=item videotex-suppl

videotex-suppl (Alias: iso-ir-70, csISO70VideotexSupp1 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x74"};
  $C->{G1} = $Encode::ISO2022::CHARSET{G94}->{"\x62"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x74"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO90;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/iso-ir-90 csISO90/);

=item iso-ir-90

iso-ir-90 (Alias: csISO90 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x42"};
  $C->{G1} = $Encode::ISO2022::CHARSET{G94}->{"\x6C"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x6C"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO2033;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/ANSI_X3.110-1983 iso-ir-99 CSA_T500-1983 NAPLPS
 csISO99NAPLPS
 T.101-G2 iso-ir-128 csISO128T101G2/);

=item ANSI_X3.110-1983

ANSI_X3.110-1983 (Alias: iso-ir-99, CSA_T500-1983, NAPLPS,
csISO99NAPLPS (IANA), T.101-G2, iso-ir-128, csISO128T101G2 (IANA))

Note that C<ANSI_X3.110-1983> and C<T.101-G2> is defined as
different charset in RFC 1345 and IANAREG although they have
same definition.

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x74"};
  $C->{G1} = $Encode::ISO2022::CHARSET{G94}->{"\x7C"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x74"}];
  $C;
}

## ISO_8859-1:1987 iso-ir-100 ISO_8859-1 ISO-8859-1 latin1 l1 IBM819 CP819
## 	csISOLatin1 (IANA)
## ISO_8859-2:1987 iso-ir-101 ISO_8859-2 ISO-8859-2 latin2 l2 csISOLatin2 (IANA)

package Encode::ISO2022::RFC1345::csISO103T618bit;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/T.61-8bit T.61 iso-ir-103 csISO103T618bit/);

=item T.61-8bit

T.61-8bit (Alias: T.61, iso-ir-103, csISO103T618bit (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x7E"};
  	## TODO: GL is subset of ISO-IR 102
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x76"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x7E"}];
  $C;
}

# ISO_8859-3:1988 iso-ir-109 ISO_8859-3 ISO-8859-3 latin3 l3 csISOLatin3 (IANA)
# ISO_8859-4:1988 iso-ir-110 ISO_8859-4 ISO-8859-4 latin4 l4 csISOLatin4 (IANA)

package Encode::ISO2022::RFC1345::csISO111ECMACyrillic;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/ECMA-cyrillic iso-ir-111 csISO111ECMACyrillic/);

=item ECMA-cyrillic

ECMA-cyrillic (Alias: iso-ir-111, csISO111ECMACyrillic (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x42"};
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x40"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x42"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO123CSAZ24341985gr;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/CSA_Z243.4-1985-gr iso-ir-123 csISO123CSAZ24341985gr/);

=item CSA_Z243.4-1985-gr

CSA_Z243.4-1985-gr (Alias: iso-ir-123, csISO123CSAZ24341985gr (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x42"};
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x45"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x42"}];
  $C;
}

# ISO_8859-7:1987 iso-ir-126 ISO_8859-7 ISO-8859-7 ELOT_928 ECMA-118
#	greek greek8 csISOLatinGreek (IANA)
# ISO_8859-6:1987 iso-ir-127 ISO_8859-6 ISO-8859-6 ECMA-114 ASMO-708
#	arabic csISOLatinArabic (IANA)
# ISO_8859-8:1988 iso-ir-138 ISO_8859-8 ISO-8859-8 hebrew csISOLatinHebrew (IANA)

package Encode::ISO2022::RFC1345::CSN_369103;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/CSN_369103 iso-ir-139 csISO139CSN369103/);

=item CSN_369103

CSN_369103 (Alias: iso-ir-139, csISO139CSN369103 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x42"};
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x49"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x42"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISOTextComm;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/ISO_6937-2-add iso-ir-142 csISOTextComm/);

=item ISO_6937-2-add

ISO_6937-2-add (Alias: iso-ir-142, csISOTextComm (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x42"};
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x4A"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x42"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO143IECP271;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/IEC_P27-1 iso-ir-143 csISO143IECP271/);

=item IEC_P27-1

IEC_P27-1 (Alias: iso-ir-143, csISO143IECP271 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x42"};
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x4B"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x42"}];
  $C;
}

# ISO_8859-5:1988 iso-ir-144 ISO_8859-5 ISO-8859-5 cyrillic csISOLatinCyrillic (IANA)
# ISO_8859-9:1989 iso-ir-148 ISO_8859-9 ISO-8859-9 latin5 l5 csISOLatin5 (IANA)

package Encode::ISO2022::RFC1345::csISO6937Add;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/ISO_6937-2-25 iso-ir-152 csISO6937Add/);

=item ISO_6937-2-25

ISO_6937-2-25 (Alias: iso-ir-152, csISO6937Add (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x42"};
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x4E"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x42"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO153GOST1976874;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/GOST_19768-74 ST_SEV_358-88 iso-ir-153 csISO153GOST1976874/);

=item GOST_19768-74

GOST_19768-74 (Alias: ST_SEV_358-88, iso-ir-153, csISO153GOST1976874 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x42"};
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x4F"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x42"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO8859Supp;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/ISO_8859-supp iso-ir-154 latin1-2-5 csISO8859Supp/);

=item ISO_8859-supp

ISO_8859-supp (Alias: iso-ir-154, latin1-2-5, csISO8859Supp (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x42"};
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x50"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x42"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO10367Box;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/ISO_10367-box iso-ir-155 csISO10367Box/);

=item ISO_10367-box

ISO_10367-box (Alias: iso-ir-155, csISO10367Box (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x42"};
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x51"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x42"}];
  $C;
}

# latin6 iso-ir-157 l6 ISO-8859-10 (IANA) ISO_8859-10:1992 (IANA) csISOLatin6 (IANA)

package Encode::ISO2022::RFC1345::csISO158Lap;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/latin-lap lap iso-ir-158 csISO158Lap/);

=item latin-lap

latin-lap (Alias: lap, iso-ir-158, csISO158Lap (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{"\x42"};
  $C->{G1} = $Encode::ISO2022::CHARSET{G96}->{"\x58"};
  $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => "\x42"}];
  $C;
}


package Encode::ISO2022::RFC1345::csISO42JISC62261978;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/JIS_C6226-1978 iso-ir-42 csISO42JISC62261978/);

=item JIS_C6226-1978

JIS_C6226-1978 (Alias: iso-ir-42, csISO42JISC62261978 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  # 0x20, 0x7F = undef
  $C->{C0} = $Encode::ISO2022::CHARSET{C0}->{"\x7E"};
  $C->{G0} = $Encode::ISO2022::CHARSET{G94n}->{"\x40"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => "\x40"}];
  $C;
}

package Encode::ISO2022::RFC1345::GB_2312;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/GB_2312-80 iso-ir-58 chinese csISO58GB231280/);

=item GB_2312-80

GB_2312-80 (Alias: iso-ir-58, chinese, csISO58GB231280 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  # 0x20, 0x7F = undef
  $C->{C0} = $Encode::ISO2022::CHARSET{C0}->{"\x7E"};
  $C->{G0} = $Encode::ISO2022::CHARSET{G94n}->{"\x41"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x21\x7E", {type => 'G94n', charset => "\x41"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO87JISX0208;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/JIS_C6226-1983 iso-ir-87 x0208
 JIS_X0208-1983 csISO87JISX0208 JIS0208/);

=item JIS_C6226-1983

JIS_C6226-1978 (Alias: iso-ir-87, x0208, JIS_X0208-1983, csISO87JISX0208 (IANA),
JIS0208 (Not in RFC 1345))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  # 0x20, 0x7F = undef
  $C->{C0} = $Encode::ISO2022::CHARSET{C0}->{"\x7E"};
  $C->{G0} = $Encode::ISO2022::CHARSET{G94n}->{"\x42"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => "\x42"}];
  $C;
}

package Encode::ISO2022::RFC1345::csKSC56011987;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/KS_C_5601-1987 iso-ir-149 KS_C_5601-1989 KSC_5601
 korean csKSC56011987 KSC5601 KS_C_5601 KSC5601_1992 KSX1001 KS_X_1001:1992/);

=item KS_C_5601-1987

KS_C_5601-1987 (Alias: iso-ir-149, KS_C_5601-1989, KSC_5601, korean,
csKSC56011987 (IANA), KSC5601 (Not in RFC 1345), KS_C_5601 (Not in RFC 1345),
KSC5601_1992 (Not in RFC 1345), KSX1001 (Not in RFC 1345),
KS_X_1001:1992 (Not in RFC 1345))

Some implementions use this name to label UHC (Unified Hangul
Code).  It is a serious bug.

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  # 0x20, 0x7F = undef
  $C->{C0} = $Encode::ISO2022::CHARSET{C0}->{"\x7E"};
  $C->{G0} = $Encode::ISO2022::CHARSET{G94n}->{"\x4C"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x21\x6B", {type => 'G94n', charset => "\x4C"}];
  $C;
}

package Encode::ISO2022::RFC1345::csISO159JISX02121990;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::RFC1345';
__PACKAGE__->Define (qw/JIS_X0212-1990 x0212 iso-ir-159 csISO159JISX02121990/);

=item JIS_X0212-1990

JIS_X0212-1990 (Alias: x0212, iso-ir-159, csISO159JISX02121990 (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  # 0x20, 0x7F = undef
  $C->{C0} = $Encode::ISO2022::CHARSET{C0}->{"\x7E"};
  $C->{G0} = $Encode::ISO2022::CHARSET{G94n}->{"\x44"};
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1}; $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x22\x44", {type => 'G94n', charset => "\x44"}];
  	## INVERTED QUESTION MARK
  $C;
}

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

# $Date: 2002/10/12 07:27:01 $
### RFC1345.pm ends here
