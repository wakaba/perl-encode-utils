require 5.7.3;
package Encode::Unicode::UTF7;
use strict;
use vars qw(%OPTION $VERSION);
$VERSION=do{my @r=(q$Revision: 1.2 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
use base qw(Encode::Encoding);
require MIME::Base64;
__PACKAGE__->Define (qw/utf-7 utf7 unicode-2-0-utf-7 unicode-2-0-utf7 x-unicode-2-0-utf7 cp65000 unicode-1-1-utf-7 csunicode11utf7/);
## BUG: Unicode-1-1-UTF-7 is actually not suitable.  (We need Unicode 1.1 support.)

$OPTION{encode_o_set} = 1;

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  my $encode_reg = qr#[^\x09\x0A\x0D\x20A-Za-z0-9'(),-./:?]#;
  $encode_reg = qr~[^\x09\x0A\x0D\x20A-Za-z0-9'(),-./:?!"#\$%&*;<=>@\[\]^_`{|}]~
    unless $OPTION{encode_o_set};
  $str =~ s{ ((?:$encode_reg)+) }{
    my $s = $1;
    unless ($s eq '+') {
      $s = MIME::Base64::encode_base64 (Encode::encode ('UTF-16BE', $s));
      $s =~ tr/=\x0A\x0D/A/d;
    } else {
      $s = '';
    }
    '+'.$s.'-';
  }goex;
  Encode::_utf8_off ($str);
  $_[1] = '' if $chk;
  return $str;
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $str =~ s{\+([A-Za-z0-9+/]*)([^A-Za-z0-9+/]|$)}{
    my ($b, $d) = ($1, $2);
    if (length $b) {
      $b .= '=' x (4 - (length ($b) % 4));
      $b =~ s/====$//;  $b =~ s/AA$/==/;  $b =~ s/A$/=/;
      $b = Encode::decode ('UTF-16BE', MIME::Base64::decode_base64 ($b));
    } else {
      $b = '+';
    }
    $d = '' if $d eq '-';
    $b.$d;
  }goex;
  Encode::_utf8_on ($str);
  $_[1] = '' if $chk;
  return $str;
}

package Encode::Unicode::UTF7::IMAP;
use vars qw($VERSION);
$VERSION = $Encode::Unicode::UTF7::VERSION;
use base qw(Encode::Encoding);
#require MIME::Base64;
__PACKAGE__->Define (qw/utf7-imap utf-7-imap utf-7-for-imap x-imap4-modified-utf7/);

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $str =~ s{ ([^\x20-\x25\x27-\x7E]+) }{
    my $s = $1;
    unless ($s eq '&') {
      $s = MIME::Base64::encode_base64 (Encode::encode ('UTF-16BE', $s));
      $s =~ tr#/=\x0A\x0D#,A#d;
    } else {
      $s = '';
    }
    '&'.$s.'-';
  }goex;
  Encode::_utf8_off ($str);
  $_[1] = '' if $chk;
  return $str;
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $str =~ s{&([A-Za-z0-9+,]*)-}{
    my $b = $1;
    if (length $b) {
      $b .= '=' x (4 - (length ($b) % 4));
      $b =~ s/====$//;  $b =~ s/AA$/==/;  $b =~ s/A$/=/;
      $b =~ tr#,#/#;
      $b = Encode::decode ('UTF-16BE', MIME::Base64::decode_base64 ($b));
    } else {
      $b = '&';
    }
    $b;
  }goex;
  Encode::_utf8_on ($str);
  $_[1] = '' if $chk;
  return $str;
}

1;
__END__

=head1 NAME

Encode::Unicode::UTF7 --- Encode/decode of UTF-7 and IMAP4 modified UTF-7

=head1 EXAMPLE

  use Encode;
  my $s = "some string in utf-8 (to be converted to utf-\x{4E03})";
  print encode ('utf-7', $s);	# ... utf-+TgMA-
  print encode ('utf7-imap', $s);	# ... utf-&TgMA-
  
  my $b = q(A+ImIDkQ. +ZeVnLIqe-);
  print decode ('utf-7', $b);	# A<!=><Alpha> <ni><hon><go>

=head1 LICENSE

Copyright 2002 wakaba E<lt>w@suika.fam.cxE<gt>.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; see the file COPYING.  If not, write to
the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
Boston, MA 02111-1307, USA.

=cut

## $Date: 2002/09/15 04:15:51 $
### UTF7.pm ends here
