=head1 NAME

Encode::ISO2022::RFC1345 --- Encode and decode of ISO/IEC 2022
based encodings described in IETF RFC 1345 (and not defined by
other standards)

=head1 ENCODINGS

=over 4

=cut

require 5.7.3;
use strict;
package Encode::ISO2022::RFC1345;
use vars qw($VERSION);
$VERSION=do{my @r=(q$Revision: 1.1 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
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

1;
__END__

=back

Note that although other JISes such as JIS X 0212 and JIS X 9010
define ISO/IEC 2022-comfprming coded character sets,
these standards do not define complete coding system (but define
as used on ISO/IEC 2022 environment), so this module
does not include those coded character sets.  (IETF RFC 1345
and IANAREG give charset name to coded character sets
consist of such standards.  But those are defined by RFC 1345,
not by JIS.  Such coded character sets should be implemented
in Encode::ISO2022::RFC1345.)

=head1 LICENSE

Copyright 2002 Wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/09/22 11:08:23 $
### JIS.pm ends here
