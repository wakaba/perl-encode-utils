PERL = perl
PERLINC = ../../
PERLOPTION = -I$(PERLINC)
ESR2PM = ../../../bin/esr2pm.pl

PMS = JIS.pm JISCompatible.pm Pictogram.pm

all: $(PMS)

%.pm: %.esr $(ESR2PM)
	$(PERL) $(PERLOPTION) $(ESR2PM) $< > $@
	$(PERL) -c $@

clean:
	rm -v $(PMS)
