package Encode::HZ;
use strict;

use vars qw($VERSION);
$VERSION = do {my @r =(q$Revision: 1.4 $ =~ /\d+/g);sprintf "%d."."%02d" x $#r, @r};
use base qw(Encode::Encoding);
__PACKAGE__->Define(qw/hz chinese-hz hz-gb-2312 hz-gb2312 cp52936/);

sub needs_lines  { 1 }

sub perlio_ok { 
    return 0; # for the time being
}

sub decode
{
    my ($obj,$str,$chk) = @_;
    my $gb = Encode::find_encoding($obj->__hz_encoding_name);

    $str =~ s{~			# starting tilde
	(?:
	    (~)			# another tilde - escaped (set $1)
		|		#     or
	    \x0D?\x0A			# \n - output nothing
		|		#     or
	    \{			# opening brace of GB data
		(		#  set $2 to any number of...
		    (?:	
			[^~]	#  non-tilde GB character
			    |   #     or
			~(?!\}) #  tilde not followed by a closing brace
		    )*
		)
	    ~\}			# closing brace of GB data
		|		# XXX: invalid escape - maybe die on $chk?
	)
    }{
      my ($t, $c) = ($1, $2);
      if (defined $t) {	# two tildes make one tilde
        '~';
      } elsif (defined $c) {	# decode the characters
        $c =~ tr/\x21-\x7E/\xA1-\xFE/;
        $gb->decode($c, $chk);
      } else {	# ~\n and invalid escape = ''
        '';
      }
    }egx;
    
    return $str;
}

sub encode ($$;$) {
  my ($obj,$str,$chk) = @_;
  $_[1] = '';
  my $gb = Encode::find_encoding($obj->__hz_encoding_name);
  
  $str =~ s/~/~~/g;
  $str = $gb->encode ($str, 1);
  
  $str =~ s{ ((?:[\xA1-\xFE][\xA1-\xFE])+) }{
    my $c = $1;
    $c =~ tr/\xA1-\xFE/\x21-\x7E/;
    sprintf q(~{%s~}), $c;
  }goex;
  $str;
}

sub __hz_encoding_name { 'euc-cn' }

package Encode::HZ::HZ8;
use base qw(Encode::HZ);
__PACKAGE__->Define(qw/hz8 x-hz8/);

sub encode ($$;$) {
  my ($obj,$str,$chk) = @_;
  $_[1] = '';
  my $gb = Encode::find_encoding($obj->__hz_encoding_name);
  
  $str =~ s/~/~~/g;
  $str = $gb->encode ($str, 1);
  
  $str =~ s{ ((?:[\xA1-\xFE][\xA1-\xFE])+) }{
    sprintf q(~{%s~}), $1;
  }goex;
  $str;
}

package Encode::HZ::HZ165;
use base qw(Encode::HZ);
__PACKAGE__->Define(qw/hz-iso-ir-165 hz-isoir165 x-iso-ir-165-hz/);

sub __hz_encoding_name { 'cn-gb-isoir165' }

1;
__END__

=head1 NAME

Encode::HZ --- Encode module for HZ (HZ-GB-2312 and HZ for
ISO-IR 165) and HZ8

=head1 DESCRIPTION

This module make the module Encode of Perl (5.7.3 or later)
to be able to encode/decode HZ and its variant coding systems.

Note that Encode::CN::HZ, standard module of Perl, can encode/decode
HZ (HZ-GB-2312 in IANA name), but other variants such as
HZ8 can't be encoded/decode.

=head1 ENCODINGS

=over 4

=item hz-gb-2312

HZ 7-bit encoding for Chinese with GB 2312-80,
defined by RFC 1842 and RFC 1843.
(Alias: hz, chinese-hz (emacsen), CP52936 (M$),
hz-gb2312)

Note that hz8 is also decodable with this encoding.

=item hz8

HZ 8-bit encoding for Chinese with GB 2312-80.
(Alias: x-hz8)

Note that hz-gb-2312 is also decodable with this encoding.

=item hz-iso-ir-165

HZ 7-bit encoding for Chinese with ISO-IR 165
(syntax is same as hz-gb-2312, but coded character
set is differ) (Alias: hz-isoir165, x-iso-ir-165-hz)

Note that you need load Encode module that support
'cn-gb-isoir165' encoding (defined by RFC 1922),
such as Encode::ISO2022::EightBit.

Also note that since ISO-IR 165 is nealy superset of GB 2312-80,
hz-iso-ir-165 is also considerable as a superset of
hz-gb-2312.

=back

=head1 TODO

Support of extended HZ such as EHZ.

=head1 ACKNOWLEDGEMENTS

Most part of this module is taken from Encode::CN::HZ.

=head1 COPYRIGHT

Copyright 2002 Wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/10/14 06:58:35 $
### HZ.pm ends here
