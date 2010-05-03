## This file is auto-generated (at 2010-05-03T06:00:09Z).
## Do not edit by hand!

=head1 NAME

Encode::Table::iso_ir_169 --- Convertion tables
used with Encode::Table, C<iso_ir_169_to_ucs>
and C<ucs_to_iso_ir_169>

=head1 TABLES

=over 4

=item iso_ir_169_to_ucs

Convertion table of iso_ir_169 -> ucs

=item ucs_to_iso_ir_169

Convertion table of ucs -> iso_ir_169

=back

=head1 SEE ALSO

Encode::Table

=head1 LICENSE

See source table of this module.  (It may be named as
C<iso_ir_169.tbr>.)

=cut

package Encode::Table::iso_ir_169;
use strict;
our $VERSION = q(2010.0503);

## These tables are embeded in binary, so that your editor
## might break the data or might hang up.









#

our %L2U = map {Encode::_utf8_on ($_) if length $_ > 1; $_} unpack
(q{a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a1a5a2a5a2a5a2a5a3a5a3a5a3a5a3a5a3a5a3a5a2a5a3a5a3a5a3a5a1a5a1a5a3a5a3a5a3a5a1a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a1a5a3a5a3a5a1a5a1a5a3a5a1a5a3a5a3a5a1a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a3a5a1}, <<'END');
¯ªé∏ò ¯ªé∏ö!¯ªé∏õ%¯ªé∏ú?¯ªé∏ù.¯ªé∏û,¯ªé∏ü:¯ªé∏ß0¯ªé∏®1¯ªé∏©2¯ªé∏™3¯ªé∏´4¯ªé∏¨5¯ªé∏≠6¯ªé∏Æ7¯ªé∏Ø8¯ªé∏∞9¯ªéªîÀÑ¯ªéªïÀÉ¯ªéªôÀÖ¯ªèé¨Ôπ¢¯ªèéª‚áâ¯ªèèë‚à†¯ªèêô‚áÑ¯ªèêú‚Üê¯ªèëâ‚Ü¶¯ªèëéÀñ¯ªèíÄ‚ó´¯ªèì°‚ñ∑¯ªèï∂‚ñ≥¯ªèóé˜¯ªèóî$¯ªèóö‚Üì¯ªèóõ‚Üô¯ªèóú‚Üò¯ªèó∫_¯ªèòõ‚ñ°¯ªèôü‚ô°¯ªèô°‚ñ∂¯ªèöü‚Üí¯ªèü°‚úâ¯ªè°ì‚àí¯ªè°Æ‚äø¯ªè°∏◊¯ªè£π‚à•¯ªè•û‚ó≥¯ªè¶®>¯ªè¶π<¯ªèßö‚óé¯ªè®Ä=¯ªè™É‚Äæ¯ªè´ñ‚ú°¯ªè´ó*¯ªè¨á‚óã¯ªè≠´‚Üõ¯ªèØå‚Üë¯ªèØç‚áÖ¯ªèØè‚Üñ¯ªèØê‚Üó¯ªè∞å„Äú¯ªè∞†Ôπñ¯ªè±†•
END
our %U2L = reverse %L2U;
sub import {
  $Encode::Table::TABLE{iso_ir_169_to_ucs} = \%L2U;
  $Encode::Table::TABLE{ucs_to_iso_ir_169} = \%U2L;
}
1;
### iso_ir_169.pm ends here
