
=head1 NAME

M17N::Code::JA --- Perl module for convertion between
coding systems of string written in Japanese language

=cut

package M17N::Code::JA;
use strict;
use vars qw(%re %_cp);

%re = (
  94x1	=> qr/\x1B\x28[\x40-\x7D](?:[\x21-\x7E])*/,
  94x2	=> qr/(?:\x1B\x26[\x40-\x7E])?\x1B\x24\x28?[\x40-\x5F](?:[\x21-\x7E][\x21-\x7E])*/,
  96x1	=> qr/\x1B\x2C[\x40-\x7D](?:[\x20-\x7F])*/,
  utf8	=> qr/\x1B\x25(?:\x47|\x2F[\x47-\x49])(?:[\x20-\x7F]|(?:[\xC0-\xFD][\x80-\xBF]+))*\x1B\x25\x40/,
  M_94x1	=> qr/\x1B\x28([\x40-\x7D])((?:[\x21-\x7E])*)/,
  M_94x2	=> qr/(?:\x1B\x26([\x40-\x7E]))?\x1B\x24\x28?([\x40-\x5F])((?:[\x21-\x7E][\x21-\x7E])*)/,
  M_96x1	=> qr/\x1B\x2C([\x40-\x7D])((?:[\x20-\x7F])*)/,
  M_utf8	=> qr/\x1B\x25(?:\x47|\x2F[\x47-\x49])((?:[\x20-\x7F]|(?:[\xC0-\xFD][\x80-\xBF]+))*)\x1B\x25\x40/,
);
%_cp = (
  94x1	=> 0xE90940,
  94x2	=> 0xE9F6C0,
  96x1	=> 0xE926A0,
  jisx02081990	=> 0xE9F6C0 + 94*94*79,
  ## (0xFC - 0x3F - 1) * (0xFC - 0xEF) = 2444
  x_cp932	=> 0xE000,	x_cp932_last	=> 0xE000 + 2443,
  x_imode_doti	=> 0xFE000,
  x_jsky	=> 0xFFB00,
);
%_cp = (%_cp,
  jisx0201kana	=> $_cp{94x1} + 94 * (0x49-0x30),
  jisx0201kana_last1	=> $_cp{94x1} + 94 * (0x49-0x30+1) -0x21,
  jisx0201kana_last	=> $_cp{94x1} + 94 * (0x49-0x30+1) -1,
  jisx0201latin	=> $_cp{94x1} + 94 * (0x4A-0x30),
  jisx0201latin_last	=> $_cp{94x1} + 94 * (0x4A-0x30+1) -1,
  jisx02081978	=> $_cp{94x2} + 94*94 * (0x40-0x30),
  jisx02081978_last	=> $_cp{94x2} + 94*94 * (0x40-0x30+1) -1,
  jisx02081983	=> $_cp{94x2} + 94*94 * (0x42-0x30),
  jisx02081983_last	=> $_cp{94x2} + 94*94 * (0x42-0x30+1) -1,
  jisx02081990_last	=> $_cp{jisx02081990} + 94*94 -1,
  jisx02121990	=> $_cp{94x2} + 94*94 * (0x44-0x30),
  jisx02121990_last	=> $_cp{94x2} + 94*94 * (0x44-0x30+1) -1,
  jisx02132000_1	=> $_cp{94x2} + 94*94 * (0x4F-0x30),
  jisx02132000_1_last	=> $_cp{94x2} + 94*94 * (0x4F-0x30+1) -1,
  jisx02132000_2	=> $_cp{94x2} + 94*94 * (0x50-0x30),
  jisx02132000_2_last	=> $_cp{94x2} + 94*94 * (0x50-0x30+1) -1,
  ## (0xF7 - 0xEF - 1) * (0xFC - 0xEF) = 1316
  x_doti	=> $_cp{x_imode_doti},
  x_doti_last	=> $_cp{x_imode_doti} + 1316-1,
  x_imode	=> $_cp{x_imode_doti} + 1316,
  x_imode_last	=> $_cp{x_imode_doti} + 2443,
);
my %SJIS_G3_to_KUe = (	## KU-1
	0xF0	=> 7,	0xF1	=> 3,	0xF2	=> 11,	0xF3	=> 13,
	0xF4	=> 77,	0xF5	=> 79,	0xF6	=> 81,	0xF7	=> 83,
	0xF8	=> 85,	0xF9	=> 87,	0xFA	=> 89,	0xFB	=> 91,
	0xFC	=> 93,
);
my %SJIS_G3_to_KUo = (	## KU-1
	0xF0	=> 0,	0xF1	=> 2,	0xF2	=> 4,	0xF3	=> 12,
	0xF4	=> 14,	0xF5	=> 78,	0xF6	=> 80,	0xF7	=> 82,
	0xF8	=> 84,	0xF9	=> 86,	0xFA	=> 88,	0xFB	=> 90,
	0xFC	=> 92,
);	## KU-1
my %_KU_to_SJIS_G3 = reverse (%SJIS_G3_to_KUe, %SJIS_G3_to_KUo);

my %_charset_name_n11n_table = (
  ascii	=> 'us-ascii',
  euc	=> 'euc-jp',
  'euc-japan'	=> 'euc-jp',
  'euc-jisx0208'	=> 'euc-jp',
  'euc-jisx0213'	=> ['euc-jp', 2000],
  jis	=> 'junet',
  'shift-jis'	=> 'shift_jis',
  'shift-jisx0213'	=> ['shift_jis', 2000],
  shift_jisx0213	=> ['shift_jis', 2000],
  sjis	=> 'shift_jis',
  'sjis-doti'	=> ['shift_jis', 1997, 'doti'],
  'sjis-imode'	=> ['shift_jis', 1997, 'imode'],
  'sjis-jsky'	=> ['shift_jis', 1997, 'jsky'],
  'unicode-2-0-utf-8'	=> 'utf-8',
  utf8	=> 'utf-8',
  'utf-8n'	=> 'utf-8',
  'x-euc-jisx0213'	=> ['euc-jp', 2000],
  'x-euc-jp'	=> 'euc-jp',
  'x-shift_jisx0213'	=> ['shift_jis', 2000],
  'x-sjis'	=> 'shift_jis',
  'x-sjis-doti'	=> ['shift_jis', 1997, 'doti'],
  'x-sjis-imode'	=> ['shift_jis', 1997, 'imode'],
  'x-sjis-jsky'	=> ['shift_jis', 1997, 'jsky'],
);
sub _charset_name_n11n ($;$) {
  my ($name, $year, $ext) = (shift, shift, lc shift);
  $name = $_charset_name_n11n_table{lc $name} || $name;
  if (ref $name eq 'ARRAY') {
    ($name, $year, $ext) = @$name;
  }
  (lc $name, $year, $ext);
}

=head2 convert ($string, $output_code, $input_code, $options)

Convert coded charset of string.

=cut

sub convert ($;$$$) {
  my ($string, $o_code, $i_code, $options) = @_;
  my ($i_edition, $o_edition, $i_ext, $o_ext);
  ($i_code, $i_edition, $i_ext) = _charset_name_n11n ($i_code);
  ($o_code, $o_edition, $o_ext) = _charset_name_n11n ($o_code || "junet");
  if ($i_code eq "euc-jp") {
    eucjapan_to_internal ($string, -edition => $i_edition, -extension => $i_ext);
  } elsif ($i_code eq "junet" || $i_code =~ /^iso-2022-jp/
    || $i_code eq 'us-ascii') {
    junet_to_internal ($string);
  } elsif ($i_code eq "shift_jis") {
    shiftjis_to_internal ($string, -edition => $i_edition, -extension => $i_ext);
  }
  
  if ($o_code eq "euc-jp") {
    internal_to_eucjapan ($string, -edition => $o_edition, -extension => $o_ext);
  } elsif ($o_code eq "junet" || $o_code =~ /^iso-2022-jp/
    || $o_code eq 'us-ascii') {
    internal_to_junet ($string);
  } elsif ($o_code eq "shift_jis") {
    internal_to_shiftjis ($string, -edition => $o_edition, -extension => $o_ext);
  }
}

=head2 junet_to_internal ($string)

Convert junet coded string to internal coded string.

=cut

sub junet_to_internal ($) {
  my $s = shift;
  #$s = \$s unless ref $s;
  $s =~ s{
    ($re{94x1} | $re{94x2} | $re{96x1} | $re{utf8})
  }{
    my $st = $1;
    if ($st =~ /$re{M_94x1}/) {
      my ($f, $str) = ($1, $2);
      $f = unpack 'C', $f;
      $f = $f == 0x42 ? 0x21 : $_cp{94x1} + 94 * ($f - 0x30);
      $str =~ s{([\x21-\x7E])}{
        _u8($f + unpack('C', $1) - 0x21);
      }goesx;
      $st = $str;
    } elsif ($st =~ /$re{M_94x2}/) {
      my ($rev, $f, $str) = ($1, $2, $3);
      if ($rev eq '@' && $f eq 'B') {
        $f = $_cp{jisx02081990};
      } else {
        $f = unpack 'C', $f;
        $f = $_cp{94x2} + 94*94 * ($f - 0x30);
      }
      $str =~ s{([\x21-\x7E])([\x21-\x7E])}{
        _u8($f + (unpack('C', $1) - 0x21)*94 + unpack('C', $2) - 0x21);
      }goesx;
      $st = $str;
    } elsif ($st =~ /$re{M_96x1}/) {
      my ($f, $str) = ($1, $2);
      $f = unpack 'C', $f;
      $f = $f == 0x41 ? 0xA0 : $_cp{96x1} + 96 * ($f - 0x30);
      $str =~ s{([\x20-\x7F])}{
        _u8($f + unpack('C', $1) - 0x20);
      }goesx;
      $st = $str;
    } elsif ($st =~ /$re{M_utf8}/) {
      $st = $1;
    }
    $st;
  }goesx;
  $s;
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
  #$s = \$s unless ref $s;
  my %output = @_;
  my $year = $output{edition} || -1;	## -1 (= all unify), 1983, 1990 = 1997, 2000
  $output{jisx02081978} = 1 if $year < 1983;
  $output{jisx02081983} = 1 if $year == -1 || (1983 <= $year && $year < 1990);
  $output{jisx02081990} = 1 if $year == -1 || (1990 <= $year && $year < 2000);
  $output{jisx02121990} = 1 if $year == -1 || (1990 <= $year && $year < 2000);
  $output{jisx02132000_1} = 1 if $year == -1 || (2000 <= $year);
  $output{jisx02132000_2} = 1 if $year == -1 || (2000 <= $year);
  $output{undefchar} ||= "\xA2\xAE";
  $s =~ s{([\xC0-\xFF][\x80-\xBF]*)}{
    my $char = $1;  my $code = _ucode($char);  my $ret = "";
    if ($code < 0x7F) {	## G0 = ASCII
      $ret = pack("C", $code);
    } elsif ($output{jisx0201latin} && $_cp{jisx0201latin} < $code 
      && $code < $_cp{jisx0201latin_last}) {	## G0 = JIS X 0201 latin
      $ret = pack("C", $code - $_cp{jisx0201latin} + 0x21);
    } elsif ($output{jisx02081978} 
      && ($_cp{jisx02081978} < $code && $code < $_cp{jisx02081978_last})
      ) {	## G1 = JIS X 0208-1978
      my $ku = $code - $_cp{jisx02081978};
      my $ten = ($ku % 94) + 0xA1; $ku = int($ku / 94) + 0xA1;
      $ret = pack("CC", $ku, $ten);
    } elsif ($output{jisx02081983} 
      && ($_cp{jisx02081983} < $code && $code < $_cp{jisx02081983_last})
      ) {	## G1 = JIS X 0208-1983
      my $ku = $code - $_cp{jisx02081983};
      my $ten = ($ku % 94) + 0xA1; $ku = int($ku / 94) + 0xA1;
      $ret = pack("CC", $ku, $ten);
    } elsif ($output{jisx02081990} 
      && ($_cp{jisx02081990} < $code && $code < $_cp{jisx02081990_last})
      ) {	## G1 = JIS X 0208-1990 / JIS X 0208:1997
      my $ku = $code - $_cp{jisx02081990};
      my $ten = ($ku % 94) + 0xA1; $ku = int($ku / 94) + 0xA1;
      $ret = pack("CC", $ku, $ten);
    } elsif ($output{jisx02132000_1} 
    && ($_cp{jisx02132000_1} < $code && $code < $_cp{jisx02132000_1_last})
      ) {	## G1 = JIS X 0213:2000 plane 1
      my $ku = $code - $_cp{jisx02132000_1};
      my $ten = ($ku % 94) + 0xA1; $ku = int($ku / 94) + 0xA1;
      $ret = pack("CC", $ku, $ten);
    } elsif ($output{jisx0201kana} && $_cp{jisx0201kana} < $code 
      && $code < $_cp{jisx0201kana_last}) {	## G2 = JIS X 0201 katakana
      $ret = "\x8E" . pack("C", $code - $_cp{jisx0201kana} + 0xA1);
    } elsif ($output{jisx02121990} 
    && ($_cp{jisx02121990} < $code && $code < $_cp{jisx02121990_last})
      ) {	## G3 = JIS X 0213:2000 plane 2
      my $ku = $code - $_cp{jisx02121990};
      my $ten = ($ku % 94) + 0xA1; $ku = int($ku / 94) + 0xA1;
      $ret = "\x8F" . pack("CC", $ku, $ten);
    } elsif ($output{jisx02132000_2} 
    && ($_cp{jisx02132000_2} < $code && $code < $_cp{jisx02132000_2_last})
      ) {	## G3 = JIS X 0213:2000 plane 2
      my $ku = $code - $_cp{jisx02132000_2};
      my $ten = ($ku % 94) + 0xA1; $ku = int($ku / 94) + 0xA1;
      $ret = "\x8F" . pack("CC", $ku, $ten);
    } else {
      $ret = $output{undefchar};
    }
    $ret;
  }goex;
  $s;
}

=head2 internal_to_junet ($sering, [%option])

Convert internal coded string to junet coded string.

=head3 options

* g0_96
* utf8

=cut

sub internal_to_junet ($;%) {
  my $s = shift;
  #$s = \$s unless ref $s;
  my %output = @_;  my $mode = "\x1B\x28\x42";
  $output{undefchar} ||= 0x3F-0x21;
  $output{undefcharset} ||= "\x1B\x28\x42";
  $s =~ s{([\x00-\x7F]|(?:[\xC0-\xFF][\x80-\xBF]*))}{
    my $char = $1;  my $code = _ucode($char);  my $ret = "";
    if ($code < 0x9F) {	## ASCII
      $ret = _2022_putchar(\$mode => "\x1B\x28\x42", $code-0x21);
    } elsif ($code < 0xFF) {	## ISO 8859-1 right half
      $ret = _2022_putchar(\$mode => "\x1B\x2C\x41", $code-0xA0);
    } elsif ($_cp{94x1} < $code && $code < $_cp{94x1} + 94*78 -1) {
      	## 94 charsets
      my $final = pack("C", int(($code - $_cp{94x1}) / 94) + 0x30);
      $ret = _2022_putchar(\$mode => "\x1B\x28".$final,
                           ($code - $_cp{94x1}) % 94);
    } elsif ($output{g0_96}
      && $_cp{96x1} < $code && $code < $_cp{96x1} + 96*78 -1) {
      	## 96 charsets
      my $final = pack("C", int(($code - $_cp{96x1}) / 96) + 0x30);
      $ret = _2022_putchar(\$mode => "\x1B\x2C".$final,
                           ($code - $_cp{96x1}) % 96);
    } elsif ($_cp{94x2} < $code && $code < $_cp{94x2} + 94*94*78 -1) {
      	## 94x2 charsets
      my $final = pack("C", int(($code - $_cp{94x2}) / (94*94)) + 0x30);
      $ret = _2022_putchar(\$mode => "\x1B\x24\x28".$final,
                           ($code - $_cp{94x2}) % (94*94));
    } elsif ($_cp{jisx02081990} < $code
          && $code < $_cp{jisx02081990} + 94*94 -1) {
      $ret = _2022_putchar(\$mode => "\x1B\x26\x40\x1B\x24B",
                           ($code - $_cp{94x2}) % (94*94));
    } elsif ($output{utf8}) {
      $ret = _2022_putchar(\$mode => "\x1B\x25G", $char)
    } else {
      $ret = _2022_putchar(\$mode => $output{undefcharset} => $output{undefchar});
    }
    $ret;
  }goesx;
  $s .= _2022_putchar (\$mode => "\x1B\x28\x42" => '');
  $s;
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
    if (($is{multibyte} && $newmode ne "\x1B\x24\x28\x42"
                        && $newmode ne "\x1B\x24\x28\x40")
     || $is{set96} || $newmode eq "\x1B\x25G") {
    ## If it is not well-known escape sequence(s),
    ## designate ASCII for safe.
      $ret .= "\x1B\x28\x42" unless $$mode eq "\x1B\x28\x42";
    }
    if ($newmode =~ /\x1B\x24\x28([\x40-\x42])/) {
      $ret .= "\x1B\x24$1";
    } else {
      $ret .= $newmode;
    }
    $$mode = $newmode;
  }
  if (length $char) {
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
  }
  $ret;
}

sub eucjapan_to_internal ($;%) {
  my $s = shift;
  my %option = @_;
  my $year = $option{edition} || 2000;	## 1978, 1983, 1990=1997, 2000
  $option{G0start} ||= 0x21;  $option{G2start} ||= $_cp{jisx0201kana};
  if ($option{G1start} && $option{G3start}) {}
  elsif ($year < 1983)
    {$option{G1start} ||= $_cp{jisx02081978}; $option{G3start} ||= -1}
  elsif (1983 <= $year && $year < 1990)
    {$option{G1start} ||= $_cp{jisx02081983}; $option{G3start} ||= -1}
  elsif (1990 <= $year && $year < 2000)
    {$option{G1start} ||= $_cp{jisx02081990}; $option{G3start} ||= -1}
  else #elsif (2000 <= $year)
    {$option{G1start} ||= $_cp{jisx02132000_1}; $option{G3start} ||= -1}
  $s =~ s{([\x21-\x7E]|\x8E[\xA1-\xFE]|\x8F?[\xA1-\xFE][\xA1-\xFE])}{
    my $char = $1;  my $ret = "";
    if ($char =~ /[\x21-\x7E]/) {
      $ret = _u8(unpack("C", $char) - 0x21 + $option{G0start});
    } elsif ($char =~ /\x8F/) {
      my $ku = unpack("C", substr($char,1,1)) - 0xA1;
      my $ten = unpack("C", substr($char,2,1)) - 0xA1;
      if ($option{G3start} == -1) {
        if (77 <= $ku || $ku == 0 || $ku == 2 || $ku == 3 || $ku == 4
          || $ku == 7 || $ku == 11 || $ku == 12 || $ku == 13 || $ku == 14) {
          $ret = _u8($ku * 94 + $ten + $_cp{jisx02132000_2});
        } else {
          $ret = _u8($ku * 94 + $ten + $_cp{jisx02121990});
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
  $s;
}

=item M17N::Code::JA::shiftjis_to_internal ($string, [%options])

Converts string from shift-jis to internal code.

Available options:

=over 4

=item -edition => 1978 / 1983 / 1990 / 2000

Edition of double byte character set (Default: 2000)

=item -extension => [none] / cp932 / mac / imode / doti / jsky

Type of private (non official) extension  (Default: no private extensions)

=back

=cut

## G0 = 0x21-0x7E
## G1 = 0xA1-0xDE
## G2 = 0x8141-0x9FFC, 0xE041-0xEFFC
## G3 = 0xF041-0xFCFC
my %S2I;	## cache
sub shiftjis_to_internal ($;%) {
  my $s = shift;  my %o = @_;
  my $year = $o{-edition} || 2000;
  my $legacy = 0;	## legacy variants before X0213 G3
  $o{-G0start} ||= 0x21;  $o{-G1start} ||= $_cp{jisx0201kana};
  if ($o{-G2start} && $o{-G3start}) {}
  elsif ($year < 1983)
    {$o{-G2start} ||= $_cp{jisx02081978}; $o{-G3start} ||= $_cp{jisx02132000_2}}
  elsif (1983 <= $year && $year < 1990)
    {$o{-G2start} ||= $_cp{jisx02081983}; $o{-G3start} ||= $_cp{jisx02132000_2}}
  elsif (1990 <= $year && $year < 2000)
    {$o{-G2start} ||= $_cp{jisx02081990}; $o{-G3start} ||= $_cp{jisx02132000_2}}
  else #elsif (2000 <= $year)
    {$o{-G2start} ||= $_cp{jisx02132000_1}; $o{-G3start} ||= $_cp{jisx02132000_2}}
  if ($o{-extension} eq 'imode' || $o{-extension} eq 'doti') {
    $o{-G3start} = $_cp{x_imode_doti}; $legacy = 1;
  }
  $s =~ s{
  	  ([\x21-\x7E])
  	| ([\x81-\x9F\xE0-\xEF][\x40-\x7E\x80-\xFC])
  	| ([\xF0-\xFC][\x40-\x7E\x80-\xFC])
  	| ([\xA1-\xDF])
  	| ([\x80-\xFF])
  }{
    my ($g0, $g2, $g3, $g1, $broken) = ($1, $2, $3, $4, $5);
    my $ret = '';
    if ($g0) {
      $S2I{$g0}->{$o{-G0start}} = _u8(unpack('C', $g0) - 0x21 + $o{-G0start})
        unless $S2I{$g0}->{$o{-G0start}};
      $ret = $S2I{$g0}->{$o{-G0start}};
    } elsif ($g2) {
      unless ($S2I{$g2}->{$o{-G2start}}) {
        my ($f, $s) = unpack ('CC', $g2);
        if (0x9E < $s) {
          $f = $f * 2 - ($f >= 0xE0 ? 0x181 : 0x101);  $s -= 0x9F;
        } else {
          $f = $f * 2 - ($f >= 0xE0 ? 0x182 : 0x102);  $s -= 0x40 + ($s > 0x7F);
        }
        $S2I{$g2}->{$o{-G2start}} = _u8 ($f * 94 + $s + $o{-G2start});
      }
      $ret = $S2I{$g2}->{$o{-G2start}};
    } elsif ($g3) {
      unless ($S2I{$g3}->{$o{-G3start}}) {
        my ($f, $s) = unpack ('CC', $g3);
        if ($legacy) {
          $s -= 0x40 + ($s > 0x7F);
          $S2I{$g3}->{$o{-G3start}} = _u8 (($f - 0xF0) * 188 + $s + $o{-G3start});
        } else {	## X0213
          if (0x9F <= $s) {
            $f = $SJIS_G3_to_KUe{$f};  $s -= 0x9F;
          } else {
            $f = $SJIS_G3_to_KUo{$f};  $s -= 0x40 + ($s > 0x7F);
          }
          $S2I{$g3}->{$o{-G3start}} = _u8 ($f * 94 + $s + $o{-G3start});
        }
      }
      $ret = $S2I{$g3}->{$o{-G3start}};
    } elsif ($g1) {
      $S2I{$g1}->{$o{-G1start}} = _u8(unpack('C', $g1) - 0xA1 + $o{-G1start})
        unless $S2I{$g1}->{$o{-G1start}};
      $ret = $S2I{$g1}->{$o{-G1start}};
    }
    $ret;
  }gex;
  $s;
}

=item $s = M17N::Code::JA::internal_to_shiftjis ($s, [%options])

Converts internal coded string to shift-jis coded string.

=cut

my (%_I2S_1, %_I2S_2, %_I2S_2L, %_I2S);	## caches
sub internal_to_shiftjis ($;%) {
  my $s = shift;  my %o = @_;
  my $year = $o{-edition};	## 0 (= all unify), 1983, 1990 = 1997, 2000
  $o{-x0201_latin} ||= 1;  $o{-x0201_katakana} ||= 1;
  $o{-x0208_78} = 1 if $year < 1983;
  $o{-x0208_83} = 1 if !$year || (1983 <= $year && $year < 1990);
  $o{-x0208_90} = 1 if !$year || (1990 <= $year && $year < 2000);
  if (!$year || ($year >= 2000)) {
    $o{-x0213_A0_1} = 1; $o{-x0213_A0_2} = 1;
  }
  if ($o{-extension}) {	## one of private extensions
    $o{-x0213_A0_2} = 0;  $o{ '-' . $o{-extension} } = 1;
  }
  $o{-undefchar} ||= "\x81\xAC";
  $s =~ s{([\xC0-\xFF][\x80-\xBF]*)}{
    my ($code, $ret) = (_ucode($1), '');
    #if ($code < 0x7F) {	## G0 = ASCII
    #  $ret = pack("C", $code);
    #} els
    if ($o{-x0201_latin}
      && $_cp{jisx0201latin} <= $code && $code < $_cp{jisx0201latin_last}) {
      $_I2S{$code} = pack("C", $code - $_cp{jisx0201latin} + 0x21)
        unless $_I2S{$code};
      $ret = $_I2S{$code};
    } elsif ($o{-x0208_78} 
      && $_cp{jisx02081978} <= $code && $code < $_cp{jisx02081978_last}) {
      $code -= $_cp{jisx02081978};
      unless ($_I2S_1{$code}) {
        my ($c1, $c2) = (int($code / 94) + 0x21, ($code % 94) + 0x21);
        $_I2S_1{$code} = pack('CC', (($c1 - 1) >> 1) + ($c1 < 0x5F ? 0x71 : 0xb1),
               $c2 + (($c1 & 1) ? ($c2 < 0x60 ? 0x1F : 0x20) : 0x7E));
      }
      $ret = $_I2S_1{$code};
    } elsif ($o{-x0208_83} 
      && $_cp{jisx02081983} <= $code && $code < $_cp{jisx02081983_last}) {
      $code -= $_cp{jisx02081983};
      unless ($_I2S_1{$code}) {
        my ($c1, $c2) = (int($code / 94) + 0x21, ($code % 94) + 0x21);
        $_I2S_1{$code} = pack('CC', (($c1 - 1) >> 1) + ($c1 < 0x5F ? 0x71 : 0xb1),
               $c2 + (($c1 & 1) ? ($c2 < 0x60 ? 0x1F : 0x20) : 0x7E));
      }
      $ret = $_I2S_1{$code};
    } elsif ($o{-x0208_90} 
      && $_cp{jisx02081990} <= $code && $code < $_cp{jisx02081990_last}) {
      $code -= $_cp{jisx02081990};
      unless ($_I2S_1{$code}) {
        my ($c1, $c2) = (int($code / 94) + 0x21, ($code % 94) + 0x21);
        $_I2S_1{$code} = pack('CC', (($c1 - 1) >> 1) + ($c1 < 0x5F ? 0x71 : 0xb1),
               $c2 + (($c1 & 1) ? ($c2 < 0x60 ? 0x1F : 0x20) : 0x7E));
      }
      $ret = $_I2S_1{$code};
    } elsif ($o{-x0213_A0_1} 
    && $_cp{jisx02132000_1} <=$code && $code < $_cp{jisx02132000_1_last}) {
      $code -= $_cp{jisx02132000_1};
      unless ($_I2S_1{$code}) {
        my ($c1, $c2) = (int($code / 94) + 0x21, ($code % 94) + 0x21);
        $_I2S_1{$code} = pack('CC', (($c1 - 1) >> 1) + ($c1 < 0x5F ? 0x71 : 0xb1),
               $c2 + (($c1 & 1) ? ($c2 < 0x60 ? 0x1F : 0x20) : 0x7E));
      }
      $ret = $_I2S_1{$code};
    } elsif ($o{-x0201_katakana}
      && $_cp{jisx0201kana} <= $code && $code < $_cp{jisx0201kana_last1}) {
      $_I2S{$code} = pack("C", $code - $_cp{jisx0201kana} + 0xA1)
        unless $_I2S{$code};
      $ret = $_I2S{$code};
    } elsif ($o{-x0213_A0_2} 
      && ($_cp{jisx02132000_2} <= $code && $code < $_cp{jisx02132000_2_last})) {
      $code -= $_cp{jisx02132000_2};
      unless ($_I2S_2{$code}) {
        my ($c1, $c2) = (int($code / 94), ($code % 94) + 0x21);
        $_I2S_2{$code} = pack('CC', $_KU_to_SJIS_G3{ $c1 },
               $c2 + (($c1 & 1) ? 0x7E : ($c2 < 0x60 ? 0x1F : 0x20)));
      }
      $ret = $_I2S_2{$code};
    } elsif ($o{-imode} && $_cp{x_imode} <= $code && $code < $_cp{x_imode_last}) {
      $code -= $_cp{x_imode_doti};
      unless ($_I2S_2L{$code}) {
        my $c2 = $code % 188;  $_I2S_2L{$code} = pack('CC',
          int($code / 188) + 0xF0, $c2 + ($c2 > 0x3E ? 0x41 : 0x40));
      }
      $ret = $_I2S_2L{$code};
    } elsif ($o{-doti} && $_cp{x_doti} <= $code && $code < $_cp{x_doti_last}) {
      $code -= $_cp{x_imode_doti};
      unless ($_I2S_2L{$code}) {
        my $c2 = $code % 188;  $_I2S_2L{$code} = pack('CC',
          int($code / 188) + 0xF0, $c2 + ($c2 > 0x3E ? 0x41 : 0x40));
      }
      $ret = $_I2S_2L{$code};
    } else {
      $ret = $o{-undefchar};
    }
    $ret;
  }goex;
  $s;
}

=head1 SEE ALSO

=over 4

=item ASTEL Emoji

<http://www.ttnet.co.jp/tokyodenwa_astel/doti/siyou/emoji.htm>

=back

=head1 LICENSE

This program is free software; you can redistribute it and/or 
modify it under the same terms as Perl itself.

=head1 CHANGE

See F<ChangeLog>.
$Date: 2002/07/20 08:49:09 $

=cut

1;
