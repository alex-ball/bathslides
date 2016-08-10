NAME  = bathslides
SHELL = bash
PWD   = $(shell pwd)
TEMP := $(shell mktemp -d -t tmp.XXXXXXXXXX)
TDIR  = $(TEMP)/$(NAME)
VERS  = $(shell ltxfileinfo -v $(NAME).dtx)
LOCAL = $(shell kpsewhich --var-value TEXMFLOCAL)
UTREE = $(shell kpsewhich --var-value TEXMFHOME)
all:	uob-logo-grey-transparent.eps uob-logo-grey-transparent.pdf $(NAME).pdf $(NAME)-slides.pdf clean
	@exit 0
$(NAME).cls: $(NAME).dtx
	lualatex -synctex=1 -interaction=batchmode $(NAME).dtx >/dev/null
$(NAME).pdf: $(NAME).cls
	latexmk -silent -lualatex -synctex=1 -interaction=batchmode $(NAME).dtx >/dev/null
$(NAME)-slides.pdf: $(NAME).cls
	latexmk -silent -lualatex -synctex=1 -interaction=batchmode -jobname=$(NAME)-slides $(NAME).dtx >/dev/null
uob-logo-grey-transparent.eps:
	wget http://www.bath.ac.uk/marketing/images/logos/eps/uob-logo-grey-transparent.eps
uob-logo-grey-transparent.pdf: uob-logo-grey-transparent.eps
	epstopdf uob-logo-grey-transparent.eps
clean:
	rm -f $(NAME).{aux,bbl,bcf,blg,doc,fdb_latexmk,fls,glo,gls,hd,idx,ilg,ind,listing,log,nav,out,run.xml,snm,synctex.gz,toc,vrb}
	rm -f $(NAME)-slides.{aux,bbl,bcf,blg,doc,fdb_latexmk,fls,glo,gls,hd,idx,ilg,ind,ins,listing,log,nav,out,run.xml,snm,synctex.gz,toc,vrb}
distclean: clean
	rm -f $(NAME).{pdf,ins} $(NAME)-slides.pdf $(NAME).cls bathcolors.sty beamerthemeBath.sty
inst: all
	mkdir -p $(UTREE)/{tex,source,doc}/latex/$(NAME)
	mkdir -p $(UTREE)/tex/generic/logos-ubath
	cp $(NAME).dtx $(NAME).ins $(UTREE)/source/latex/$(NAME)
	cp $(NAME).cls bathcolors.sty beamerthemeBath.sty $(UTREE)/tex/latex/$(NAME)
	cp $(NAME).pdf $(NAME)-slides.pdf README.md $(UTREE)/doc/latex/$(NAME)
	cp uob-logo-grey-transparent.{eps,pdf} $(UTREE)/tex/generic/logos-ubath
	mktexlsr
uninst:
	rm -r $(UTREE)/{tex,source,doc}/latex/$(NAME)
	rm $(UTREE)/tex/generic/logos-ubath/uob-logo-grey-transparent.{eps,pdf}
	rmdir --ignore-fail-on-non-empty $(UTREE)/tex/generic/logos-ubath
	mktexlsr
install: all
	sudo mkdir -p $(LOCAL)/{tex,source,doc}/latex/$(NAME)
	sudo mkdir -p $(LOCAL)/tex/generic/logos-ubath
	sudo cp $(NAME).dtx $(NAME).ins $(LOCAL)/source/latex/$(NAME)
	sudo cp $(NAME).cls bathcolors.sty beamerthemeBath.sty $(LOCAL)/tex/latex/$(NAME)
	sudo cp $(NAME).pdf $(NAME)-slides.pdf README.md $(LOCAL)/doc/latex/$(NAME)
	sudo cp uob-logo-grey-transparent.{eps,pdf} $(LOCAL)/tex/generic/logos-ubath
	mktexlsr
uninstall:
	sudo rm -r $(LOCAL)/{tex,source,doc}/latex/$(NAME)
	sudo rm $(LOCAL)/tex/generic/logos-ubath/uob-logo-grey-transparent.{eps,pdf}
	sudo rmdir --ignore-fail-on-non-empty $(LOCAL)/tex/generic/logos-ubath
	mktexlsr
zip: all
	mkdir $(TDIR)
	cp $(NAME).{pdf,dtx} $(NAME)-slides.pdf $(NAME).cls bathcolors.sty beamerthemeBath.sty README.md Makefile $(TDIR)
	cd $(TEMP); zip -Drq $(PWD)/$(NAME)-$(VERS).zip $(NAME)
