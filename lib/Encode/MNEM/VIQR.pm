
=head1 NAME

Encode::MNEM::VIQR --- VIQR (Vietnamese Quoted Readable) encoding

=head1 ENCODINGS

=over 4

=cut

package Encode::MNEM::VIQR;
use strict;
our $VERSION = do{my @r=(q$Revision: 1.1 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw!viqr csviqr!);

our %_VIQR_TO_UCS = (
	q[A(?]	=> "\x{1EB2}",	## LATIN CAPITAL LETTER A WITH BREVE AND HOOK ABOVE
	q[A(~]	=> "\x{1EB4}",	## LATIN CAPITAL LETTER A WITH BREVE AND TILDE
	q[A^~]	=> "\x{1EAA}",	## LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND TILDE
	q[Y?]	=> "\x{1EF6}",	## LATIN CAPITAL LETTER Y WITH HOOK ABOVE
	q[Y~]	=> "\x{1EF8}",	## LATIN CAPITAL LETTER Y WITH TILDE
	q[Y.]	=> "\x{1EF4}",	## LATIN CAPITAL LETTER Y WITH DOT BELOW
	q[A.]	=> "\x{1EA0}",	## LATIN CAPITAL LETTER A WITH DOT BELOW
	q[A(']	=> "\x{1EAE}",	## LATIN CAPITAL LETTER A WITH BREVE AND ACUTE
	q[A(`]	=> "\x{1EB0}",	## LATIN CAPITAL LETTER A WITH BREVE AND GRAVE
	q[A(.]	=> "\x{1EB6}",	## LATIN CAPITAL LETTER A WITH BREVE AND DOT BELOW
	q[A^']	=> "\x{1EA4}",	## LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND ACUTE
	q[A^`]	=> "\x{1EA6}",	## LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND GRAVE
	q[A^?]	=> "\x{1EA8}",	## LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND HOOK ABOVE
	q[A^.]	=> "\x{1EAC}",	## LATIN CAPITAL LETTER A WITH CIRCUMFLEX AND DOT BELOW
	q[E~]	=> "\x{1EBC}",	## LATIN CAPITAL LETTER E WITH TILDE
	q[E.]	=> "\x{1EB8}",	## LATIN CAPITAL LETTER E WITH DOT BELOW
	q[E^']	=> "\x{1EBE}",	## LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND ACUTE
	q[E^`]	=> "\x{1EC0}",	## LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND GRAVE
	q[E^?]	=> "\x{1EC2}",	## LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND HOOK ABOVE
	q[E^~]	=> "\x{1EC4}",	## LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND TILDE
	q[E^.]	=> "\x{1EC6}",	## LATIN CAPITAL LETTER E WITH CIRCUMFLEX AND DOT BELOW
	q[O^']	=> "\x{1ED0}",	## LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND ACUTE
	q[O^`]	=> "\x{1ED2}",	## LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND GRAVE
	q[O^?]	=> "\x{1ED4}",	## LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND HOOK ABOVE
	q[O^~]	=> "\x{1ED6}",	## LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND TILDE
	q[O^.]	=> "\x{1ED8}",	## LATIN CAPITAL LETTER O WITH CIRCUMFLEX AND DOT BELOW
	q[O+.]	=> "\x{1EE2}",	## LATIN CAPITAL LETTER O WITH HORN AND DOT BELOW
	q[O+']	=> "\x{1EDA}",	## LATIN CAPITAL LETTER O WITH HORN AND ACUTE
	q[O+`]	=> "\x{1EDC}",	## LATIN CAPITAL LETTER O WITH HORN AND GRAVE
	q[O+?]	=> "\x{1EDE}",	## LATIN CAPITAL LETTER O WITH HORN AND HOOK ABOVE
	q[I.]	=> "\x{1ECA}",	## LATIN CAPITAL LETTER I WITH DOT BELOW
	q[O?]	=> "\x{1ECE}",	## LATIN CAPITAL LETTER O WITH HOOK ABOVE
	q[O.]	=> "\x{1ECC}",	## LATIN CAPITAL LETTER O WITH DOT BELOW
	q[I?]	=> "\x{1EC8}",	## LATIN CAPITAL LETTER I WITH HOOK ABOVE
	q[U?]	=> "\x{1EE6}",	## LATIN CAPITAL LETTER U WITH HOOK ABOVE
	q[U~]	=> "\x{0168}",	## LATIN CAPITAL LETTER U WITH TILDE
	q[U.]	=> "\x{1EE4}",	## LATIN CAPITAL LETTER U WITH DOT BELOW
	q[Y`]	=> "\x{1EF2}",	## LATIN CAPITAL LETTER Y WITH GRAVE
	q[O~]	=> "\x{00D5}",	## LATIN CAPITAL LETTER O WITH TILDE
	q[a(']	=> "\x{1EAF}",	## LATIN SMALL LETTER A WITH BREVE AND ACUTE
	q[a(`]	=> "\x{1EB1}",	## LATIN SMALL LETTER A WITH BREVE AND GRAVE
	q[a(.]	=> "\x{1EB7}",	## LATIN SMALL LETTER A WITH BREVE AND DOT BELOW
	q[a^']	=> "\x{1EA5}",	## LATIN SMALL LETTER A WITH CIRCUMFLEX AND ACUTE
	q[a^`]	=> "\x{1EA7}",	## LATIN SMALL LETTER A WITH CIRCUMFLEX AND GRAVE
	q[a^?]	=> "\x{1EA9}",	## LATIN SMALL LETTER A WITH CIRCUMFLEX AND HOOK ABOVE
	q[a^.]	=> "\x{1EAD}",	## LATIN SMALL LETTER A WITH CIRCUMFLEX AND DOT BELOW
	q[e~]	=> "\x{1EBD}",	## LATIN SMALL LETTER E WITH TILDE
	q[e.]	=> "\x{1EB9}",	## LATIN SMALL LETTER E WITH DOT BELOW
	q[e^']	=> "\x{1EBF}",	## LATIN SMALL LETTER E WITH CIRCUMFLEX AND ACUTE
	q[e^`]	=> "\x{1EC1}",	## LATIN SMALL LETTER E WITH CIRCUMFLEX AND GRAVE
	q[e^?]	=> "\x{1EC3}",	## LATIN SMALL LETTER E WITH CIRCUMFLEX AND HOOK ABOVE
	q[e^~]	=> "\x{1EC5}",	## LATIN SMALL LETTER E WITH CIRCUMFLEX AND TILDE
	q[e^.]	=> "\x{1EC7}",	## LATIN SMALL LETTER E WITH CIRCUMFLEX AND DOT BELOW
	q[o^']	=> "\x{1ED1}",	## LATIN SMALL LETTER O WITH CIRCUMFLEX AND ACUTE
	q[o^`]	=> "\x{1ED3}",	## LATIN SMALL LETTER O WITH CIRCUMFLEX AND GRAVE
	q[o^?]	=> "\x{1ED5}",	## LATIN SMALL LETTER O WITH CIRCUMFLEX AND HOOK ABOVE
	q[o^~]	=> "\x{1ED7}",	## LATIN SMALL LETTER O WITH CIRCUMFLEX AND TILDE
	q[O+~]	=> "\x{1EE0}",	## LATIN CAPITAL LETTER O WITH HORN AND TILDE
	q[O+]	=> "\x{01A0}",	## LATIN CAPITAL LETTER O WITH HORN
	q[o^.]	=> "\x{1ED9}",	## LATIN SMALL LETTER O WITH CIRCUMFLEX AND DOT BELOW
	q[o+`]	=> "\x{1EDD}",	## LATIN SMALL LETTER O WITH HORN AND GRAVE
	q[o+?]	=> "\x{1EDF}",	## LATIN SMALL LETTER O WITH HORN AND HOOK ABOVE
	q[i.]	=> "\x{1ECB}",	## LATIN SMALL LETTER I WITH DOT BELOW
	q[U+.]	=> "\x{1EF0}",	## LATIN CAPITAL LETTER U WITH HORN AND DOT BELOW
	q[U+']	=> "\x{1EE8}",	## LATIN CAPITAL LETTER U WITH HORN AND ACUTE
	q[U+`]	=> "\x{1EEA}",	## LATIN CAPITAL LETTER U WITH HORN AND GRAVE
	q[U+?]	=> "\x{1EEC}",	## LATIN CAPITAL LETTER U WITH HORN AND HOOK ABOVE
	q[o+]	=> "\x{01A1}",	## LATIN SMALL LETTER O WITH HORN
	q[o+']	=> "\x{1EDB}",	## LATIN SMALL LETTER O WITH HORN AND ACUTE
	q[U+]	=> "\x{01AF}",	## LATIN CAPITAL LETTER U WITH HORN
	q[A`]	=> "\x{00C0}",	## LATIN CAPITAL LETTER A WITH GRAVE
	q[A']	=> "\x{00C1}",	## LATIN CAPITAL LETTER A WITH ACUTE
	q[A^]	=> "\x{00C2}",	## LATIN CAPITAL LETTER A WITH CIRCUMFLEX
	q[A~]	=> "\x{00C3}",	## LATIN CAPITAL LETTER A WITH TILDE
	q[A?]	=> "\x{1EA2}",	## LATIN CAPITAL LETTER A WITH HOOK ABOVE
	q[A(]	=> "\x{0102}",	## LATIN CAPITAL LETTER A WITH BREVE
	q[a(?]	=> "\x{1EB3}",	## LATIN SMALL LETTER A WITH BREVE AND HOOK ABOVE
	q[a(~]	=> "\x{1EB5}",	## LATIN SMALL LETTER A WITH BREVE AND TILDE
	q[E`]	=> "\x{00C8}",	## LATIN CAPITAL LETTER E WITH GRAVE
	q[E']	=> "\x{00C9}",	## LATIN CAPITAL LETTER E WITH ACUTE
	q[E^]	=> "\x{00CA}",	## LATIN CAPITAL LETTER E WITH CIRCUMFLEX
	q[E?]	=> "\x{1EBA}",	## LATIN CAPITAL LETTER E WITH HOOK ABOVE
	q[I`]	=> "\x{00CC}",	## LATIN CAPITAL LETTER I WITH GRAVE
	q[I']	=> "\x{00CD}",	## LATIN CAPITAL LETTER I WITH ACUTE
	q[I~]	=> "\x{0128}",	## LATIN CAPITAL LETTER I WITH TILDE
	q[y`]	=> "\x{1EF3}",	## LATIN SMALL LETTER Y WITH GRAVE
	q[DD]	=> "\x{0110}",	## LATIN CAPITAL LETTER D WITH STROKE
	q[u+']	=> "\x{1EE9}",	## LATIN SMALL LETTER U WITH HORN AND ACUTE
	q[O`]	=> "\x{00D2}",	## LATIN CAPITAL LETTER O WITH GRAVE
	q[O']	=> "\x{00D3}",	## LATIN CAPITAL LETTER O WITH ACUTE
	q[O^]	=> "\x{00D4}",	## LATIN CAPITAL LETTER O WITH CIRCUMFLEX
	q[a.]	=> "\x{1EA1}",	## LATIN SMALL LETTER A WITH DOT BELOW
	q[y?]	=> "\x{1EF7}",	## LATIN SMALL LETTER Y WITH HOOK ABOVE
	q[u+`]	=> "\x{1EEB}",	## LATIN SMALL LETTER U WITH HORN AND GRAVE
	q[u+?]	=> "\x{1EED}",	## LATIN SMALL LETTER U WITH HORN AND HOOK ABOVE
	q[U`]	=> "\x{00D9}",	## LATIN CAPITAL LETTER U WITH GRAVE
	q[U']	=> "\x{00DA}",	## LATIN CAPITAL LETTER U WITH ACUTE
	q[y~]	=> "\x{1EF9}",	## LATIN SMALL LETTER Y WITH TILDE
	q[y.]	=> "\x{1EF5}",	## LATIN SMALL LETTER Y WITH DOT BELOW
	q[Y']	=> "\x{00DD}",	## LATIN CAPITAL LETTER Y WITH ACUTE
	q[o+~]	=> "\x{1EE1}",	## LATIN SMALL LETTER O WITH HORN AND TILDE
	q[u+]	=> "\x{01B0}",	## LATIN SMALL LETTER U WITH HORN
	q[a`]	=> "\x{00E0}",	## LATIN SMALL LETTER A WITH GRAVE
	q[a']	=> "\x{00E1}",	## LATIN SMALL LETTER A WITH ACUTE
	q[a^]	=> "\x{00E2}",	## LATIN SMALL LETTER A WITH CIRCUMFLEX
	q[a~]	=> "\x{00E3}",	## LATIN SMALL LETTER A WITH TILDE
	q[a?]	=> "\x{1EA3}",	## LATIN SMALL LETTER A WITH HOOK ABOVE
	q[a(]	=> "\x{0103}",	## LATIN SMALL LETTER A WITH BREVE
	q[u+~]	=> "\x{1EEF}",	## LATIN SMALL LETTER U WITH HORN AND TILDE
	q[a^~]	=> "\x{1EAB}",	## LATIN SMALL LETTER A WITH CIRCUMFLEX AND TILDE
	q[e`]	=> "\x{00E8}",	## LATIN SMALL LETTER E WITH GRAVE
	q[e']	=> "\x{00E9}",	## LATIN SMALL LETTER E WITH ACUTE
	q[e^]	=> "\x{00EA}",	## LATIN SMALL LETTER E WITH CIRCUMFLEX
	q[e?]	=> "\x{1EBB}",	## LATIN SMALL LETTER E WITH HOOK ABOVE
	q[i`]	=> "\x{00EC}",	## LATIN SMALL LETTER I WITH GRAVE
	q[i']	=> "\x{00ED}",	## LATIN SMALL LETTER I WITH ACUTE
	q[i~]	=> "\x{0129}",	## LATIN SMALL LETTER I WITH TILDE
	q[i?]	=> "\x{1EC9}",	## LATIN SMALL LETTER I WITH HOOK ABOVE
	q[dd]	=> "\x{0111}",	## LATIN SMALL LETTER D WITH STROKE
	q[u+.]	=> "\x{1EF1}",	## LATIN SMALL LETTER U WITH HORN AND DOT BELOW
	q[o`]	=> "\x{00F2}",	## LATIN SMALL LETTER O WITH GRAVE
	q[o']	=> "\x{00F3}",	## LATIN SMALL LETTER O WITH ACUTE
	q[o^]	=> "\x{00F4}",	## LATIN SMALL LETTER O WITH CIRCUMFLEX
	q[o~]	=> "\x{00F5}",	## LATIN SMALL LETTER O WITH TILDE
	q[o?]	=> "\x{1ECF}",	## LATIN SMALL LETTER O WITH HOOK ABOVE
	q[o.]	=> "\x{1ECD}",	## LATIN SMALL LETTER O WITH DOT BELOW
	q[u.]	=> "\x{1EE5}",	## LATIN SMALL LETTER U WITH DOT BELOW
	q[u`]	=> "\x{00F9}",	## LATIN SMALL LETTER U WITH GRAVE
	q[u']	=> "\x{00FA}",	## LATIN SMALL LETTER U WITH ACUTE
	q[u~]	=> "\x{0169}",	## LATIN SMALL LETTER U WITH TILDE
	q[u?]	=> "\x{1EE7}",	## LATIN SMALL LETTER U WITH HOOK ABOVE
	q[y']	=> "\x{00FD}",	## LATIN SMALL LETTER Y WITH ACUTE
	q[o+.]	=> "\x{1EE3}",	## LATIN SMALL LETTER O WITH HORN AND DOT BELOW
	q[U+~]	=> "\x{1EEE}",	## LATIN CAPITAL LETTER U WITH HORN AND TILDE
	
	## Some people use [OoUu]\* instead of [OoUu]\+.
	## VNTeX uses [Oo][Oo]|[Uu][Uu] instead of [OoUu]\+.
);
our %_UCS_TO_VIQR = reverse %_VIQR_TO_UCS;

=item viqr

Vietnamese quoted readable -- the mnemonic encoding for
Vietnamese.  (Alias: csviqr (IANA))

=cut

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  my $char = $obj->__reg_mnem;
  $str =~ s{(\\(?:$char|.)|$char|\x01)}{
    my $c = $1;
    if (length ($c) > 1) {
      "\\" . substr ($c, 0, 1) . "\\" . substr ($c, 1);
    } else {
      "\\" . $c;
    }
  }ge;
  $str =~ s{([\x{00C0}-\x{01FF}\x{1EA0}-\x{1EFF}])}{
    $_UCS_TO_VIQR{$1} || $1;
  }ge;
  if ($chk == 0x0100) {
    $str =~ s/([^\x00-\x7F])/sprintf '\x{%04X}', ord $1/ge;
  } elsif ($chk == 0x0200) {
    $str =~ s/([^\x00-\x7F])/sprintf '&#%d;', ord $1/ge;
  } elsif ($chk == 0x0200) {
    $str =~ s/([^\x00-\x7F])/sprintf '&#x%04X;', ord $1/ge;
  } else {
    $str =~ s/[^\x00-\x7F]/\?/g;
  }
  Encode::_utf8_off ($str);
  return "\\V".$str;
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  my $char = $obj->__reg_mnem;
  $str = "\\V".$str;
  $str =~ s{
    \\([LlMmVv])((?:(?!\\[LlMmVv]).)+)
  }{
    my ($mode, $s) = (uc ($1), $2);
    if ($mode eq 'V') {	## Vietnamese
      $s =~ s{\\($char|.)|($char)|\x01}{
        my ($e, $c) = ($1, $2);
        if ($c || length ($e) > 1) {
          $_VIQR_TO_UCS{$c || $e} || $c || $e;
        } else {
          $e;
        }
      }ges;
      $s;
    } elsif ($mode eq 'M') {	## English
      $s =~ s{\\($char|.)}{
        my ($e) = ($1);
        if (length ($e) > 1) {
          $_VIQR_TO_UCS{$e} || $e;
        } else {
          $e;
        }
      }ges;
      $s;
    } else {	## Literala
      $s;
    }
  }gesx;
  return $str;
}

sub __reg_mnem ($) { q/[AEIOUYaeiouy][(^+,`?~.]+|[Dd][Dd]/ }

1;
__END__

=back

Note that it is known that there is variants of VIQR.
One use "O*" / "U*" instead of "O+" / "U+".  Other
use "OO" / "UU".  Since I don't know how these variants
are used and inclution of these notation is incompatible,
this version of this module does not implement these.

=head1 SEE ALSO

<http://www.vietstd.org/report/rep92.htm>,
RFC 1456 <urn:ietf:rfc:1456>

=head1 LICENSE

Copyright 2002 Nanashi-san <nanashi@san.invalid>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/12/12 08:17:16 $
