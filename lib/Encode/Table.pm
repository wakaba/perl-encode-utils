
=head1 NAME

Encode::Table --- Inter-coding-space table convertion

=cut

package Encode::Table;
use strict;
use vars qw(%TABLE $VERSION);
$VERSION = do {my @r =(q$Revision: 1.1 $ =~ /\d+/g);sprintf "%d."."%02d" x $#r, @r};

## Builtin tables
for (0x00..0x7F) {
  my $c = chr $_;
  $TABLE{ascii_to_ucs}->{$c} = $c;
  $TABLE{ucs_to_ascii}->{$c} = $c;
}

my %_Cache;
sub convert ($@) {
  my @s = split //, shift;
  my $tbl = shift;
  my $tbls = join ' ', @$tbl;
  for my $c (@s) {
    unless (defined $_Cache{$tbls}->{$c}) {
      for (@$tbl) {
        if (defined $TABLE{$_}->{$c}) {
          $_Cache{$tbls}->{$c} = $TABLE{$_}->{$c}; last;
        }
      }
      $_Cache{$tbls}->{$c} = $c unless defined $_Cache{$tbls}->{$c};	## Not found
    }
    $c = $_Cache{$tbls}->{$c};
  }
  join '', @s;
}

1;
__END__

=head1 AUTHORS

Nanashi-san

=head1 LICENSE

Copyright 2002 AUTHORS

This library is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

=cut

# $Date: 2002/10/04 23:58:04 $
### $Source: /tmp/A3a0A4y5zN/cvs/oldencodeutils/lib/Encode/Table.pm,v $ ends here
