=head1 NAME

C<Encode::ISO2022::JIS> --- Encode and decode of ISO/IEC 2022
based encodings defined by JIS (Japan Industrial Standard),
other than RFC 1468 coded representation, C<ISO-2022-JP-3>
coded representations and C<EUC-JISX0213> coded representations

=head1 ENCODINGS

=over 4

=cut

require 5.7.3;
use strict;
package Encode::ISO2022::JIS;
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
  $C->{option}->{undef_char} = ["\x22\x2E",	## GETA MARK
    {type => 'G94n', charset => 'B', revision => '@'}];
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C;
}
sub __2022_decode ($) {
  my $C = shift->__2022__common;
  $C;
}

package Encode::ISO2022::JIS::JISX0201Latin7;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0201-1997-latin-7bit JIS_C6220-1969-ro
 iso-ir-14 ir14 jp ISO646-JP 646-jp csISO14JISC6220ro/);

=item jisx0201-1997-latin-7bit

JIS X 0201:1997 6.1 7-bit code for Latin.
(Alias: C<JIS_C6220-1969-ro> (RFC 1345), C<iso-ir-14> (RFC 1345),
C<ir14>, C<jp> (RFC 1345), C<ISO646-JP> (RFC 1345), C<646-jp>,
C<csISO14JISC6220ro> (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{J};	## JIS X 0201:1997 Latin set
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1};	## RFC 1345 (not in JIS)
  $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => 'J'}];
  $C;
}

package Encode::ISO2022::JIS::JISX0201Katakana7;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0201-1997-katakana-7bit JIS_C6220-1969-jp JIS_C6220-1969
 iso-ir-13 ir13 katakana x0201-7 csISO13JISC6220jp/);

=item jisx0201-1997-katakana-7bit

JIS X 0201:1997 6.2 7-bit code for Katakana
(Alias: JIS_C6220-1969-jp (RFC 1345), JIS_C6220-1969 (RFC 1345),
iso-ir-13 (RFC 1345), ir13, katakana (RFC 1345), x0201-7 (RFC 1345),
csISO13JISC6220jp (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{I};	## JIS X 0201:1997 Katakana set
  $C->{G1} = $C->{G0}; $C->{G2} = $C->{G1};	## RFC 1345 (not in JIS)
  $C->{G3} = $C->{G1};
  $C->{option}->{undef_char} = ["\x25", {type => 'G94', charset => 'I'}];
  $C;
}

package Encode::ISO2022::JIS::JISX0201LatinKatakana7;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0201-1997-latin-katakana-7bit
 JIS_X0201 X0201 csHalfWidthKatakana/);

=item jisx0201-1997-latin-katakana-7bit

JIS X 0201:1997 6.3 7-bit code for Latin and Katakana
(Alias: JIS_X0201 (RFC 1345), X0201 (RFC 1345), csHalfWidthKatakana (IANA))

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{J};	## JIS X 0201:1997 Latin set
  $C->{G1} = $Encode::ISO2022::CHARSET{G94}->{I};	## JIS X 0201:1997 Katakana set
  $C->{option}->{Ginvoke_to_left} = [1,1,1,1];
  $C->{option}->{reset}->{Ginvoke} = 1;
  	## JIS X 0201:1997 does not specify this limitation.
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => 'J'}];
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C;
}

package Encode::ISO2022::JIS::JISX0201LatinKatakana8;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0201-1997-latin-latin-8bit/);

=item jisx0201-1997-latin-katakana-8bit

JIS X 0208:1997 7.4 8-bit code for Latin and Katakana

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{J};	## JIS X 0201:1997 Latin set
  $C->{G1} = $Encode::ISO2022::CHARSET{G94}->{I};	## JIS X 0201:1997 Katakana set
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => 'J'}];
  $C->{option}->{C1invoke_to_right} = 1;
  $C;
}

package Encode::ISO2022::JIS::JISX0208Kanji7;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0208-1997-kanji-7bit/);

=item jisx0208-1997-kanji-7bit

JIS X 0208:1997 7.1.1 7-bit code for Kanji

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C;
}

package Encode::ISO2022::JIS::JISX0208Kanji8;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0208-1997-kanji-8bit/);

=item jisx0208-1997-kanji-8bit

JIS X 0208:1997 7.1.2 8-bit code for Kanji

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{G1} = $Encode::ISO2022::CHARSET{G94}->{"\x7E"};	## empty
  $C->{option}->{C1invoke_to_right} = 1;
  $C;
}

package Encode::ISO2022::JIS::JISX0208IRVKanji7;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0208-1997-irv-kanji-7bit/);

=item jisx0208-1997-irv-kanji-7bit

JIS X 0208:1997 7.2.1 7-bit code for IRV and Kanji

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{B};	## ISO/IEC 646 IRV
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{option}->{Ginvoke_to_left} = [1,1,1,1];
  $C->{option}->{reset}->{Ginvoke} = 1;
  	## JIS X 0208:1997 does not specify this limitation.
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C;
}

package Encode::ISO2022::JIS::JISX0208IRVKanji8;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0208-1997-irv-kanji-8bit/);

=item jisx0208-1997-irv-kanji-8bit

JIS X 0208:1997 7.2.2 8-bit code for IRV and Kanji.
(A subset of EUC-japan)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{B};	## ISO/IEC 646 IRV
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{option}->{C1invoke_to_right} = 1;
  $C;
}

package Encode::ISO2022::JIS::JISX0208LatinKanji7;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0208-1997-latin-kanji-7bit/);

=item jisx0208-1997-latin-kanji-7bit

JIS X 0208:1997 7.3.1 7-bit code for Latin and Kanji

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{J};	## JIS X 0201:1997 Latin set
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{option}->{Ginvoke_to_left} = [1,1,1,1];
  $C->{option}->{reset}->{Ginvoke} = 1;
  	## JIS X 0208:1997 does not specify this limitation.
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C;
}

package Encode::ISO2022::JIS::JISX0208LatinKanji8;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0208-1997-latin-kanji-8bit/);

=item jisx0208-1997-latin-kanji-8bit

JIS X 0208:1997 7.2.2 8-bit code for Latin and Kanji

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{J};	## JIS X 0201:1997 Latin set
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{'B@'};	## JIS X 0208:1997
  $C->{option}->{C1invoke_to_right} = 1;
  $C;
}

package Encode::ISO2022::JIS::JISX0213Kanji7;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0213-2000-kanji-7bit/);

=item jisx0213-2000-kanji-7bit

JIS X 0213:2000 7.1.1 7-bit code for Kanji

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94n}->{O};	## plane 1
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{P};	## plane 2
  $C->{option}->{Ginvoke_to_left} = [1,1,1,1];
  $C->{option}->{reset}->{Ginvoke} = 1;
  	## JIS X 0213:2000 does not specify this limitation.
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C;
}

package Encode::ISO2022::JIS::JISX0213Kanji8;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0213-2000-kanji-8bit/);

=item jisx0213-2000-kanji-8bit

JIS X 0213:2000 7.1.2 8-bit code for Kanji

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94n}->{O};	## plane 1
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{P};	## plane 2
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C->{option}->{C1invoke_to_right} = 1;
  $C;
}

package Encode::ISO2022::JIS::JISX0213IRVKanji7;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0213-2000-irv-kanji-7bit/);

=item jisx0213-2000-irv-kanji-7bit

JIS X 0213:2000 7.2.1 7-bit code for IRV and Kanji

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{B};	## ISO/IEC 646 IRV
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{O};	## plane 1
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{P};	## plane 2
  $C->{option}->{Ginvoke_by_single_shift}->[3] = 1;
  $C->{option}->{Ginvoke_to_left} = [1,1,1,1];
  $C->{option}->{reset}->{Ginvoke} = 1;
  	## JIS X 0213:2000 does not specify this limitation.
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C;
}

package Encode::ISO2022::JIS::JISX0213IRVKanji8;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0213-2000-irv-kanji-8bit/);

=item jisx0213-2000-irv-kanji-8bit

JIS X 0213:2000 7.2.2 8-bit code for IRV and Kanji.
(A subset of EUC-JISX0213)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{B};	## ISO/IEC 646 IRV
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{O};	## plane 1
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{P};	## plane 2
  $C->{option}->{Ginvoke_by_single_shift}->[3] = 1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C->{option}->{C1invoke_to_right} = 1;
  $C;
}

package Encode::ISO2022::JIS::JISX0213LatinKanji7;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0213-2000-latin-kanji-7bit/);

=item jisx0213-2000-latin-kanji-7bit

JIS X 0213:2000 7.3.1 7-bit code for Latin and Kanji

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{J};	## JIS X 0201:1997 Latin set
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{O};	## plane 1
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{P};	## plane 2
  $C->{option}->{Ginvoke_by_single_shift}->[3] = 1;
  $C->{option}->{Ginvoke_to_left} = [1,1,1,1];
  $C->{option}->{reset}->{Ginvoke} = 1;
  	## JIS X 0213:2000 does not specify this limitation.
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C;
}
sub __2022_encode ($) {
  my $C = shift->__2022__common;
  $C->{GR} = undef;
  $C;
}

package Encode::ISO2022::JIS::JISX0213LatinKanji8;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx0213-2000-latin-kanji-8bit/);

=item jisx0213-2000-latin-kanji-8bit

JIS X 0213:2000 7.2.2 8-bit code for Latin and Kanji

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 8;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94}->{J};	## JIS X 0201:1997 Latin set
  $C->{G1} = $Encode::ISO2022::CHARSET{G94n}->{O};	## plane 1
  $C->{G3} = $Encode::ISO2022::CHARSET{G94n}->{P};	## plane 2
  $C->{option}->{Ginvoke_by_single_shift}->[3] = 1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{undef_char} = ["\x22\x2E", {type => 'G94n', charset => 'O'}];
  $C->{option}->{C1invoke_to_right} = 1;
  $C;
}

package Encode::ISO2022::JIS::JISX4001Text7;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS';
__PACKAGE__->Define (qw/jisx4001-text-7bit/);

=item jisx4001-text-7bit

JIS X 4001-1989 text (7-bit code)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{G0} = $Encode::ISO2022::CHARSET{G94n}->{B};	## JIS X 0208-1983
  $C->{option}->{designate_to}->{G94}->{J} = 0;	## JIS X 0201 Roman
  $C->{option}->{designate_to}->{G94n}->{B} = 0;	## JIS X 0208-1983
  $C;
}

package Encode::ISO2022::JIS::JISX4001Text8;
use vars qw/@ISA/;
push @ISA, 'Encode::ISO2022::JIS::JISX4001Text7';
__PACKAGE__->Define (qw/jisx4001-text-8bit/);

=item jisx4001-text-8bit

JIS X 4001-1989 text (8-bit code)

=cut

sub __2022__common ($) {
  my $C = shift->SUPER::__2022__common;
  $C->{bit} = 7;
  $C->{option}->{C1invoke_to_right} = 1;
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
