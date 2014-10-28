xml2rfc = "../xml2rfc/xml2rfc.tcl"

stylesheet = rfc2629.xslt
reduction  = clean-for-DTD.xslt

TARGETS = draft-reschke-objsec-latest.html \
          draft-reschke-objsec-latest.redxml \
          draft-reschke-objsec-latest.unpg.txt \
          draft-reschke-objsec-latest.txt

all: $(TARGETS)

clean:
	rm -f $(TARGETS)

%.html: %.xml $(stylesheet)
	xsltproc $(stylesheet) $< > $@

%.redxml: %.xml $(reduction)
	xsltproc $(reduction) $< > $@

%.txt: %.redxml
	$(xml2rfc) $< $@

%.unpg.txt: %.redxml
	$(xml2rfc) $< $@.unpg
	mv $@.unpg $@
