#!/usr/bin/perl
use strict;

my @l;
my %i;
while (<>) {
if (/^0x([0-9A-F]+)\tU\+([0-9A-F]+)\t([^\t]*)\t# ?(.*)/) {
  push @l, {local => hex $1, ucs => hex $2, comment => $4};
  my $info = $3;
  if ($info =~ /<->/) { $l[-1]->{fallback} = 0 }
  elsif ($info =~ /<-/) { $l[-1]->{fallback} = 1 }
  elsif ($info =~ /->/) { $l[-1]->{fallback} = 3 }
} elsif (/^## ([a-z0-9:_-]+)\t(.+)/) {
  $i{$1} = $2;
}
}

@l = sort { $a->{ucs} <=> $b->{ucs} || $a->{fallback} <=> $b->{fallback} || $a->{local} <=> $b->{local} } @l;

print <<EOH;
#
<code_set_name>  "@{[ $i{'ucm:code_set_name'} || $i{name} ]}"
@{[&{sub{
  my $s = '';
  for (sort split /\t/, $i{'ucm:code_set_alias'}) {
    $s .= sprintf '<code_set_alias> "%s"%s', $_, "\n";
  }
  $s;
}}]}<mb_cur_min> @{[ $i{'ucm:mb_cur_min'} || 1 ]}
<mb_cur_max> @{[ $i{'ucm:mb_cur_max'} || 1 ]}
<subchar> @{[&{sub{
  my $s = uc $i{'ucm:subchar'}|| $i{'<-ucs-substition'} || $i{substition} || '0x3F';
  $s =~ s/^[0\\]X/\\x/;
  $s =~ s/^\\x([0-9A-F][0-9A-F])([0-9A-F][0-9A-F])/\\x$1\\x$2/;
  $s;
}}]}
#
CHARMAP
EOH

for (@l) {
  printf q{<U%04X> \x%02X |%d # %s}, $_->{ucs}, $_->{local}, $_->{fallback}, $_->{comment}."\n";
}

print "END CHARMAP\n";
