package Encode::HZ;
use strict;

use vars qw($VERSION);
$VERSION = do {my @r =(q$Revision: 1.2 $ =~ /\d+/g);sprintf "%d."."%02d" x $#r, @r};

use Encode ();
require Encode::CN;
use base qw(Encode::Encoding);
__PACKAGE__->Define(qw/hz hz-gb-2312/);

sub needs_lines  { 1 }

sub perlio_ok { 
    return 0; # for the time being
}

sub decode
{
    my ($obj,$str,$chk) = @_;
    my $gb = Encode::find_encoding('gb2312-raw');

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
        $c =~ tr/\xA1-\xFE/\x21-\x7E/;
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
  my $gb = Encode::find_encoding('euc-cn');
  
  $str =~ s/~/~~/g;
  $str = $gb->encode ($str, 1);
  
  $str =~ s{ ((?:[\xA1-\xFE][\xA1-\xFE])+) }{
    my $c = $1;
    $c =~ tr/\xA1-\xFE/\x21-\x7E/;
    sprintf q(~{%s~}), $c;
  }goex;
  $str;
}

package Encode::HZ::HZ8;

use base qw(Encode::HZ);
__PACKAGE__->Define(qw/hz8 x-hz8/);

sub encode ($$;$) {
  my ($obj,$str,$chk) = @_;
  $_[1] = '';
  my $gb = Encode::find_encoding('euc-cn');
  
  $str =~ s/~/~~/g;
  $str = $gb->encode ($str, 1);
  
  $str =~ s{ ((?:[\xA1-\xFE][\xA1-\xFE])+) }{
    sprintf q(~{%s~}), $1;
  }goex;
  $str;
}

1;
__END__


=head1 NAME

Encode::HZ --- Encode module for HZ (HZ-GB-2312), HZ8

=head1 DESCRIPTION

This module make the module Encode of Perl (5.7.3 or later)
to be able to encode/decode HZ and its variant coding systems.

Note that Encode::CN::HZ, standard module of Perl, can encode/decode
HZ (HZ-GB-2312 in IANA name), but other variants such as
HZ8 can't be encoded/decode.

=head1 TODO

Support of extended HZ such as EHZ.

=head1 ACKNOWLEDGEMENTS

Most part of this module is taken from Encode::CN::HZ.

=head1 COPYRIGHT

Copyright 2002 Wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut
