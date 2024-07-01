NAME  = bathslides
SHELL = bash
PWD   = $(shell pwd)
TEMP := $(shell mktemp -d -t tmp.XXXXXXXXXX)
TDIR  = $(TEMP)/$(NAME)
VERS  = $(shell ltxfileinfo -v $(NAME).dtx)
LOCAL = $(shell kpsewhich --var-value TEXMFLOCAL)
UTREE = $(shell kpsewhich --var-value TEXMFHOME)

.PHONY: clean dist-clean inst install uninst uninstall zip

all:	$(NAME).pdf $(NAME)-slides.pdf clean
	@exit 0
$(NAME).cls $(NAME).ins $(NAME)-sample-Bath.tex $(NAME)-sample-Bath2021.tex bathcolors.sty beamerthemeBath.sty beamerthemeBath2021.sty: $(NAME).dtx
	etex -interaction=batchmode $(NAME).dtx >/dev/null
$(NAME)-sample-Bath.pdf: $(NAME)-sample-Bath.tex $(NAME).cls uob-logo-grey-transparent.pdf
	latexmk -silent -lualatex -shell-escape -interaction=batchmode $< >/dev/null
$(NAME)-sample-Bath2021.pdf: $(NAME)-sample-Bath2021.tex $(NAME).cls uob-logo-white-transparent.pdf
	latexmk -silent -lualatex -shell-escape -interaction=batchmode $< >/dev/null
$(NAME).pdf: $(NAME).dtx $(NAME)-sample-Bath.pdf $(NAME)-sample-Bath2021.pdf
	latexmk -silent -lualatex -synctex=1 -shell-escape -interaction=batchmode $(NAME).dtx >/dev/null
$(NAME)-slides.pdf: $(NAME).dtx $(NAME)-sample-Bath.pdf $(NAME)-sample-Bath2021.pdf
	latexmk -silent -lualatex -synctex=1 -shell-escape -interaction=batchmode -jobname=$(NAME)-slides $(NAME).dtx >/dev/null
uob-logo-grey-transparent.eps uob-logo-white-transparent.eps:
	gs -sDEVICE=eps2write -o $@ -g285x116 -r95 -dBATCH
uob-logo-%-transparent.pdf: uob-logo-%-transparent.eps
	epstopdf $<
clean:
	rm -f $(NAME).{aux,bbl,bcf,blg,doc,fdb_latexmk,fls,glo,gls,hd,idx,ilg,ind,listing,log,nav,out,run.xml,snm,synctex.gz,tcbtemp,toc,vrb}
	rm -f $(NAME)-{slides,sample-Bath,sample-Bath2021}.{aux,bbl,bcf,blg,doc,fdb_latexmk,fls,glo,gls,hd,idx,ilg,ind,ins,listing,log,nav,out,run.xml,snm,synctex.gz,tcbtemp,toc,vrb}
	rm -f bathcolors.doc beamerthemeBath.doc
	rm -rf _minted-*
distclean: clean
	rm -f $(NAME).{pdf,ins} $(NAME)-slides.pdf $(NAME).cls bathcolors.sty beamertheme{Bath,Bath2021}.sty $(NAME)-sample-{Bath,Bath2021}.{tex,pdf}
inst: all
	mkdir -p $(UTREE)/{tex,source,doc}/latex/$(NAME)
	mkdir -p $(UTREE)/tex/generic/logos-ubath
	cp $(NAME).dtx $(NAME).ins $(UTREE)/source/latex/$(NAME)
	cp $(NAME).cls bathcolors.sty beamertheme{Bath,Bath2021}.sty $(UTREE)/tex/latex/$(NAME)
	cp $(NAME).pdf $(NAME)-sample-{Bath,Bath2021}.{tex,pdf} $(NAME)-slides.pdf README.md $(UTREE)/doc/latex/$(NAME)
	cp uob-logo-{grey,white}-transparent.{eps,pdf} $(UTREE)/tex/generic/logos-ubath
	mktexlsr
uninst:
	rm -r $(UTREE)/{tex,source,doc}/latex/$(NAME)
	rm $(UTREE)/tex/generic/logos-ubath/uob-logo-{grey,white}-transparent.{eps,pdf}
	rmdir --ignore-fail-on-non-empty $(UTREE)/tex/generic/logos-ubath
	mktexlsr
install: all
	sudo mkdir -p $(LOCAL)/{tex,source,doc}/latex/$(NAME)
	sudo mkdir -p $(LOCAL)/tex/generic/logos-ubath
	sudo cp $(NAME).dtx $(NAME).ins $(LOCAL)/source/latex/$(NAME)
	sudo cp $(NAME).cls bathcolors.sty beamertheme{Bath,Bath2021}.sty $(LOCAL)/tex/latex/$(NAME)
	sudo cp $(NAME).pdf $(NAME)-sample-{Bath,Bath2021}.{tex,pdf} $(NAME)-slides.pdf README.md $(LOCAL)/doc/latex/$(NAME)
	sudo cp uob-logo-{grey,white}-transparent.{eps,pdf} $(LOCAL)/tex/generic/logos-ubath
	mktexlsr
uninstall:
	sudo rm -r $(LOCAL)/{tex,source,doc}/latex/$(NAME)
	sudo rm $(LOCAL)/tex/generic/logos-ubath/uob-logo-{grey,white}-transparent.{eps,pdf}
	sudo rmdir --ignore-fail-on-non-empty $(LOCAL)/tex/generic/logos-ubath
	mktexlsr
zip: all
	mkdir $(TDIR)
	cp $(NAME).{pdf,dtx} $(NAME)-slides.pdf $(NAME).cls bathcolors.sty beamertheme{Bath,Bath2021}.sty $(NAME)-sample-{Bath,Bath2021}.{tex,pdf} README.md Makefile $(TDIR)
	cd $(TEMP); zip -Drq $(PWD)/$(NAME)-$(VERS).zip $(NAME)
