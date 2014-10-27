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
	saxon $< $(stylesheet) > $@

%.redxml: %.xml $(reduction)
	saxon $< $(reduction) > $@

%.txt: %.redxml
	$(xml2rfc) $< $@

%.unpg.txt: %.redxml
	$(xml2rfc) $< $@.unpg
	mv $@.unpg $@

%.xhtml: %.xml ../../rfc2629xslt/rfc2629toXHTML.xslt
	$(saxon) $< ../../rfc2629xslt/rfc2629toXHTML.xslt > $@
