
=head1 NAME

jcode.pl wrapper module --- jcode.pl compatible interface of Encode
modules

=head1 DESCRIPTION

Since the perl4 age, C<jcode.pl> is widely used to convert Japanese
coding systems.  With the release of perl 5.8, which includes
new standarized convertion module of C<Encode>, jcode.pl is
finally expected to be obsoleted.  But there are so many scripts
using jcode.pl that we cannot delete old jcode.pl soon.

This library provides the same interface with original jcode.pl
but actual convertion process is done by Encode modules.

=cut

package jcode;
use strict;
use 5.7.3;
require Encode::ISO2022::SevenBit;
require Encode::ISO2022::EightBit;
require Encode::SJIS::JIS;
require Encode::Table;
require Encode::Table::JISEditions;

## jcode.pl interface
our $rcsid = q$Id: jcode.pl,v 1.1 2002/10/14 07:02:02 wakaba Exp $;
our $version;
our (%convf, %h2zf, %z2hf);

## Original variables
our $VERSION=do{my @r=(q$Revision: 1.1 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
my $__encoder = {};
our $WIDTH_COMPATIBLE = 1;
our $UNIFY_LATIN_IRV = 1;
my $__re_hyphen = '';

=item $jcode::VERSION

Version of this wrapper library, in standard perl5 style.
(This variable is not implemented in original jcode.pl.)

=item $jcode::UNIFY_LATIN_IRV = 0/1

If true, JIS X 0201 latin set is code-point-unified with
ISO/IEC 646 IRV (ASCII).  Default is 1.  (This variable is
not implemented in original jcode.pl.)

=item $jcode::WIDTH_COMPATIBLE = 0/1

If true, separate fullwidth and halfwidth characters
so that convertion result will be same as that of original
jcode.pl.  (This variable is not implemented in original jcode.pl.)

Default is 1.

=cut

&init unless defined $version;

=item jcode::init ()

Initialization of this wrapper module.  Like original jcode.pl,
this procedure NEED NOT be called by hand.  It is automatically
called.

In spite of sameness of function name, its process is not
same as that of original jcode.pl's.

=cut

sub init () {
  $version = $rcsid =~ /,v ([0-9.]+)/ ? $1 : 'unknown';
  $__encoder->{jis} = Encode::find_encoding ('iso-2022-jp');
  $__encoder->{euc} = Encode::find_encoding ('euc-jp');
  $__encoder->{sjis} = Encode::find_encoding ('shift_jis');
  $__encoder->{sjisA} = Encode::find_encoding ('shift_jis-ascii');
  for (qw/jis euc sjis sjisA/) {
    $__encoder->{$_}->{_encode_mapping} = 0;
    $__encoder->{$_}->{_decode_mapping} = 0;
  }
  my $start94n = 0xE9F6C0;	## HYPHEN == 01-30 == 0x213E
  for (0x40-0x30, 0x42-0x30, 79, 0x4F-0x30) {
    $__re_hyphen .= chr ($start94n + 94*94*$_ + 29);
  }
  
  no strict 'refs';
  for my $in (qw/jis sjis euc/) {
    for my $out (qw/jis sjis euc/) {
      $convf{$in, $out} = *{ qq(${in}2${out}) };
    }
    $h2zf{$in} = *{ qq(h2z_${in}) };
    $z2hf{$in} = *{ qq(z2h_${in}) };
  }
}

=item jcode::get_inout (@)

This function does not work with this wrapper library.

=item jcode::jis_inout (@)

This function does not work with this wrapper library.

=cut

sub get_inout (@) {
  warn "$0: jcode.pl: get_inout is called but do nothing";
}

sub jis_inout (@) {
  warn "$0: jcode.pl: jis_inout is called but do nothing";
}

=item jcode::getcode (\$s)

Guess coding system of $s and return it.  Possible returned
values are 'jis' (7-bit ISO/IEC 2022 (superset of ISO-2022-JP)),
'euc' (Japanese EUC), 'sjis' (Shift JIS) or undef (detection
is failed).  Although original jcode.pl may return 'binary',
this library does not return it.

=cut

sub getcode (\$) {
  my $s = shift;
  require Encode::Guess;
  my $e = Encode::Guess::guess_encoding ($$s, qw/euc-jp shiftjis 7bit-jis/);
  $e = $e->name if ref $e;
  my $code;
  if ($e =~ /shift/) {
    $code = 'sjis';
  } elsif ($e =~ /euc/) {
    $code = 'euc';
  } elsif ($e =~ /jis/) {
    $code = 'jis';
  } elsif ($e =~ /utf-?8/) {
    $code = 'utf8';
  }
  my $matched;	## $matched is not implemented.
  wantarray ? ($matched, $code) : $code;
}
# Internal-used function jcode::max is not implemented.

=item jcode::convert (\$s, [$output_code, $input_code, $option])

Convert $s from $input_code to $output_code (with $option).
If $input_code is not specified, guessed value is used.
Likewise unless $output_code 'jis' is supporsed.

=cut

sub convert (\$;$$$) {
  my ($s, $output, $input, $option) = @_;
  return (undef, undef) unless $input = $input || &getcode ($s);
  return (undef, $input) if $input eq 'binary';
  $output ||= 'jis';
  $output = $input if $output eq 'noconv';
  my $f = $convf{$input, $output};
  &$f ($s, $option);
  wantarray ? ($f, $input) : $input;
}

=item jcode::jis ($output_code, $s, [$input_code, $option])

Return $s as 7-bit ISO/IEC 2022 string.

=item jcode::euc ($output_code, $s, [$input_code, $option])

Return $s as Japanese EUC string.

=item jcode::sjis ($output_code, $s, [$input_code, $option])

Return $s as Shift JIS string.

=cut

sub jis ($;$$) { &to (jis => @_) }
sub euc ($;$$) { &to (euc => @_) }
sub sjis ($;$$) { &to (sjis => @_) }

=item jcode::to ($output_code, $s, [$input_code, $option])

Return-by-value interface of &convert.

=item jcode::what ($s)

Return-by-value interface of &getcode.

=item jcode::trans ($s, @)

Return-by-value interface of &tr.

=cut

sub to ($$;$$) {
  my ($output, $s, $input, $option) = @_;
  &convert (\$s, $output, $input, $option);
  $s;
}

sub what ($) {
  my $s = shift;
  &getcode (\$s);
}

sub trans ($@) {
  my $s = shift;
  &tr (\$s, @_);
  $s;
}

sub sjis2jis ($;$$) {
  my ($s, $option, $n) = @_;
  $$s = $__encoder->{sjis}->decode ($$s);
  my @tbl;
  push @tbl, 'jisx0201_katakana_to_jisx0208_1990' if !$WIDTH_COMPATIBLE || $option =~ /z/;
  push @tbl, 'jisx0208_1990_to_jisx0201_katakana' if $option =~ /h/;
  push @tbl, 'jisx0201_latin_to_ascii__cpunify' if $UNIFY_LATIN_IRV;
  $$s = Encode::Table::convert ($$s, \@tbl);
  $$s = Encode::Table::convert ($$s, [qw/jisx0208_1990_to_ascii/]) unless $WIDTH_COMPATIBLE;
  #my @tbl = qw/jisx0208_1990_to_1983__cpunify/;
  #push @tbl, 'jisx0201_latin_to_ascii__cpunify' if $UNIFY_LATIN_IRV;
  #$$s = Encode::Table::convert ($$s, \@tbl);
  $$s = $__encoder->{jis}->encode ($$s);
  $n;
}
# Internal-use-functions _sjis2jis, __sjis2jis are not implemented.

sub euc2jis ($;$$) {
  my ($s, $option, $n) = @_;
  $$s = $__encoder->{euc}->decode ($$s);
  my @tbl;
  push @tbl, 'jisx0201_katakana_to_jisx0208_1990' if !$WIDTH_COMPATIBLE || $option =~ /z/;
  push @tbl, 'jisx0208_1990_to_jisx0201_katakana' if $option =~ /h/;
  $$s = Encode::Table::convert ($$s, \@tbl);
  $$s = Encode::Table::convert ($$s, [qw/jisx0208_1990_to_ascii/]) unless $WIDTH_COMPATIBLE;
  #my @tbl = qw/jisx0208_1990_to_1983__cpunify/;
  #push @tbl, 'jisx0201_latin_to_ascii__cpunify' if $UNIFY_LATIN_IRV;
  $$s = Encode::Table::convert ($$s, \@tbl);
  $$s = $__encoder->{jis}->encode ($$s);
  $n;
}
# Internal-use-functions _euc2jis, __euc2jis are not implemented.

sub jis2euc ($;$$) {
  my ($s, $option, $n) = @_;
  $$s = $__encoder->{jis}->decode ($$s);
  my @tbl = qw/jisx0208_1983_to_1990__cpunify/;
  $$s = Encode::Table::convert ($$s, \@tbl);
  $$s = Encode::Table::convert ($$s, [qw/jisx0208_1990_to_ascii/]) unless $WIDTH_COMPATIBLE;
  my @tbl;
  push @tbl, 'jisx0201_latin_to_ascii__cpunify' if $UNIFY_LATIN_IRV;
  push @tbl, 'jisx0201_katakana_to_jisx0208_1990' if !$WIDTH_COMPATIBLE || $option =~ /z/;
  push @tbl, 'jisx0208_1990_to_jisx0201_katakana' if $option =~ /h/;
  $$s = Encode::Table::convert ($$s, \@tbl);
  $$s = $__encoder->{euc}->encode ($$s);
  $n;
}
# Internal-use-function _jis2euc is not implemented.

sub jis2sjis (\$;$$) {
  my ($s, $option, $n) = @_;
  $$s = $__encoder->{jis}->decode ($$s);
  my @tbl = qw/jisx0208_1983_to_1990__cpunify/;
  $$s = Encode::Table::convert ($$s, \@tbl);
  $$s = Encode::Table::convert ($$s, [qw/jisx0208_1990_to_ascii/]) unless $WIDTH_COMPATIBLE;
  my @tbl;
  push @tbl, 'ascii_to_jisx0201_latin__cpunify' if $UNIFY_LATIN_IRV;
  push @tbl, 'jisx0201_katakana_to_jisx0208_1990' if !$WIDTH_COMPATIBLE || $option =~ /z/;
  push @tbl, 'jisx0208_1990_to_jisx0201_katakana' if $option =~ /h/;
  $$s = Encode::Table::convert ($$s, \@tbl);
  $$s = $__encoder->{sjis}->encode ($$s);
  $n;
}
# Internal-use-function _jis2sjis is not implemented.

sub sjis2euc ($;$$) {
  my ($s, $option, $n) = @_;
  my @tbl;
  push @tbl, 'jisx0201_latin_to_ascii__cpunify' if $UNIFY_LATIN_IRV;
  push @tbl, 'jisx0201_katakana_to_jisx0208_1990' if !$WIDTH_COMPATIBLE || $option =~ /z/;
  push @tbl, 'jisx0208_1990_to_jisx0201_katakana' if $option =~ /h/;
  $$s = $__encoder->{sjis}->decode ($$s);
  $$s = Encode::Table::convert ($$s, [qw/jisx0208_1990_to_ascii/]) unless $WIDTH_COMPATIBLE;
  $$s = Encode::Table::convert ($$s, \@tbl);
  $$s = $__encoder->{euc}->encode ($$s);
  $n;
}
# Internal-use-function s2e is not implemented.

sub euc2sjis (\$;$$) {
  my ($s, $option, $n) = @_;
  my @tbl;
  push @tbl, 'ascii_to_jisx0201_latin__cpunify' if $UNIFY_LATIN_IRV;
  push @tbl, 'jisx0201_katakana_to_jisx0208_1990' if !$WIDTH_COMPATIBLE || $option =~ /z/;
  push @tbl, 'jisx0208_1990_to_jisx0201_katakana' if $option =~ /h/;
  $$s = $__encoder->{euc}->decode ($$s);
  $$s = Encode::Table::convert ($$s, [qw/jisx0208_1990_to_ascii/]) unless $WIDTH_COMPATIBLE;
  $$s = Encode::Table::convert ($$s, \@tbl);
  $$s = $__encoder->{sjis}->encode ($$s);
  $n;
}
# Internal-use-function e2s is not implemented.

sub jis2jis ($;$) {
  my ($s, $option) = @_;
  # $$s =~ s/\x1B\x24[\x40\x42]/\x1B\x24\x42/g;
  # $$s =~ s/\x1B\x28[BJ]/\x1B\x28\x42/g;
  &h2z_jis ($s) if $option =~ /z/;
  &z2h_jis ($s) if $option =~ /h/;
}

sub sjis2sjis ($;$) {
  my ($s, $option) = @_;
  &h2z_sjis ($s) if $option =~ /z/;
  &z2h_sjis ($s) if $option =~ /h/;
}

sub euc2euc ($;$) {
  my ($s, $option) = @_;
  &h2z_euc ($s) if $option =~ /z/;
  &z2h_euc ($s) if $option =~ /h/;
}

=item jcode::cache ()

=item jcode::nocache ()

=item jcode::flushcache ()

These method does not work with this wrapper library.

=cut

sub cache () { 0 }
sub nocache () { 0 }
sub flushcache () { 0 }

sub h2z_jis (\$) {
  my $s = shift;
  $$s = $__encoder->{jis}->decode ($$s);
  $$s = Encode::Table::convert ($$s, [qw/jisx0201_katakana_to_jisx0208_1990/]);
  $$s = $__encoder->{jis}->encode ($$s);
}
# Internal-use-function _h2z_jis is not implemented.

sub h2z_euc (\$) {
  my $s = shift;
  $$s = $__encoder->{euc}->decode ($$s);
  $$s = Encode::Table::convert ($$s, [qw/jisx0201_katakana_to_jisx0208_1990/]);
  $$s = $__encoder->{euc}->encode ($$s);
}

sub h2z_sjis (\$) {
  my $s = shift;
  $$s = $__encoder->{sjis}->decode ($$s);
  $$s = Encode::Table::convert ($$s, [qw/jisx0201_katakana_to_jisx0208_1990/]);
  $$s = $__encoder->{sjis}->encode ($$s);
}

sub z2h_jis (\$) {
  my $s = shift;
  # not implemented.
}
# Internal-use-functions _z2h_jis, __z2h_jis are not implemented.

sub z2h_euc ($) {
  my $s = shift;
  $$s = $__encoder->{euc}->decode ($$s);
  $$s = Encode::Table::convert ($$s, [qw/jisx0208_1990_to_jisx0201_katakana/]);
  $$s = $__encoder->{euc}->encode ($$s);
}

sub z2h_sjis ($) {
  my $s = shift;
  $$s = $__encoder->{sjis}->decode ($$s);
  $$s = Encode::Table::convert ($$s, [qw/jisx0208_1990_to_jisx0201_katakana/]);
  $$s = $__encoder->{sjis}->encode ($$s);
}

# Internal-use-functions init_z2h_euc, init_z2h_sjis are not implemented.

=item jcode::tr (\$s, $from => $to, $option)

jcode version of tr///.  Instead of '-' (HYPHEN-MINUS SIGN)
of ISO/IEC 646 IRV (ASCII), HYPHEN of JIS X 0208 is able to
be used to specify ranges of code point.

=cut

sub tr (\$$$;$) {
  my ($s, $from => $to, $opt) = @_;
  my $input = $$s =~ /\x1B/ ? 'jis' : 'euc';
  $$s = $__encoder->{$input}->decode ($$s);
  $from = $__encoder->{$input}->decode ($from);
  $to = $__encoder->{$input}->decode ($to);
  $from =~ s/\x5C([\x5C$__re_hyphen])|[$__re_hyphen]/$1||'-'/ge;
  $to =~ s/\x5C([\x5C$__re_hyphen])|[$__re_hyphen]/$1||'-'/ge;
  $from =~ s/([{}\\])/\\$1/g;
  $to =~ s/([{}\\])/\\$1/g;
  eval qq{\$\$s =~ tr{$from}{$to}$opt} or warn $@;
  print &Encode::encode ('shift-jis', qq{\$\$s =~ tr{$from}{$to}$opt\n} );
  $$s = $__encoder->{$input}->encode ($$s);
}
# Internal-use-functions _maketable, _expnd1, _expnd2 are not implemented.

=head1 USAGE

You just place this library instead of original jcode.pl.
Usually it is enough.

=head1 SEE ALSO

L<Encode>, L<Encode::ISO2022>, L<Encode::SJIS>,
L<Encode::Table>

=head1 BUGS

Details of convertion process is different from original jcode.pl's
because of difference between it and Encode.

Some less frequently used functions of jcode.pl is not implemented
in this wrapper library.

=head1 AUTHORS

Nanashi-san

=head1 LICENSE

This library is a Public Domain software.

=cut

1;
