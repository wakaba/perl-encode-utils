PERL = perl
PERLINC = ../../
PERLOPTION = -I$(PERLINC)
ESR2PM = ../Table/tool/esr2pm.pl

PMS = SevenBit.pm JUNET.pm JUNETCompatible.pm \
  EightBit.pm \
  EUCJA.pm EUCJACompatible.pm EUCKR.pm EUCZH.pm \
  JIS.pm \
  Pictogram.pm

all: $(PMS)

%.pm: %.esr $(ESR2PM)
	$(PERL) $(PERLOPTION) $(ESR2PM) $< > $@
	$(PERL) -c $@

clean:
	rm -v $(PMS)
