.PHONY: all format slides.tex clean

TEX := slides.tex
PDF := $(patsubst %.tex,pdf/%.pdf,$(TEX))

all: format $(PDF)

pdf/:
	mkdir -p $@

pdf/%.pdf: %.tex cryptobib/abbrev3.bib cryptobib/crypto.bib | pdf/
	BIBINPUTS="$(CURDIR):" rubber --pdf --into pdf $<

format: $(TEX)
	nix-shell -p tex-fmt --run "tex-fmt $<" 2>/dev/null

clean:
	-$(RM) -r pdf/
