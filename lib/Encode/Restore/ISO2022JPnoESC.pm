
=head1 NAME

Encode::Restore::ISO2022JPnoESC --- Decoder of broken ISO-2022-JP
data that has been removed ESCs.

=head1 DESCRIPTION

In some ISO/IEC 2022 based encodings such as ISO-2022-JP,
control character ESC (01/11 = \x1B) has important role.
But very very old softwares (mainly server software of
transparents) does not recogenize this character so data
come through such implemention are broken.

This module provides some coding system that try to restore
such broken ISO-2022-JP data.

=head1 ENCODINGS

=over 4

=cut

package Encode::Restore::ISO2022JPnoESC;
use strict;
our $VERSION = do{my @r=(q$Revision: 1.1 $=~/\d+/g);sprintf "%d."."%02d" x $#r,@r};
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw!iso-2022-jp-no-esc!);

=item iso-2022-jp-no-esc

Broken ISO-2022-JP data that has been removed ESCs.

=cut

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  warn "encode: encode of iso-2022-jp-no-esc is not supported!";
  $_[1] = '' if $chk;
  return Encode::encode ('iso-2022-jp', $str);
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str =~ s/(\x24[\x40\x42](?:[\x21-\x7E][\x21-\x7E])+)(\x28[BHJ])/\x1B$1\x1B$2/g;
  return Encode::decode ('iso-2022-jp', $str);
}

package Encode::Restore::ISO2022JPnoESC::ISO2022JPescsp;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw!iso-2022-jp-esc-sp!);

=item iso-2022-jp-esc-sp

Broken ISO-2022-JP data that has been inserted SPs
instead of ESCs.

Note that old Japanese articles of Google Groups
<http://groups.google.com/> are encoded in this scheme.

=cut

sub encode ($$;$) {
  my ($obj, $str, $chk) = @_;
  warn "encode: encode of iso-2022-jp-esc-sp is not supported!";
  $_[1] = '' if $chk;
  return Encode::encode ('iso-2022-jp', $str);
}

sub decode ($$;$) {
  my ($obj, $str, $chk) = @_;
  $_[1] = '' if $chk;
  $str =~ s/\x20(\x24[\x40\x42](?:[\x21-\x7E][\x21-\x7E])+)\x20(\x28[BHJ])/\x1B$1\x1B$2/g;
  return Encode::decode ('iso-2022-jp', $str);
}

1;
__END__

=back

=head1 LICENSE

Copyright 2002 Nanashi-san <nanashi@san.invalid>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/12/12 08:17:16 $
