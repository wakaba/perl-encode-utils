PERL = perl
PERLINS = ../../
PERLOPTION = -I$(PERLINS)
ESR2PM = ../Table/tool/esr2pm.pl

all: JISCompatible.pm

%.pm: %.esr $(ESR2PM)
	$(PERL) $(PERLOPTION) $(ESR2PM) $< > $@
