
=head1 NAME

Encode::Table --- Inter-coding-space table convertion

=cut

package Encode::Table;
use strict;
use vars qw(%TABLE $VERSION);
$VERSION = do {my @r =(q$Revision: 1.4 $ =~ /\d+/g);sprintf "%d."."%02d" x $#r, @r};

## Builtin tables
for (0x00..0x7F) {
  my $c = chr $_;
  $TABLE{ascii_to_ucs}->{$c} = $c;
  $TABLE{ucs_to_ascii}->{$c} = $c;
}
$Encode::Table::ascii::VERSION = $VERSION;
for (0xA0..0xFF) {
  my $c = chr $_;
  $TABLE{isoiec8859_1_to_ucs}->{$c} = $c;
  $TABLE{ucs_to_isoiec8859_1}->{$c} = $c;
}
$Encode::Table::isoiec8859_1::VERSION = $VERSION;

my %_Cache;
sub convert ($@%) {
  return $_[0] unless @{$_[1]} > 0;
  my @s = split //, shift;
  my $tbl = shift;
  my $tbls = join ' ', @$tbl;
  my %option = @_;
  load_table (@$tbl) if $option{-autoload};
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

sub load_table (@) {
  no strict 'refs';
  for (@_) {
    my $name = $_;
    if ($name =~ /^ucs_to_(.+)$/) { $name = $1 }
    elsif ($name =~ /^(.+)_to_ucs$/) { $name = $1 }
    unless (${ 'Encode::Table::' . $name . '::VERSION' }) {
      eval qq{require Encode::Table::$name; Encode::Table::$name->import; 1} or warn $@;
    }
  }
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

# $Date: 2002/10/12 07:27:01 $
### $RCSfile: Table.pm,v $ ends here
