require 5.7.3;
package Encode::EUCFixed;
use strict;
use vars qw(%DEFAULT $VERSION);
$VERSION=do{my @r=(q$Revision: 1.2 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};

package Encode::EUCFixed::JP;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/Extended_UNIX_Code_Fixed_Width_for_Japanese csEUCFixWidJapanese/);

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str = Encode::encode ('euc-jp', $str);
  $str =~ s{
     ([\x00-\x8D\x90-\xA0\xFF])	## CS0: ASCII
    #([\xA0-\xFE][\xA0-\xFE])	## CS1: JIS X 0208-1990
    |\x8E([\xA0-\xFE])	## CS2: JIS X 0201 Katakana
    |\x8F([\xA0-\xFE])([\xA0-\xFE])	## CS3: JIS X 0212-1990
  }{
    my ($c0, $c2, $c31, $c32) = ($1, $2, $3, $4);
    if    ($c0) {                                 "\x00".$c0 }
    elsif ($c2) {                                 "\x00".$c2 }
    else        { $c31 =~ tr/\xA1-\xFE/\x21-\x7E/; $c31.$c32 }
  }gex;
  return $str;
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str =~ s{
     \x00([\x00-\xA0\xFF])	## CS0: ASCII
    #([\xA1-\xFE][\xA1-\xFE])	## CS1: JIS X 0208-1990
    |\x00([\xA1-\xFE])	## CS2: JIS X 0201 Katakana
    |([\x21-\x7E][\xA1-\xFE])	## CS3: JIS X 0201-1990
  }{
    my ($c0, $c1, $c3) = ($1, $2, $3);
    if    ($c0) {                                 $c0 }
    elsif ($c1) { $c1 =~ tr/\x80-\xFF/\x00-\x7F/; $c1 }
    else        { $c3 =~ tr/\x80-\xFF/\x00-\x7F/; $c3 }
  }gex;
  return Encode::decode ('euc-jp', $str);
}

package Encode::EUCFixed::TW;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/cns-11643-1986-appendix/);

sub encode ($$;$) {
  require Encode::HanExtra;
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str = Encode::encode ('euc-tw', $str);
  $str =~ s{
     ([\x00-\x8D\x90-\xA0\xFF])	## CS0: ASCII
    #([\xA0-\xFE][\xA0-\xFE])	## CS1: CNS 11643 plane 1
    |\x8E\xA1([\xA0-\xFE][\xA0-\xFE])	## CNS 11643 plane 1
    |\x8E\xA2([\xA0-\xFE])([\xA0-\xFE])	## CNS 11643 plane 2
    |\x8E([\xA3-\xFE][\xA0-\xFE][\xA0-\xFE])
  }{
    my ($c0, $p1, $p21, $p22, $p3) = ($1, $2, $3, $4, $5);
    if    ($c0)  {                                 "\x00".$c0 }
    elsif ($p1)  {                                        $p1 }
    elsif ($p21) { $p22 =~ tr/\xA1-\xFE/\x21-\x7E/; $p21.$p22 }
    else        { "\x00\x3F" }	## BUG: don't use fallback
  }gex;
  return $str;
}

sub decode ($$;$) {
  require Encode::HanExtra;
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str =~ s{
     \x00([\x00-\xFF])	## CS0: ASCII
    #([\xA1-\xFE][\xA1-\xFE])	## CS1: CNS 11643 plane 1
    |([\xA1-\xFE][\x21-\x7E])	## CNS 11643 plane 2
  }{
    my ($c0, $p2) = ($1, $2);
    if    ($c0) {                                 $c0 }
    else        { $p2 =~ tr/\x21-\x7E/\xA1-\xFE/; $p2 }
  }gex;
  return Encode::decode ('euc-tw', $str);
}

1;
__END__

=head1 NAME

Encode::EUCFixed --- Fixed width (or wide) coding system of EUC

=head1 LICENSE

Copyright 2002 Wakaba <w@suika.fam.cx>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=head1 CHANGE

Last update $Date: 2002/09/20 14:01:45 $

=cut
