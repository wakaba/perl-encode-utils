## This file is auto-generated (at 2010-05-03T06:14:51Z).
## Do not edit by hand!

=head1 NAME

Encode::ISO2022::EUCKR --- An Encode module of EUC (8-bit ISO/IEC 2022
based coding system) for Korean


=cut

package Encode::ISO2022::EUCKR;
use 5.7.3;
use strict;
our $VERSION = q(2010.0503);

=head1 ENCODINGS

=over 8

=cut


package Encode::ISO2022::EUCKR::euc_korea;
our $VERSION = $Encode::ISO2022::EUCKR::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/euc-korea euc-kr euckr cp970 cp51949 ibm-euckr x-euc-kr cseuckr korean-iso-8bit/);

=item euc-korea

EUC (ISO/IEC 2022 based 8-bit encoding) for Korean.
(Alias: euc-kr, euckr, cp970, cp51949, ibm-euckr, x-euc-kr, cseuckr, korean-iso-8bit)

=cut

sub encode ($$;$) {
  my ($obj, $s, $chk) = @_;
  my %s;
  require Encode::ISO2022;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  $C->{option}->{fallback_from_ucs} = $obj->{_encode_fallback} ? $obj->{_encode_fallback} :
    $chk & Encode::DIE_ON_ERR ? 'croak' :
    $chk & Encode::RETURN_ON_ERR ? ($chk & Encode::WARN_ON_ERR ? 'quiet+warn' : 'quiet') :
    $chk & Encode::PERLQQ ? 'perl' :        $chk & Encode::HTMLCREF ? 'sgml' :
    $chk & Encode::XMLCREF ? 'sgml-hex' : 'replacement';
  require Encode::Table;
  my $tbl = defined $obj->{_encode_mapping} ? $obj->{_encode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_encode_mapping_autoload} ? $obj->{_encode_mapping_autoload} : 1);
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ksx1001_1992)], %tblopt) if $tbl;
  ($s, %s) = Encode::ISO2022::internal_to_iso2022 ($s, $C);
  if ($s{die}) {	## FB_CROAK
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  } elsif ($s{halfway}) {	## FB_QUIET, FB_WARNING
    $_[1] = substr ($_[1], $s{converted_length});
    if ($s{warn}) {
      if ($Carp::VERSION) { Carp::carp ('encode: '.$s{reason}) }
      else { warn ('encode: '.$s{reason}) }
    }
  } else {
    $_[1] = '' if $chk;
  }
  return $s;
}

sub _encode_internal ($$$) {
  my ($obj, $s, $C) = @_;
  my %s;
  require Encode::ISO2022;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_encode_mapping} ? $obj->{_encode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_encode_mapping_autoload} ? $obj->{_encode_mapping_autoload} : 1);
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ksx1001_1992)], %tblopt) if $tbl;
  ($s, %s) = Encode::ISO2022::internal_to_iso2022 ($s, $C);
  if ($s{die}) {
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  }
  return $s;
}

sub decode ($$;$) {
  my ($obj, $s, $chk) = @_;
  require Encode::ISO2022;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_decode_mapping} ? $obj->{_decode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_decode_mapping_autoload} ? $obj->{_decode_mapping_autoload} : 1);
  
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(ksx1001_1992_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ASCII
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'C'};	## KS C 5601 (KS X 1001)-1987
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{Ginvoke_by_single_shift} = [0,0,1,1];
  $C->{option}->{C1invoke_to_right} = 1;
  $C->{option}->{reset}->{Gdesignation} = 0;
  $C->{option}->{reset}->{Ginvoke} = 0;
  $C->{option}->{undef_char} = ["\x21\x6B", {type => 'G94n', charset => 'C'}];
  $C;
}

package Encode::ISO2022::EUCKR::euc_kps9566;
our $VERSION = $Encode::ISO2022::EUCKR::VERSION;
use base qw(Encode::Encoding);
__PACKAGE__->Define (qw/euc-kps9566 /);

=item euc-kps9566

EUC (ISO/IEC 2022 based 8-bit encoding) for Korean
with KPS 9566-97.

=cut

sub encode ($$;$) {
  my ($obj, $s, $chk) = @_;
  my %s;
  require Encode::ISO2022;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  $C->{option}->{fallback_from_ucs} = $obj->{_encode_fallback} ? $obj->{_encode_fallback} :
    $chk & Encode::DIE_ON_ERR ? 'croak' :
    $chk & Encode::RETURN_ON_ERR ? ($chk & Encode::WARN_ON_ERR ? 'quiet+warn' : 'quiet') :
    $chk & Encode::PERLQQ ? 'perl' :        $chk & Encode::HTMLCREF ? 'sgml' :
    $chk & Encode::XMLCREF ? 'sgml-hex' : 'replacement';
  require Encode::Table;
  my $tbl = defined $obj->{_encode_mapping} ? $obj->{_encode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_encode_mapping_autoload} ? $obj->{_encode_mapping_autoload} : 1);
  
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_kps9566_1997)], %tblopt) if $tbl;
  ($s, %s) = Encode::ISO2022::internal_to_iso2022 ($s, $C);
  if ($s{die}) {	## FB_CROAK
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  } elsif ($s{halfway}) {	## FB_QUIET, FB_WARNING
    $_[1] = substr ($_[1], $s{converted_length});
    if ($s{warn}) {
      if ($Carp::VERSION) { Carp::carp ('encode: '.$s{reason}) }
      else { warn ('encode: '.$s{reason}) }
    }
  } else {
    $_[1] = '' if $chk;
  }
  return $s;
}

sub _encode_internal ($$$) {
  my ($obj, $s, $C) = @_;
  my %s;
  require Encode::ISO2022;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_encode_mapping} ? $obj->{_encode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_encode_mapping_autoload} ? $obj->{_encode_mapping_autoload} : 1);
  $s = Encode::Table::convert ($s, [qw(ucs_to_ascii ucs_to_kps9566_1997)], %tblopt) if $tbl;
  ($s, %s) = Encode::ISO2022::internal_to_iso2022 ($s, $C);
  if ($s{die}) {
    if ($Carp::VERSION) { Carp::croak ('encode: '.$s{reason}) }
    else { die ('encode: '.$s{reason}) }
  }
  return $s;
}

sub decode ($$;$) {
  my ($obj, $s, $chk) = @_;
  require Encode::ISO2022;
  my $C = $obj->__code_version;
  $C->{_encoder} = $obj;
  require Encode::Table;
  my $tbl = defined $obj->{_decode_mapping} ? $obj->{_decode_mapping} : 1;
  my %tblopt = (-autoload => defined $obj->{_decode_mapping_autoload} ? $obj->{_decode_mapping_autoload} : 1);
  
  $s = Encode::ISO2022::iso2022_to_internal ($s, $C);
  $s = Encode::Table::convert ($s, [qw(kps9566_1997_to_ucs)], %tblopt) if $tbl;
  $_[1] = '' if $chk;
  return $s;
}

sub __code_version ($) {
  require Encode::Charset;
  my $C = &Encode::Charset::new_object;
  $C->{bit} = 8;
  $C->{G0} = $Encode::Charset::CHARSET{G94}->{'B'};	## ASCII
  $C->{G1} = $Encode::Charset::CHARSET{G94n}->{'N'};	## KPS 9566-97
  $C->{option}->{designate_to}->{G94}->{default} = -1;
  $C->{option}->{designate_to}->{G96}->{default} = -1;
  $C->{option}->{designate_to}->{G94n}->{default} = -1;
  $C->{option}->{designate_to}->{G96n}->{default} = -1;
  $C->{option}->{designate_to}->{C0}->{default} = -1;
  $C->{option}->{designate_to}->{C1}->{default} = -1;
  $C->{option}->{Ginvoke_to_left} = [1,0,0,0];
  $C->{option}->{Ginvoke_by_single_shift} = [0,0,1,1];
  $C->{option}->{C1invoke_to_right} = 1;
  $C->{option}->{reset}->{Gdesignation} = 0;
  $C->{option}->{reset}->{Ginvoke} = 0;
  $C->{option}->{undef_char} = ["\x3F", {type => 'G94', charset => 'B'}];
  $C;
}

=back

=cut


=head1 SEE ALSO

L<Encode::ISO2022>

=head1 LICENSE

Copyright 2010 Nanashi-san <nanashi@san.invalid>

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

1;
