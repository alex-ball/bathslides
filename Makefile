NAME  = bathslides
SHELL = bash
PWD   = $(shell pwd)
TEMP := $(shell mktemp -d -t tmp.XXXXXXXXXX)
TDIR  = $(TEMP)/$(NAME)
VERS  = $(shell ltxfileinfo -v $(NAME).dtx)
LOCAL = $(shell kpsewhich --var-value TEXMFLOCAL)
UTREE = $(shell kpsewhich --var-value TEXMFHOME)
WORKMF = "/home/ab318/Data/TeX/workmf"
all:	$(NAME).pdf $(NAME)-slides.pdf clean
	exit 0
$(NAME).pdf: $(NAME).dtx
	latexmk -silent -lualatex -synctex=1 -interaction=batchmode $(NAME).dtx >/dev/null
$(NAME).cls: $(NAME).dtx
	lualatex -synctex=1 -interaction=batchmode $(NAME).dtx >/dev/null
$(NAME)-slides.pdf: $(NAME).dtx $(NAME).cls
	latexmk -silent -lualatex -synctex=1 -interaction=batchmode -jobname=$(NAME)-slides $(NAME).dtx >/dev/null
clean:
	rm -f $(NAME).{aux,bbl,bcf,blg,doc,fdb_latexmk,fls,glo,gls,hd,idx,ilg,ind,listing,log,nav,out,run.xml,snm,synctex.gz,toc,vrb}
	rm -f $(NAME)-slides.{aux,bbl,bcf,blg,doc,fdb_latexmk,fls,glo,gls,hd,idx,ilg,ind,ins,listing,log,nav,out,run.xml,snm,synctex.gz,toc,vrb}
distclean: clean
	rm -f $(NAME).{pdf,ins} $(NAME)-slides.pdf $(NAME).cls
inst: all
	mkdir -p $(UTREE)/{tex,source,doc}/latex/$(NAME)
	cp $(NAME).dtx $(NAME).ins $(UTREE)/source/latex/$(NAME)
	cp $(NAME).cls $(UTREE)/tex/latex/$(NAME)
	cp $(NAME).pdf $(NAME)-slides.pdf README.md $(UTREE)/doc/latex/$(NAME)
install: all
	sudo mkdir -p $(LOCAL)/{tex,source,doc}/latex/$(NAME)
	cp $(NAME).dtx $(NAME).ins $(LOCAL)/source/latex/$(NAME)
	cp $(NAME).cls $(LOCAL)/tex/latex/$(NAME)
	cp $(NAME).pdf $(NAME)-slides.pdf README.md $(LOCAL)/doc/latex/$(NAME)
workmf: all
	mkdir -p $(WORKMF)/{tex,source,doc}/latex/$(NAME)
	cp $(NAME).dtx $(NAME).ins $(WORKMF)/source/latex/$(NAME)
	cp $(NAME).cls $(WORKMF)/tex/latex/$(NAME)
	cp $(NAME).pdf $(NAME)-slides.pdf README.md $(WORKMF)/doc/latex/$(NAME)
zip: all
	mkdir $(TDIR)
	cp $(NAME).{pdf,dtx} $(NAME)-slides.pdf $(NAME).cls README.md Makefile $(TDIR)
	cd $(TEMP); zip -Drq $(PWD)/$(NAME)-$(VERS).zip $(NAME)
