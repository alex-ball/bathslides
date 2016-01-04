The bathslides class: University of Bath presentations
=========================================================

The bathslides LaTeX class is intended to produce slides for University
of Bath presentations, or an accompanying transcript, or both.
It is based on the beamer class.

Installation
------------

### Pre-requisites ###

You should be able to extract the class file using only the base
tools of a TeX installation, but in order for the documentation to be
typeset correctly, you will need to have the image files
`uob-logo-grey-transparent.pdf` (for PDF) and
`uob-logo-grey-transparent.eps` (for DVI) somewhere TeX can find them.
I recommend you place them in the same folder as `bathslides.dtx`
while compiling the class and in a `tex/generic/logos-ubath` folder
thereafter.

You can download `uob-logo-grey-transparent.eps` from the
[University of Bath website][logo]. To get the PDF version, run
`epstopdf uob-logo-grey-transparent.eps`. The `epstopdf` utility is
available in most TeX distributions.

The documentation uses fonts from the XCharter and sourcesanspro
packages, as well as sourcecodepro if XeLaTeX or LuaLaTeX is used,
or zi4 (inconsolata) otherwise.

### Automated way ###

A makefile is provided which you can use with the Make utility:

  * Running `make` generates the derived files

      - README.md
      - bathslides.pdf
      - bathslides-slides.pdf
      - bathslides.cls

    It also downloads `uob-logo-grey-transparent.eps` using `wget` and
    generates `uob-logo-grey-transparent.pdf` using `epstopdf`.

  * Running `make inst` installs the files (and images) in the user's
    TeX tree.
  * Running `make install` installs the files (and images) in the
    local TeX tree.

The makefile is set up to use latexmk and lualatex by default.
If this causes difficulty you could change it to use pdflatex directly
instead.

### Manual way ###

 1. Compile bathslides.dtx just as you would a normal LaTeX file. As well
    as the usual PDF (or DVI) and auxiliary files, several others are
    generated.

 2. Compile bathslides.dtx a second time with `-jobname=bathslides-slides`
    as a command line option to generate the sample slides.

 3. Move the files to your TeX tree as follows:

      - `source/latex/bathslides`: bathslides.dtx, bathslides.ins
      - `tex/latex/bathslides`: bathslides.cls, and (optionally) the
        separately available image files as noted above
      - `doc/latex/bathslides`: bathslides.pdf, bathslides-slides.pdf,
         README.md

 4. You may then have to update your installation's file name database
    before TeX and friends can see the files.

Licence
-------

Copyright 2015 Alex Ball.

This work consists of the documented LaTeX file bathslides.dtx,
and a Makefile.

The text files contained in this work may be distributed and/or modified
under the conditions of the [LaTeX Project Public License (LPPL)][lppl],
either version 1.3c of this license or (at your option) any later
version.

This work is "maintained" (as per LPPL maintenance status) by [Alex
Ball][me].

[logo]: http://www.bath.ac.uk/marketing/guides-assets/visual-identity/logo/#id4
[lppl]: http://www.latex-project.org/lppl.txt
[me]: http://alexball.me.uk/

