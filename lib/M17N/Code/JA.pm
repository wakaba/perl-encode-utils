
package M17N::Code::JA;
use strict;
use vars qw(%re %internalo);

%re = (
  94x1	=> qr/\x1B\x28([\x40-\x7D])((?:[\x21-\x7E])*)/,
  94x2	=> qr/(?:\x1B\x26([\x40-\x7E]))?\x1B\x24\x28?([\x40-\x5F])((?:[\x21-\x7E][\x21-\x7E])*)/,
  96x1	=> qr/\x1B\x2C([\x40-\x7D])((?:[\x20-\x7F])*)/,
  utf8	=> qr/\x1B\x25(?:\x47|\x2F[\x47-\x49])((?:[\x20-\x7F]|(?:[\xC0-\xFD][\x80-\xBF]+))*)\x1B\x25\x40/,
);
%internalo = (
  94x1	=> 0xE90940,
  94x2	=> 0xE9F6C0,
  96x1	=> 0xE926A0,
  jisx02081990	=> 0xE9F6C0 + 94*94*79,
);
%internalo = (%internalo,
  jisx0201kana	=> $internalo{94x1} + 94 * (0x49-0x30),
  jisx0201kana_end	=> $internalo{94x1} + 94 * (0x49-0x30+1) -1,
  jisx0201latin	=> $internalo{94x1} + 94 * (0x4A-0x30),
  jisx0201latin_end	=> $internalo{94x1} + 94 * (0x4A-0x30+1) -1,
  jisx02081978	=> $internalo{94x2} + 94*94 * (0x40-0x30),
  jisx02081978_end	=> $internalo{94x2} + 94*94 * (0x40-0x30+1) -1,
  jisx02081983	=> $internalo{94x2} + 94*94 * (0x42-0x30),
  jisx02081983_end	=> $internalo{94x2} + 94*94 * (0x42-0x30+1) -1,
  jisx02081990_end	=> $internalo{jisx02081990} + 94*94 -1,
  jisx02121990	=> $internalo{94x2} + 94*94 * (0x44-0x30),
  jisx02121990_end	=> $internalo{94x2} + 94*94 * (0x44-0x30+1) -1,
  jisx02132000_1	=> $internalo{94x2} + 94*94 * (0x4F-0x30),
  jisx02132000_1_end	=> $internalo{94x2} + 94*94 * (0x4F-0x30+1) -1,
  jisx02132000_2	=> $internalo{94x2} + 94*94 * (0x50-0x30),
  jisx02132000_2_end	=> $internalo{94x2} + 94*94 * (0x50-0x30+1) -1,
);

my %_charset_name_n11n_table = (
  euc	=> "euc-jp",
  "euc-japan"	=> "euc-jp",
  "euc-jisx0208"	=> "euc-jp",
  "euc-jisx0213"	=> "euc-jp:2000",
  jis	=> "junet",
  "shift-jis"	=> "shift_jis",
  "shift-jisx0213"	=> "shift_jis:2000",
  shift_jisx0213	=> "shift_jis:2000",
  sjis	=> "shift_jis",
  "x-euc-jisx0213"	=> "euc-jp:2000",
  "x-euc-jp"	=> "euc-jp",
  "x-shift_jisx0213"	=> "shift_jis:2000",
  "x-sjis"	=> "shift_jis",
);
sub _charset_name_n11n ($;$) {
  my $name = lc shift;  my $year = shift;
  $name = $_charset_name_n11n_table{$name} || $name;
  if ($name =~ /^(.+):(\d+)$/) {
    $name = $1;
    $year ||= $2;
  }
  ($name, $year);
}

=head2 convert ($string, $output_code, $input_code, $options)

Convert coded charset of string.

=cut

sub convert ($;$$$) {
  my ($string, $output_code, $input_code, $options) = @_;
  $string = \$string unless ref $string;
  my ($input_edition, $output_edition);
  ($input_code, $input_edition) = _charset_name_n11n ($input_code);
  ($output_code, $output_edition) = _charset_name_n11n ($output_code || "junet");
  if ($input_code eq "euc-jp") {
    eucjapan_to_internal ($string, edition => $input_edition);
  } elsif ($input_code eq "junet" || $input_code =~ /^iso-2022-jp/) {
    junet_to_internal ($string);
  }
  
  if ($output_code eq "euc-jp") {
    internal_to_eucjapan ($string, edition => $output_edition);
  } elsif ($output_code eq "junet" || $output_code =~ /^iso-2022-jp/) {
    internal_to_junet ($string);
  }
}

=head2 junet_to_internal ($string)

Convert junet coded string to internal coded string.

=cut

sub junet_to_internal ($) {
  my $s = shift;
  $s = \$s unless ref $s;
  $$s =~ s{
    ($re{94x1} | $re{94x2} | $re{96x1} | $re{utf8})
  }{
    my $st = $1;
    if ($st =~ /$re{94x1}/) {
      my ($f, $str) = ($1, $2);
      $f = unpack 'C', $f;
      $f = $f == 0x42 ? 0x21 : $internalo{94x1} + 94 * ($f - 0x30);
      $str =~ s{([\x21-\x7E])}{
        _u8($f + unpack('C', $1) - 0x21);
      }goesx;
      $st = $str;
    } elsif ($st =~ /$re{94x2}/) {
      my ($rev, $f, $str) = ($1, $2, $3);
      if ($rev eq '@' && $f eq 'B') {
        $f = $internalo{jisx02081990};
      } else {
        $f = unpack 'C', $f;
        $f = $internalo{94x2} + 94*94 * ($f - 0x30);
      }
      $str =~ s{([\x21-\x7E])([\x21-\x7E])}{
        _u8($f + (unpack('C', $1) - 0x21)*94 + unpack('C', $2) - 0x21);
      }goesx;
      $st = $str;
    } elsif ($st =~ /$re{96x1}/) {
      my ($f, $str) = ($1, $2);
      $f = unpack 'C', $f;
      $f = $f == 0x41 ? 0xA0 : $internalo{96x1} + 96 * ($f - 0x30);
      $str =~ s{([\x20-\x7F])}{
        _u8($f + unpack('C', $1) - 0x20);
      }goesx;
      $st = $str;
    } elsif ($st =~ /$re{utf8}/) {
      $st = $1;
    }
    $st;
  }goesx;
  $$s;
}

sub _u8 ($) {
  my ($ret, $uc);
  $uc = shift;
    if ($uc < 0x80) {	## 1 byte
      $ret .= chr($uc);
    } elsif ($uc < 0x800) {	## 2 byte
      $ret .= chr(0xC0 | ($uc >> 6))
           .  chr(0x80 | ($uc & 0x3F));
    } elsif ($uc < 0x10000) {	## 3 byte
      $ret .= chr(0xE0 |  ($uc >> 12)        )
           .  chr(0x80 | (($uc >>  6) & 0x3F))
           .  chr(0x80 |  ($uc & 0x3F)       );
    } elsif ($uc < 0x200000) {	## 4 byte
      $ret .= chr( 240 |  ($uc >> 18)        )
           .  chr(0x80 | (($uc >> 12) & 0x3F))
           .  chr(0x80 | (($uc >>  6) & 0x3F))
           .  chr(0x80 |  ($uc & 0x3F)       );
    } elsif ($uc < 0x4000000) {	## 5 byte
      $ret .= chr( 248 |  ($uc >> 24)        )
           .  chr(0x80 | (($uc >> 18) & 0x3F))
           .  chr(0x80 | (($uc >> 12) & 0x3F))
           .  chr(0x80 | (($uc >>  6) & 0x3F))
           .  chr(0x80 |  ($uc & 0x3F)       );
    } elsif ($uc < 0x80000000) {	## 6 byte
      $ret .= chr( 252 |  ($uc >> 30)        )
           .  chr(0x80 | (($uc >> 24) & 0x3F))
           .  chr(0x80 | (($uc >> 18) & 0x3F))
           .  chr(0x80 | (($uc >> 12) & 0x3F))
           .  chr(0x80 | (($uc >>  6) & 0x3F))
           .  chr(0x80 |  ($uc & 0x3F)       );
    }
  $ret;
}

sub _ucode ($) {
  my $s = shift;
  return unpack("C", $s) if length($s) < 2;
  my ($iterations, $c, @c)
    = (0, unpack("C", substr($s, 0, 1)), unpack('C*', substr($s, 1)));
  if (($c & 0xFE) == 0xFC) {
      $c = ($c & 0x01);
      $iterations = 5;
  } elsif (($c & 0xFC) == 0xF8) {
      $c = ($c & 0x03);
      $iterations = 4;
  } elsif (($c & 0xF8) == 0xF0) {
      $c = ($c & 0x07);
      $iterations = 3;
  } elsif (($c & 0xF0) == 0xE0) {
      $c = ($c & 0x0F);
      $iterations = 2;
  } elsif (($c & 0xE0) == 0xC0) {
      $c = ($c & 0x1F);
      $iterations = 1;
  }
  if ($iterations == $#c+1) {
      for (my $i = 0; $i < $iterations; $i++) {
        $c = ($c << 6);
        $c = ($c | ($c[$i] & 0x3F));
      }
  }
  $c;
}

=head2 internal_to_eucjapan ($string, [%options])

Convert internal coded string to euc-japan coded string.

=head3 Example

internal_to_eucjapan (\$s, jisx0201kana => 1);

=cut

sub internal_to_eucjapan ($;%) {
  my $s = shift;
  $s = \$s unless ref $s;
  my %output = @_;
  my $year = $output{edition} || -1;	## -1 (= all unify), 1983, 1990 = 1997, 2000
  $output{jisx02081978} = 1 if $year < 1983;
  $output{jisx02081983} = 1 if $year == -1 || (1983 <= $year && $year < 1990);
  $output{jisx02081990} = 1 if $year == -1 || (1990 <= $year && $year < 2000);
  $output{jisx02121990} = 1 if $year == -1 || (1990 <= $year && $year < 2000);
  $output{jisx02132000_1} = 1 if $year == -1 || (2000 <= $year);
  $output{jisx02132000_2} = 1 if $year == -1 || (2000 <= $year);
  $output{undefchar} ||= "\xA2\xAE";
  $$s =~ s{([\xC0-\xFF][\x80-\xBF]*)}{
    my $char = $1;  my $code = _ucode($char);  my $ret = "";
    if ($code < 0x7F) {	## G0 = ASCII
      $ret = pack("C", $code);
    } elsif ($output{jisx0201latin} && $internalo{jisx0201latin} < $code 
      && $code < $internalo{jisx0201latin_end}) {	## G0 = JIS X 0201 latin
      $ret = pack("C", $code - $internalo{jisx0201latin} + 0x21);
    } elsif ($output{jisx02081978} 
      && ($internalo{jisx02081978} < $code && $code < $internalo{jisx02081978_end})
      ) {	## G1 = JIS X 0208-1978
      my $ku = $code - $internalo{jisx02081978};
      my $ten = ($ku % 94) + 0xA1; $ku = int($ku / 94) + 0xA1;
      $ret = pack("CC", $ku, $ten);
    } elsif ($output{jisx02081983} 
      && ($internalo{jisx02081983} < $code && $code < $internalo{jisx02081983_end})
      ) {	## G1 = JIS X 0208-1983
      my $ku = $code - $internalo{jisx02081983};
      my $ten = ($ku % 94) + 0xA1; $ku = int($ku / 94) + 0xA1;
      $ret = pack("CC", $ku, $ten);
    } elsif ($output{jisx02081990} 
      && ($internalo{jisx02081990} < $code && $code < $internalo{jisx02081990_end})
      ) {	## G1 = JIS X 0208-1990 / JIS X 0208:1997
      my $ku = $code - $internalo{jisx02081990};
      my $ten = ($ku % 94) + 0xA1; $ku = int($ku / 94) + 0xA1;
      $ret = pack("CC", $ku, $ten);
    } elsif ($output{jisx02132000_1} 
    && ($internalo{jisx02132000_1} < $code && $code < $internalo{jisx02132000_1_end})
      ) {	## G1 = JIS X 0213:2000 plane 1
      my $ku = $code - $internalo{jisx02132000_1};
      my $ten = ($ku % 94) + 0xA1; $ku = int($ku / 94) + 0xA1;
      $ret = pack("CC", $ku, $ten);
    } elsif ($output{jisx0201kana} && $internalo{jisx0201kana} < $code 
      && $code < $internalo{jisx0201kana_end}) {	## G2 = JIS X 0201 katakana
      $ret = "\x8E" . pack("C", $code - $internalo{jisx0201kana} + 0xA1);
    } elsif ($output{jisx02121990} 
    && ($internalo{jisx02121990} < $code && $code < $internalo{jisx02121990_end})
      ) {	## G3 = JIS X 0213:2000 plane 2
      my $ku = $code - $internalo{jisx02121990};
      my $ten = ($ku % 94) + 0xA1; $ku = int($ku / 94) + 0xA1;
      $ret = "\x8F" . pack("CC", $ku, $ten);
    } elsif ($output{jisx02132000_2} 
    && ($internalo{jisx02132000_2} < $code && $code < $internalo{jisx02132000_2_end})
      ) {	## G3 = JIS X 0213:2000 plane 2
      my $ku = $code - $internalo{jisx02132000_2};
      my $ten = ($ku % 94) + 0xA1; $ku = int($ku / 94) + 0xA1;
      $ret = "\x8F" . pack("CC", $ku, $ten);
    } else {
      $ret = $output{undefchar};
    }
    $ret;
  }goex;
  $$s;
}

=head2 internal_to_junet ($sering, [%option])

Convert internal coded string to junet coded string.

=head3 options

* g0_96
* utf8

=cut

sub internal_to_junet ($;%) {
  my $s = shift;
  $s = \$s unless ref $s;
  my %output = @_;  my $mode = "\x1B\x28\x42";
  $output{undefchar} ||= 0x3F-0x21;
  $output{undefcharset} ||= "\x1B\x28\x42";
  $$s =~ s{([\x00-\x7F]|(?:[\xC0-\xFF][\x80-\xBF]*))}{
    my $char = $1;  my $code = _ucode($char);  my $ret = "";
    if ($code < 0x9F) {	## ASCII
      $ret = _2022_putchar(\$mode => "\x1B\x28\x42", $code-0x21);
    } elsif ($code < 0xFF) {	## ISO 8859-1 right half
      $ret = _2022_putchar(\$mode => "\x1B\x2C\x41", $code-0xA0);
    } elsif ($internalo{94x1} < $code && $code < $internalo{94x1} + 94*78 -1) {
      	## 94 charsets
      my $final = pack("C", int(($code - $internalo{94x1}) / 94) + 0x30);
      $ret = _2022_putchar(\$mode => "\x1B\x28".$final,
                           ($code - $internalo{94x1}) % 94);
    } elsif ($output{g0_96}
      && $internalo{96x1} < $code && $code < $internalo{96x1} + 96*78 -1) {
      	## 96 charsets
      my $final = pack("C", int(($code - $internalo{96x1}) / 96) + 0x30);
      $ret = _2022_putchar(\$mode => "\x1B\x2C".$final,
                           ($code - $internalo{96x1}) % 96);
    } elsif ($internalo{94x2} < $code && $code < $internalo{94x2} + 94*94*78 -1) {
      	## 94x2 charsets
      my $final = pack("C", int(($code - $internalo{94x2}) / (94*94)) + 0x30);
      $ret = _2022_putchar(\$mode => "\x1B\x24\x28".$final,
                           ($code - $internalo{94x2}) % (94*94));
    } elsif ($internalo{jisx02081990} < $code
          && $code < $internalo{jisx02081990} + 94*94 -1) {
      $ret = _2022_putchar(\$mode => "\x1B\x26\x40\x1B\x24B",
                           ($code - $internalo{94x2}) % (94*94));
    } elsif ($output{utf8}) {
      $ret = _2022_putchar(\$mode => "\x1B\x25G", $char)
    } else {
      $ret = _2022_putchar(\$mode => $output{undefcharset} => $output{undefchar});
    }
    $ret;
  }goesx;
  $$s;
}
sub _2022_putchar ($$$) {
  my ($mode, $newmode, $char) = @_;
  my $ret = "";  my %is;
  $is{multibyte} = 1 if $newmode =~ /\x24/;
  $is{set96} = 1 if $newmode =~ /\x2C/;
  if ($$mode ne $newmode) {
    if ($$mode eq "\x1B\x25G") {
      $ret = "\x1B\x25\x40\x1B\x28\x42";
    }
    if ($is{multibyte} || $is{set96} || $newmode eq "\x1B\x25G") {
      $ret .= "\x1B\x28\x42";
    }
    if ($newmode =~ /\x1B\x24\x28([\x40-\x42])/) {
      $ret .= "\x1B\x24$1";
    } else {
      $ret .= $newmode;
    }
    $$mode = $newmode;
  }
  if ($is{multibyte} && $is{set96}) {	## 96x2
    $ret .= pack("CC", int($char / 96) + 0x20, ($char % 96) + 0x20);
  } elsif ($is{multibyte}) {	## 94x2
    $ret .= pack("CC", int($char / 94) + 0x21, ($char % 94) + 0x21);
  } elsif ($is{set96}) {	## 96x1
    $ret .= pack("C", $char + 0x20);
  } elsif ($newmode eq "\x1B\x25G") {	## utf-8
    $ret .= $char;	## if utf-8, $char is char itself!
  } else {	## 94x1
    $ret .= pack("C", $char + 0x21);
  }
  $ret;
}

sub eucjapan_to_internal ($;%) {
  my $s = shift;
  $s = \$s unless ref $s;
  my %option = @_;
  my $year = $option{edition} || 2000;	## 1978, 1983, 1990=1997, 2000
  $option{G0start} ||= 0x21;  $option{G2start} ||= $internalo{jisx0201kana};
  if ($option{G1start} && $option{G3start}) {}
  elsif ($year < 1983)
    {$option{G1start} ||= $internalo{jisx02081978}; $option{G3start} ||= -1}
  elsif (1983 <= $year && $year < 1990)
    {$option{G1start} ||= $internalo{jisx02081983}; $option{G3start} ||= -1}
  elsif (1990 <= $year && $year < 2000)
    {$option{G1start} ||= $internalo{jisx02081990}; $option{G3start} ||= -1}
  else #elsif (2000 <= $year)
    {$option{G1start} ||= $internalo{jisx02132000_1}; $option{G3start} ||= -1}
  $$s =~ s{([\x21-\x7E]|\x8E[\xA1-\xFE]|\x8F?[\xA1-\xFE][\xA1-\xFE])}{
    my $char = $1;  my $ret = "";
    if ($char =~ /[\x21-\x7E]/) {
      $ret = _u8(unpack("C", $char) - 0x21 + $option{G0start});
    } elsif ($char =~ /\x8F/) {
      my $ku = unpack("C", substr($char,1,1)) - 0xA1;
      my $ten = unpack("C", substr($char,2,1)) - 0xA1;
      if ($option{G3start} == -1) {
        if (77 <= $ku || $ku == 0 || $ku == 2 || $ku == 3 || $ku == 4
          || $ku == 7 || $ku == 11 || $ku == 12 || $ku == 13 || $ku == 14) {
          $ret = _u8($ku * 94 + $ten + $internalo{jisx02132000_2});
        } else {
          $ret = _u8($ku * 94 + $ten + $internalo{jisx02121990});
        }
      } else {
        $ret = _u8($ku * 94 + $ten + $option{G3start});
      }
    } elsif ($char =~ /\x8E/) {
      $ret = _u8(unpack("C", substr($char,1,1)) - 0xA1 + $option{G2start});
    } else {
      my $ku = unpack("C", substr($char,0,1)) - 0xA1;
      my $ten = unpack("C", substr($char,1,1)) - 0xA1;
      $ret = _u8($ku * 94 + $ten + $option{G1start});
    }
    $ret;
  }goex;
}

=head1 NAME

M17N::Code::JA --- Japanese string coding system convertion

=head1 LICENSE

  This program is free software; you can redistribute it and/or 
  modify it under the same terms as Perl itself.

=head1 AUTHOR

wakaba <wakaba@suika.fam.cx>

=cut

1;
