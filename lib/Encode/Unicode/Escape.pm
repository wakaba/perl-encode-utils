=head1 NAME

Encode::Unicode::Escape --- Encode/decode of Unicode escape (x-u-escaped)
of Java

=head1 ENCODINGS

=over 4

=cut

package Encode::Unicode::Escape;
use strict;
use vars qw($VERSION);
$VERSION=do{my @r=(q$Revision: 1.1 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};

use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/unicode-escape x-u-escaped/);

=item unicode-escape

Unicode escape encoding used with Java, Mozilla, etc.  (Alias: x-u-escaped)

=cut

sub encode ($$;$) {
  use integer;
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str =~ s{([^\x00-\x7F])|\\\\|\\(u+[0-9A-Fa-f]{4})}{
    my ($C,$u) = ($1,$2);
    if ($C) {	## U+0080-U+FFFF.  See L</BUGS>.
      my $c = ord $C;
      if ($c < 0x10000) {
        sprintf '\u%04X', $c;
      } else {
        sprintf '\U%08X', $c;
      }
    } elsif ($u) {	## \u+....
      '\u'.$u;
    } else {
      '\\\\';
    }
  }ge;
  Encode::_utf8_off ($str);
  $str;
}
# chr ((ord ($u) - 0x10000) / 0x400 + 0xD800)
# chr ((ord ($u) - 0x10000) % 0x400 + 0xDC00)

sub decode ($$;$) {
  no warnings;
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str =~ s{\\\\|\\(u+)([0-9A-Fa-f]{4})}{
    my ($u,$h) = ($1, $2);
    if ($u eq 'u') {
      chr (hex $h);
    } elsif ($u) {
      '\\'.substr ($u, 1).$h;
    } else {
      '\\\\';
    }
  }ge;
  #Encode::_utf8_on ($str);
  return $str;
}
# chr (0x10000+(ord($u1)-0xD800)*0x400+(ord($u2)-0xDC00))

=back

=head1 BUGS

I don't know how U+10000 or higher characters should be treated,
so this implemention may be incorect...

=head1 SEE ALSO

"Java Language Specification" -- 3.3 Unicode Escapes.
<http://java.sun.com/docs/books/jls/second_edition/html/lexical.doc.html#100850>,
<http://java.sun.com/docs/books/jls/first_edition/html/3.doc.html#100850>.
Japanese translation is available as TR X 0005:2002.  See
<http://www.y-adagio.com/public/standards/tr_javalang2/lexical.doc.html>,
<http://www.y-adagio.com/public/standards/tr_javalang/3.doc.htm>.

=head1 LICENSE

Copyright 2002 Nanashi-san <nanashi-san@nanashi.invalid>

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

1; # $Date: 2002/12/24 05:33:25 $
