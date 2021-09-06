SOURCE_ADOC = $(wildcard *.adoc)

DEFAULT_PDF = $(subst .adoc,.pdf,$(SOURCE_ADOC))
DOCBOOK_XML = $(subst .adoc,.xml,$(SOURCE_ADOC))
LATEX_PDF   = $(subst .adoc,_latex.pdf,$(SOURCE_ADOC))

all: $(DEFAULT_PDF) $(DOCBOOK_XML) $(LATEX_PDF)

# Require Asciidoctor-PDF extension
%.pdf: %.adoc
	asciidoctor --require asciidoctor-pdf --backend pdf --out-file $@ $<

%.xml: %.adoc
	asciidoctor --backend docbook5 --out-file $@ $<

# Require DBLaTeX and intermediate DocBook XML
%_latex.pdf: %.xml
	dblatex --output=$@ $<

clean:
	-rm -f $(DEFAULT_PDF)
	-rm -f $(DOCBOOK_XML)
	-rm -f $(LATEX_PDF)

.PHONY: all clean
